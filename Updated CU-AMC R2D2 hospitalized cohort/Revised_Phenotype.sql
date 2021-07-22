
--SARS CoV-2 Test Concepts
CREATE TABLE IF NOT EXISTS temp_covid_scratch.conceptset242 AS 
  	SELECT concept_id
		,concept_code
		,concept_name
	FROM omop_covid19_kratos.concept
	WHERE concept_id IN  (586307,586308,586309,586310,586516,586517,586518,586519,586520,
				586523,586524,586525,586526,586528,586529,700360,704991,704992,
				704993,705000,705001,706154,706155,706156,706157,706158,706160,
				706161,706163,706166,706167,706168,706169,706170,706173,706174,
				706175,715260,715261,715262,715272,723463,723464,723465,723466,
				723467,723468,723469,723470,723471,723476,723477,723478,756029,
				756055,756065,756084,756085,757677,757678,37310255,37310257,
				40218804,40218805 );
				
--Positive/Affirmative measurement values
CREATE TABLE IF NOT EXISTS temp_covid_scratch.conceptset240 AS 
	SELECT concept_id
		,concept_code
		,concept_name
	FROM omop_covid19_kratos.concept
	WHERE concept_id IN  (9191,4126681,4127785,4181412,21498442,36308332,36310714,
				36715206,37079273,40479562,40479567,40479985,45877737,45877985,
				45878592,45879438,45880924,45881864,45882963,45884084);
  
--Single Measurement Concept 2019 novel coronavirus detected
CREATE TABLE IF NOT EXISTS temp_covid_scratch.conceptset243 AS
	SELECT concept_id
		,concept_code
		,concept_name
	FROM omop_covid19_kratos.concept
	WHERE concept_id IN (37310282);
	
CREATE TABLE IF NOT EXISTS temp_covid_scratch.conceptset246 AS
	SELECT concept_id
		,concept_code
		,concept_name
	FROM omop_covid19_kratos.concept
	WHERE concept_id IN  ( 702953   ,37311061   );
	
CREATE TABLE IF NOT EXISTS temp_covid_scratch.conceptset245 AS
	SELECT concept_id
		,concept_code
		,concept_name
	FROM omop_covid19_kratos.concept
	WHERE concept_id IN  (  4100065   ,45600471 );
	
CREATE TABLE IF NOT EXISTS temp_covid_scratch.conceptset247 AS
	SELECT concept_id
		,concept_code
		,concept_name
	FROM omop_covid19_kratos.concept
	WHERE concept_id IN  ( 256451   ,260139 ,261326 ,320136 ,4195694 ,4307774 ,35207965 ,35207970 ,35208013 ,35208069 ,35208108 ,45572161   ); 

CREATE TABLE IF NOT EXISTS temp_covid_scratch.conceptset248 AS
	SELECT concept_id
		,concept_code
	FROM omop_covid19_kratos.concept
	WHERE concept_id IN (756023, 756031, 756039, 756044, 756061, 756081, 37310254, 37310283, 37310284, 37310285, 37310286, 37310287);

CREATE TABLE IF NOT EXISTS temp_covid_scratch.ip_visit_concepts as 
  select *
	from omop_covid19_kratos.concept 
	where concept_id in (262,8717,8913,8971,9201,32037,32254,32760,581379,581383,581384,38004270,38004274,38004275,38004276,38004277,38004278,38004279,38004280,38004281,38004282,38004283,38004284,38004285,38004286,38004287,38004288,38004290,38004291,38004515);
	
  CREATE TABLE IF NOT EXISTS temp_covid_scratch.deceased_concepts as
  select *
	from omop_covid19_kratos.concept 
  where concept_id in (4289171,4239459,4152823,4060687,3435639,441413,36715062,442605,3050986,42573014,4252573,3444298,443882,4302017,763387,762991,4086475,4302158,1314532,4061268,4221284,4178886,432507,42574217,4277909,4277188,764068,45763722,438331,443280,763811,4071603,4063309,4028785,42600162,4083741,40480476,4337939,42573038,4216441,762986,441139,42573357,4086968,40757987,40757985,4164280,4170971,4205519,4122053,36305630,42600310,4083738,45890698,42574264,40757986,4216643,443695,4192271,42573352,763382,4101391,1314528,4027679,4028786,443281,1314519,764069,4323052,4155383,4145919,4276823,4118030,4171902,436228,36717396,4048142,763384,45771271,3436784,4086473,42600309,762990,4220022,42600074,762987,1314489,4019847,764465,4301926,441200,42573355,4135942,442329,4183699,4102452,44789839,4195245,4233376,42599367,4239540,4190316,4083737,4162707,4102691,3428541,4136880,4024541,4253807,4170711,40492796,4296873,4167237,4059646,4145391,4297089,4129846,442289,42538188,4177807,763386,4198985,4253661,40492790,762988,440925,40485992,4059789,4171903,4244279,40757988,763383,4126313,4306655,40760375,4238527,4231144,4321590,44791186,4244718,4079844,4065742,45770448,4030405,4307303,3439490,36306117,4049737,42598845,4206035,4081608,32221,44811215,4282320,4097521,4252891,4194377,4344630,4280210,36304910,4210315,435174,4078912,44786461,4132309,4305323,36303617,4197586,4218686,3050047,40760319,1314522,4178679,3185356,1314525,4052866,763388,4187334,44806941,442338,37395455,4053707,4034158,4062254,4173168,4073388,36204579,44784548,44784549,4195755,4253799,1314487,4151597,4023152,44786465,37395454,3050664,36204580,4193123,32218,4259007,44810218,4028784,44814686,4179191,4178604,435148,4079843,4178885,4191032,4077917);

CREATE OR REPLACE TABLE temp_covid_scratch.cond as 
	SELECT DISTINCT m.person_id
		,m.visit_occurrence_id
		,m.condition_concept_id
		,c1.concept_name AS condition_1_concept_name
		,cast(m.condition_source_value AS string) condition_source_value
		,m.condition_start_date
		,m2.visit_occurrence_id visit_occurrence_id2
		,m2.condition_concept_id condition_concept_id2
		,c2.concept_name AS condition_2_concept_name
		,cast(m2.condition_source_value AS string) condition_source_value2
		,m2.condition_start_date condition_start_date2
	FROM (
		SELECT DISTINCT m.person_id
			,m.visit_occurrence_id
			,m.condition_concept_id
			,cast(m.condition_source_value AS string) condition_source_value
			,m.condition_start_date
		FROM omop_covid19_kratos.condition_occurrence m
		JOIN temp_covid_scratch.conceptset245 c245 ON c245.concept_id = m.condition_concept_id
			OR cast(c245.concept_code AS string) = cast(m.condition_source_value AS string)
		WHERE m.condition_start_date < '2020-04-01'
		) m
	JOIN (
		SELECT DISTINCT c.person_id
			,c.visit_occurrence_id
			,c.condition_concept_id
			,cast(c.condition_source_value AS string) condition_source_value
			,c.condition_start_date
		FROM omop_covid19_kratos.condition_occurrence c
		JOIN temp_covid_scratch.conceptset247 c247 ON c247.concept_id = c.condition_concept_id
			OR cast(c247.concept_code AS string) = cast(c.condition_source_value AS string)
		) m2 ON m.person_id = m2.person_id
		AND (
			m.visit_occurrence_id = m2.visit_occurrence_id
			OR m.condition_start_date = m2.condition_start_date
			)
		AND (
			m.condition_concept_id != m2.condition_concept_id
			OR cast(m.condition_source_value AS string) != cast(m2.condition_source_value AS string)
			)
	JOIN omop_covid19_kratos.concept c1 ON c1.concept_id = m.condition_concept_id
	JOIN omop_covid19_kratos.concept c2 ON c2.concept_id = m2.condition_concept_id

	UNION DISTINCT
  
	SELECT DISTINCT m.person_id
		,m.visit_occurrence_id
		,m.condition_concept_id
		,c1.concept_name AS condition_1_concept_name
		,cast(m.condition_source_value AS string) condition_source_value
		,m.condition_start_date
		,cast(null as int64) visit_occurrence_id2
		,cast(null as int64) condition_concept_id2
		,cast(null as string) AS condition_2_concept_name
		,cast(null as string) condition_source_value2
		,cast(null as date) condition_start_date2
	FROM (
		SELECT DISTINCT m.person_id
			,m.visit_occurrence_id
			,m.condition_concept_id
			,cast(m.condition_source_value AS string) condition_source_value
			,m.condition_start_date
		FROM omop_covid19_kratos.condition_occurrence m
		JOIN temp_covid_scratch.conceptset246 c246 ON c246.concept_id = m.condition_concept_id
			OR cast(c246.concept_code AS string) = cast(m.condition_source_value AS string)
		--WHERE m.condition_start_date >= '2020-04-01'
		) m
	--JOIN (
	--	SELECT DISTINCT c.person_id
	--		,c.visit_occurrence_id
	--		,c.condition_concept_id
	--		,cast(c.condition_source_value AS string) condition_source_value
	--		,c.condition_start_date
	--	FROM omop_covid19_kratos.condition_occurrence c
	--	JOIN temp_covid_scratch.conceptset247 c247 ON c247.concept_id = c.condition_concept_id
	--		OR cast(c247.concept_code AS string) = cast(c.condition_source_value AS string)
	--	) m2 ON m.person_id = m2.person_id
	JOIN omop_covid19_kratos.concept c1 ON c1.concept_id = m.condition_concept_id
	--JOIN omop_covid19_kratos.concept c2 ON c2.concept_id = m2.condition_concept_id
	--WHERE (
	--		m.visit_occurrence_id = m2.visit_occurrence_id
	--		OR m.condition_start_date = m2.condition_start_date
	--		)
	--	AND (
	--		m.condition_concept_id != m2.condition_concept_id
	--		OR m.condition_source_value != m2.condition_source_value
	--		);
			;
						
CREATE OR REPLACE TABLE temp_covid_scratch.covid_pos as
	SELECT *
	FROM (
		SELECT DISTINCT m.person_id
			,m.measurement_concept_id concept_id
			,SUBSTR(cast(m.value_source_value AS string), 0, 256) source_value
			,m.measurement_datetime cohort_start_date
		FROM temp_covid_scratch.conceptset242 c --- R2D2 non-pre-coordinated viral lab tests
		JOIN omop_covid19_kratos.measurement m ON c.concept_id = m.measurement_concept_id
		JOIN temp_covid_scratch.conceptset240 c240 ON c240.concept_id = m.value_as_concept_id
		
		UNION DISTINCT
		SELECT DISTINCT m.person_id
			,m.measurement_concept_id
			,SUBSTR(cast(m.value_source_value AS string), 0, 256)
			,m.measurement_datetime
		FROM temp_covid_scratch.conceptset243 c --- R2D2 non-pre-coordinated viral lab tests		
		JOIN omop_covid19_kratos.measurement m ON c.concept_id = m.measurement_concept_id
		
		UNION DISTINCT
		SELECT DISTINCT m.person_id
			,m.condition_concept_id
			,SUBSTR(cast(m.condition_source_value AS string), 0, 256)
			,m.condition_start_date
		FROM temp_covid_scratch.conceptset248 c -- R2D2 Diagnosis codes without logic
		JOIN omop_covid19_kratos.condition_occurrence m ON c.concept_id = m.condition_concept_id
		
		UNION DISTINCT
		SELECT DISTINCT m.person_id
			,m.condition_concept_id
			,SUBSTR(cast(m.condition_source_value AS string), 0, 256)
			,m.condition_start_date
		FROM temp_covid_scratch.cond m
		) data;

 CREATE TABLE IF NOT EXISTS temp_covid_scratch.deceased as
  SELECT DISTINCT m.*
  FROM temp_covid_scratch.covid_pos cp
  JOIN (
  	SELECT DISTINCT person_id
  		,NULL visit_occurrence_id
      ,NULL concept_id
  		,cast(death_date AS DATETIME) AS death_datetime
  	FROM omop_covid19_kratos.death
  	
  	UNION DISTINCT
  	
  	SELECT DISTINCT person_id
      ,visit_occurrence_id
  		,discharge_to_concept_id concept_id
  		,coalesce(cast(visit_end_datetime AS DATETIME), cast(visit_end_date as DATETIME)) AS visit_end_datetime
  	FROM omop_covid19_kratos.visit_occurrence
  	WHERE discharge_to_concept_id IN (
  			SELECT concept_id
  			FROM temp_covid_scratch.deceased_concepts
  			) -- deceased status from discharge disposition
  	
--  	UNION DISTINCT
--  
--  	SELECT DISTINCT person_id
--      ,visit_occurrence_id
--  		,observation_concept_id concept_id
--  		,coalesce(cast(observation_datetime AS DATETIME), cast(observation_date as DATETIME)) observation_datetime
--  	FROM omop_covid19_kratos.observation
--  	WHERE observation_concept_id IN (
--  			SELECT concept_id
--  			FROM deceased_concepts
--  			) -- deceased status recorded in observation table per OMOPv6 CDM specifications
--  	
) m ON cp.person_id = m.person_id;   

CREATE OR REPLACE TABLE temp_covid_scratch.covid_inpatient_hosp_encounters as
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
    	FROM temp_covid_scratch.covid_pos cp
    	JOIN omop_covid19_kratos.visit_occurrence vo ON cp.person_id = vo.person_id
    	JOIN omop_covid19_kratos.person p ON p.person_id = vo.person_id
    	WHERE coalesce(cast(vo.visit_start_datetime AS DATETIME), cast(vo.visit_start_date as DATETIME)) >= '2020-01-01' ---visits after Jan 1st 2020
    		AND vo.visit_concept_id IN (
    			SELECT concept_id
    			FROM temp_covid_scratch.ip_visit_concepts
    			) -- IP, EI visits 
    		AND cast(DATE_DIFF(coalesce(CAST(vo.visit_start_datetime AS DATE), vo.visit_start_date), SAFE_CAST(DATE(p.year_of_birth, p.month_of_birth, p.day_of_birth) AS DATE), DAY) / 365.25 AS int64) >= 18
    		AND ((
    			DATE_DIFF(SAFE_CAST(cp.cohort_start_date AS DATE), coalesce(CAST(vo.visit_start_datetime AS DATE), vo.visit_start_date), DAY) BETWEEN 0
    				AND -21-- +ve COVID status within 21 days before admission
    			) OR (cp.cohort_start_date BETWEEN coalesce(cast(vo.visit_start_datetime AS DATETIME), cast(vo.visit_start_date as DATETIME))
    				AND coalesce(cast(vo.visit_end_datetime AS DATETIME), cast(vo.visit_end_date as DATETIME))
    			)) -- +ve COVID status during hospitalization
    	) a
    LEFT JOIN temp_covid_scratch.deceased d ON d.person_id = a.person_id
    LEFT JOIN temp_covid_scratch.deceased d1 on d1.visit_occurrence_id = a.visit_occurrence_id;
	
CREATE OR REPLACE TABLE temp_covid_scratch.combined_data as
WITH cte_redcap
AS (
	SELECT DISTINCT a.person_id
		,a.visit_occurrence_id
		,a.visit_start_datetime
		,a.visit_end_datetime
		,a.death_datetime
	FROM temp_covid_scratch.covid_inpatient_hosp_encounters a
	WHERE a.visit_start_datetime BETWEEN '2020-03-18' AND '2020-04-30'
	and a.cohort_start_date BETWEEN '2020-03-18' AND '2020-04-30'
	)
SELECT DISTINCT p.person_id
    ,redcap.Arb_person_id
	,redcap.MRN
	,tt.visit_occurrence_id
	,cs.care_site_id
	,cs.care_site_name
	,tt.visit_start_datetime
	,tt.visit_end_datetime
	,tt.death_datetime
	,CASE 
		WHEN m.measurement_concept_id IS NOT NULL
			THEN 'Y'
		ELSE 'N'
		END AS COVID_Test_Positive
	,co.condition_start_date
	,ARRAY_TO_STRING([CAST(co.condition_1_concept_name as STRING), CAST(co.condition_2_concept_name as STRING)], ' | ') condition_concept_names
	,ARRAY_TO_STRING([CAST(co.condition_concept_id as STRING), CAST(co.condition_concept_id2 as STRING)], ' | ') as condition_concept_ids
	,p.birth_datetime
	,DATETIME_DIFF(tt.visit_start_datetime,p.birth_datetime, YEAR)- IF(EXTRACT(MONTH FROM p.birth_datetime)*100 + EXTRACT(DAY FROM p.birth_datetime) > EXTRACT(MONTH FROM tt.visit_start_datetime)*100 + EXTRACT(DAY FROM tt.visit_start_datetime),1,0) AS age
	,p.race_concept_id
	,rc.concept_name AS race_concept_name
	,p.ethnicity_concept_id
	,ec.concept_name AS ethnicity_concept_name
	,p.gender_concept_id
	,gc.concept_name AS gender_concept_name
FROM temp_covid_scratch.covid_inpatient_hosp_encounters tt
JOIN `hdcohdsicovid19.omop_covid19_kratos.person` p ON p.person_id = tt.person_id
JOIN `hdcohdsicovid19.omop_covid19_kratos.concept` rc ON rc.concept_id = p.race_concept_id
JOIN `hdcohdsicovid19.omop_covid19_kratos.concept` ec ON ec.concept_id = p.ethnicity_concept_id
JOIN `hdcohdsicovid19.omop_covid19_kratos.concept` gc ON gc.concept_id = p.gender_concept_id
JOIN `hdcohdsicovid19.omop_covid19_kratos.visit_occurrence` vo ON vo.visit_occurrence_id = tt.visit_occurrence_id
JOIN `hdcohdsicovid19.omop_covid19_kratos.care_site` cs ON cs.care_site_id = vo.care_site_id
LEFT JOIN (
	SELECT mt.person_id
		,mt.measurement_concept_id
		,conceptset242.concept_name
		,mt.measurement_datetime
	FROM `hdcohdsicovid19.omop_covid19_kratos.measurement` mt
	JOIN cte_redcap rc ON rc.person_id = mt.person_id
	JOIN temp_covid_scratch.conceptset242 ON conceptset242.concept_id = mt.measurement_concept_id
	JOIN temp_covid_scratch.conceptset240 ON conceptset240.concept_id = mt.value_as_concept_id
	
	UNION ALL
	
	SELECT mt.person_id
		,mt.measurement_concept_id
		,conceptset243.concept_name
		,mt.measurement_datetime
	FROM `hdcohdsicovid19.omop_covid19_kratos.measurement` mt
	JOIN cte_redcap rc ON rc.person_id = mt.person_id
	JOIN temp_covid_scratch.conceptset243 ON conceptset243.concept_id = mt.measurement_concept_id
	) m ON m.person_id = tt.person_id
	AND (DATE_DIFF(CAST(m.measurement_datetime AS DATE), CAST(tt.visit_start_datetime AS DATE), DAY) BETWEEN -21 and 0
		OR CAST(m.measurement_datetime AS DATE) BETWEEN CAST(tt.visit_start_datetime AS DATE) and CAST(tt.visit_end_datetime AS DATE))
	
LEFT JOIN temp_covid_scratch.cond co ON co.person_id = tt.person_id
	AND (cast(co.condition_start_date AS DATE) BETWEEN CAST(tt.visit_start_datetime AS DATE)
		AND CAST(tt.visit_end_datetime AS DATE)
		OR DATE_DIFF(cast(co.condition_start_date AS DATE), CAST(tt.visit_start_datetime AS DATE), DAY) BETWEEN -21 and 0)
LEFT JOIN `hdcschillingcoviddata.coviddataqc.table1_patient_20210204` redcap on redcap.Arb_person_id = tt.person_id
ORDER BY 1, 2, 5;

--CREATE OR REPLACE TABLE r2d2_query_cohorts.lauren_data_2021_02_05 AS
WITH cte_condition_concepts
AS (
	SELECT a.person_id
		,a.visit_occurrence_id
		,string_agg(a.condition_concept_names, ' | ') AS condition_concept_names
		,string_agg(a.condition_concept_ids, ' | ') AS condition_concept_ids
	FROM temp_covid_scratch.combined_data a
	GROUP BY 1
		,2
	),
cte_d_condition_concepts AS (
	SELECT person_id
		,visit_occurrence_id
		,ARRAY_TO_STRING(ARRAY(SELECT DISTINCT concept_name FROM UNNEST(SPLIT(condition_concept_names, ' | ')) AS concept_name), ' | ') AS concept_name
		,ARRAY_TO_STRING(ARRAY(SELECT DISTINCT concept_id FROM UNNEST(SPLIT(condition_concept_ids, ' | ')) AS concept_id), ' | ') AS concept_id
	FROM cte_condition_concepts
	)
SELECT DISTINCT a.person_id
	,a.Arb_person_id
	,a.MRN
	,a.care_site_id
	,a.care_site_name
	,a.visit_occurrence_id
	,a.visit_start_datetime
	,a.visit_end_datetime
	,a.death_datetime
	,a.COVID_Test_Positive
	,b.concept_name AS concept_names
	,b.concept_id AS concept_ids
	,a.birth_datetime
	,a.age
	,a.race_concept_id
	,a.race_concept_name
	,a.ethnicity_concept_id
	,a.ethnicity_concept_name
	,a.gender_concept_id
	,a.gender_concept_name
FROM temp_covid_scratch.combined_data a
LEFT JOIN cte_d_condition_concepts b ON b.person_id = a.person_id
	AND a.visit_occurrence_id = b.visit_occurrence_id;
