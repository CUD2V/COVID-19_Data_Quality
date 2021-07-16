BEGIN
   --"temp_covid_scratch."
   --"omop_covid19"
  declare cdmSchema string default cdm_schema;
  declare visitStartDateFilter datetime DEFAULT '2020-01-01';
  declare minAgeAtVisit int64 DEFAULT 18;
  declare minDayDiff int64 DEFAULT -21;
  declare maxDayDiff int64 DEFAULT 0;
   
  CALL omop_covid19_kratos.sp_r2d2_identify_patients(cdm_schema, 'r2d2_covid');
  
  EXECUTE IMMEDIATE """
  CREATE TEMP TABLE covid_pos as
  SELECT person_id, cohort_start_date, concept_id, source_value
  from r2d2_covid
  """;
  
  EXECUTE IMMEDIATE replace("""CREATE TEMP TABLE ip_visit_concepts as
  select *
	from cdm_schema.concept 
	where concept_id in (262,8717,8913,8971,9201,32037,32254,32760,581379,581383,581384,38004270,38004274,38004275,38004276,38004277,38004278,38004279,38004280,38004281,38004282,38004283,38004284,38004285,38004286,38004287,38004288,38004290,38004291,38004515)
  """, "cdm_schema", cdm_schema);
  
  
 
  EXECUTE IMMEDIATE replace("""
  CREATE TEMP TABLE deceased_concepts as
  select *
	from cdm_schema.concept 
  where concept_id in (4289171,4239459,4152823,4060687,3435639,441413,36715062,442605,3050986,42573014,4252573,3444298,443882,4302017,763387,762991,4086475,4302158,1314532,4061268,4221284,4178886,432507,42574217,4277909,4277188,764068,45763722,438331,443280,763811,4071603,4063309,4028785,42600162,4083741,40480476,4337939,42573038,4216441,762986,441139,42573357,4086968,40757987,40757985,4164280,4170971,4205519,4122053,36305630,42600310,4083738,45890698,42574264,40757986,4216643,443695,4192271,42573352,763382,4101391,1314528,4027679,4028786,443281,1314519,764069,4323052,4155383,4145919,4276823,4118030,4171902,436228,36717396,4048142,763384,45771271,3436784,4086473,42600309,762990,4220022,42600074,762987,1314489,4019847,764465,4301926,441200,42573355,4135942,442329,4183699,4102452,44789839,4195245,4233376,42599367,4239540,4190316,4083737,4162707,4102691,3428541,4136880,4024541,4253807,4170711,40492796,4296873,4167237,4059646,4145391,4297089,4129846,442289,42538188,4177807,763386,4198985,4253661,40492790,762988,440925,40485992,4059789,4171903,4244279,40757988,763383,4126313,4306655,40760375,4238527,4231144,4321590,44791186,4244718,4079844,4065742,45770448,4030405,4307303,3439490,36306117,4049737,42598845,4206035,4081608,32221,44811215,4282320,4097521,4252891,4194377,4344630,4280210,36304910,4210315,435174,4078912,44786461,4132309,4305323,36303617,4197586,4218686,3050047,40760319,1314522,4178679,3185356,1314525,4052866,763388,4187334,44806941,442338,37395455,4053707,4034158,4062254,4173168,4073388,36204579,44784548,44784549,4195755,4253799,1314487,4151597,4023152,44786465,37395454,3050664,36204580,4193123,32218,4259007,44810218,4028784,44814686,4179191,4178604,435148,4079843,4178885,4191032,4077917) 
  """, "cdm_schema", cdm_schema);

  EXECUTE IMMEDIATE replace("""
  CREATE TEMP TABLE deceased as
  SELECT DISTINCT m.*
  FROM covid_pos cp
  JOIN (
  	SELECT DISTINCT person_id
  		,NULL visit_occurrence_id
      ,NULL concept_id
  		,cast(death_date AS DATETIME) AS death_datetime
  	FROM cdm_schema.death
  	
  	UNION DISTINCT
  	
  	SELECT DISTINCT person_id
      ,visit_occurrence_id
  		,discharge_to_concept_id concept_id
  		,coalesce(cast(visit_end_datetime AS DATETIME), cast(visit_end_date as DATETIME)) AS visit_end_datetime
  	FROM cdm_schema.visit_occurrence
  	WHERE discharge_to_concept_id IN (
  			SELECT concept_id
  			FROM deceased_concepts
  			) -- deceased status from discharge disposition
  	
--  	UNION DISTINCT
--  
--  	SELECT DISTINCT person_id
--      ,visit_occurrence_id
--  		,observation_concept_id concept_id
--  		,coalesce(cast(observation_datetime AS DATETIME), cast(observation_date as DATETIME)) observation_datetime
--  	FROM cdm_schema.observation
--  	WHERE observation_concept_id IN (
--  			SELECT concept_id
--  			FROM deceased_concepts
--  			) -- deceased status recorded in observation table per OMOPv6 CDM specifications
--  	
) m ON cp.person_id = m.person_id  
  """, "cdm_schema", cdm_schema);
  
  EXECUTE IMMEDIATE replace("""
  CREATE TEMP TABLE r2d2_hosp as
    SELECT a.visit_occurrence_id
    	,a.person_id
    	,a.visit_concept_id
    	,cast(a.visit_start_datetime AS DATETIME) visit_start_datetime
    	,cast(a.visit_end_datetime AS DATETIME) visit_end_datetime
    	,a.discharge_to_concept_id
    	,SUBSTR(cast(a.discharge_to_source_value AS string), 0, 256) discharge_to_source_value
    	,a.ageatvisit
    	,a.cohort_start_date
    	,a.days_bet_covid_tst_hosp
    	,d.death_datetime
    	,CASE 
    		WHEN d.death_datetime BETWEEN cast(a.visit_start_datetime AS DATETIME)
    				                          AND cast(a.visit_end_datetime AS DATETIME) 
            OR d1.visit_occurrence_id is not null
    			THEN 1
    		ELSE 0
    		END AS hospital_mortality
    	,row_number() OVER (
    		PARTITION BY a.person_id ORDER BY days_bet_covid_tst_hosp ASC
    		) rownum
    FROM (
    	SELECT DISTINCT vo.visit_occurrence_id
    		,vo.person_id
    		,vo.visit_concept_id
    		,coalesce(cast(vo.visit_start_datetime as DATETIME), cast(vo.visit_start_date as DATETIME)) visit_start_datetime
    		,coalesce(cast(vo.visit_end_datetime as DATETIME), cast(vo.visit_end_date as DATETIME)) visit_end_datetime
    		,vo.discharge_to_concept_id
    		,vo.discharge_to_source_value
    		,cast(DATE_DIFF(coalesce(CAST(visit_start_datetime AS DATE), visit_start_date), COALESCE(CAST(p.birth_datetime AS DATE), DATE(year_of_birth, month_of_birth, day_of_birth)), DAY) / 365.25 AS int64) ageatvisit
    		,cp.cohort_start_date
    		,DATE_DIFF(coalesce(CAST(vo.visit_start_datetime AS DATE), vo.visit_start_date), CAST(cp.cohort_start_date AS DATE), DAY) days_bet_covid_tst_hosp
    	FROM covid_pos cp
    	JOIN cdm_schema.visit_occurrence vo ON cp.person_id = vo.person_id
    	JOIN cdm_schema.person p ON p.person_id = vo.person_id
    	WHERE coalesce(cast(vo.visit_start_datetime AS DATETIME), cast(vo.visit_start_date as DATETIME)) >= @visitStartDateFilter ---visits after Jan 1st 2020
    		AND vo.visit_concept_id IN (
    			SELECT concept_id
    			FROM ip_visit_concepts
    			) -- IP, EI visits 
    		AND cast(DATE_DIFF(coalesce(CAST(vo.visit_start_datetime AS DATE), vo.visit_start_date), SAFE_CAST(DATE(p.year_of_birth, p.month_of_birth, p.day_of_birth) AS DATE), DAY) / 365.25 AS int64) >= @minAgeAtVisit
    		AND ((
    			DATE_DIFF(SAFE_CAST(cp.cohort_start_date AS DATE), coalesce(CAST(vo.visit_start_datetime AS DATE), vo.visit_start_date), DAY) BETWEEN @minDayDiff
    				AND @maxDayDiff -- +ve COVID status within 21 days before admission
    			) OR (cp.cohort_start_date BETWEEN coalesce(cast(vo.visit_start_datetime AS DATETIME), cast(vo.visit_start_date as DATETIME))
    				AND coalesce(cast(vo.visit_end_datetime AS DATETIME), cast(vo.visit_end_date as DATETIME))
    			)) -- +ve COVID status during hospitalization
    	) a
    LEFT JOIN deceased d ON d.person_id = a.person_id
    LEFT JOIN deceased d1 on d1.visit_occurrence_id = a.visit_occurrence_id
  """, "cdm_schema", cdm_schema)
    USING minDayDiff as minDayDiff,
		maxDayDiff as maxDayDiff,
		minAgeAtVisit as minAgeAtVisit,
		visitStartDateFilter as visitStartDateFilter;
    
    EXECUTE IMMEDIATE replace("""
    CREATE TEMP TABLE return_table_name as
    SELECT * FROM r2d2_hosp;
    """, 'return_table_name' , return_table_name);
  
 END