BEGIN
  declare cdmSchema string default cdm_schema;
	declare visitStartDate date default '2020-01-01';
	declare diagnosisLogicDate date default '2020-04-01';
	declare returnTableName string default return_table_name;
  
  EXECUTE IMMEDIATE replace("""
  create temp table conceptset242 as 
  	select concept_id, concept_code from cdm_schema.concept
	where concept_id in  (586307,586308,586309,586310,586516,586517,586518,586519,586520,586523,586524,586525,586526,586528,586529,700360,704991,704992,704993,705000,705001,706154,706155,706156,706157,706158,706160,706161,706163,706166,706167,706168,706169,706170,706173,706174,706175,715260,715261,715262,715272,723463,723464,723465,723466,723467,723468,723469,723470,723471,723476,723477,723478,756029,756055,756065,756084,756085,757677,757678,37310255,37310257,40218804,40218805 ) 
  """, "cdm_schema", cdmSchema);
  
  EXECUTE IMMEDIATE replace("""
  create temp table conceptset240 as 
  select concept_id, concept_code from cdm_schema.concept
	where concept_id in  (9191,4126681,4127785,4181412,21498442,36308332,36310714,36715206,37079273,40479562,40479567,40479985,45877737,45877985,45878592,45879438,45880924,45881864,45882963,45884084) 
  """, "cdm_schema", cdmSchema);
  
  EXECUTE IMMEDIATE replace("""
  create temp table conceptset243 as 
  select concept_id, concept_code from cdm_schema.concept
	where concept_id in  (37310282) 
  """, "cdm_schema", cdmSchema);
  
  EXECUTE IMMEDIATE replace("""
  create temp table conceptset248 as 
	select concept_id, concept_code from cdm_schema.concept
	where concept_id in  ( 756023, 756031 , 756039 , 756044 , 756061 , 756081 , 37310254 , 37310283 , 37310284 , 37310285 , 37310286 , 37310287 ) 
  """, "cdm_schema", cdmSchema);
  
  EXECUTE IMMEDIATE replace("""
  create temp table conceptset247 as 
	select concept_id, concept_code from cdm_schema.concept
	where concept_id in  ( 256451   ,260139 ,261326 ,320136 ,4195694 ,4307774 ,35207965 ,35207970 ,35208013 ,35208069 ,35208108 ,45572161   ) 
  """, "cdm_schema", cdmSchema);
  
    
  EXECUTE IMMEDIATE replace("""
  create temp table conceptset246 as 
	select concept_id, concept_code from cdm_schema.concept
	where concept_id in  ( 702953   ,37311061   ) 
  """, "cdm_schema", cdmSchema);
  
  EXECUTE IMMEDIATE replace("""
  create temp table conceptset245 as 
	select concept_id, concept_code from cdm_schema.concept
	where concept_id in  (  4100065   ,45600471 ) 
  """, "cdm_schema", cdmSchema);
 
   EXECUTE IMMEDIATE replace("""
    CREATE TEMP TABLE cond as 
      SELECT DISTINCT m.person_id
      	,m.visit_occurrence_id
      	,m.condition_concept_id
      	,cast(m.condition_source_value AS string) condition_source_value
      	,m.condition_start_date
      	,m2.visit_occurrence_id visit_occurrence_id2
      	,m2.condition_concept_id condition_concept_id2
      	,cast(m2.condition_source_value AS string) condition_source_value2
      	,m2.condition_start_date condition_start_date2
      FROM (
      	SELECT DISTINCT m.person_id
      		,m.visit_occurrence_id
      		,m.condition_concept_id
      		,cast(m.condition_source_value AS string) condition_source_value
      		,m.condition_start_date
      	FROM cdm_schema.condition_occurrence m
      	JOIN conceptset245 c245 ON c245.concept_id = m.condition_concept_id
      		OR cast(c245.concept_code AS string) = cast(m.condition_source_value AS string)
      	WHERE m.condition_start_date < @diagnosislogicdate
      	) m
      JOIN (
      	SELECT DISTINCT c.person_id
      		,c.visit_occurrence_id
      		,c.condition_concept_id
      		,cast(c.condition_source_value AS string) condition_source_value
      		,c.condition_start_date
      	FROM cdm_schema.condition_occurrence c
      	JOIN conceptset247 c247 ON c247.concept_id = c.condition_concept_id
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
      
      UNION DISTINCT
      
      SELECT DISTINCT m.person_id
      	,m.visit_occurrence_id
      	,m.condition_concept_id
      	,cast(m.condition_source_value AS string) condition_source_value
      	,m.condition_start_date
      	,m2.visit_occurrence_id visit_occurrence_id2
      	,m2.condition_concept_id condition_concept_id2
      	,cast(m2.condition_source_value AS string) condition_source_value2
      	,m2.condition_start_date condition_start_date2
      FROM (
      	SELECT DISTINCT m.person_id
      		,m.visit_occurrence_id
      		,m.condition_concept_id
      		,cast(m.condition_source_value AS string) condition_source_value
      		,m.condition_start_date
      	FROM cdm_schema.condition_occurrence m
      	JOIN conceptset246 c246 ON c246.concept_id = m.condition_concept_id
      		OR cast(c246.concept_code AS string) = cast(m.condition_source_value AS string)
      	WHERE m.condition_start_date >= @diagnosislogicdate
      	) m
      JOIN (
      	SELECT DISTINCT c.person_id
      		,c.visit_occurrence_id
      		,c.condition_concept_id
      		,cast(c.condition_source_value AS string) condition_source_value
      		,c.condition_start_date
      	FROM cdm_schema.condition_occurrence c
      	JOIN conceptset247 c247 ON c247.concept_id = c.condition_concept_id
      		OR cast(c247.concept_code AS string) = cast(c.condition_source_value AS string)
      	) m2 ON m.person_id = m2.person_id
      WHERE (
      		m.visit_occurrence_id = m2.visit_occurrence_id
      		OR m.condition_start_date = m2.condition_start_date
      		)
      	AND (
      		m.condition_concept_id != m2.condition_concept_id
      		OR m.condition_source_value != m2.condition_source_value
      		)
  """, "cdm_schema", cdmSchema)
  USING diagnosislogicdate as diagnosislogicdate;
   
  EXECUTE IMMEDIATE replace("""
  CREATE TEMP TABLE r2d2 as 
    SELECT DISTINCT m.person_id
    	,m.measurement_concept_id concept_id
    	,SUBSTR(cast(m.value_source_value AS string), 0, 256) source_value
    	,m.measurement_datetime cohort_start_date
    FROM conceptset242 c --- R2D2 non-pre-coordinated viral lab tests
    JOIN cdm_schema.measurement m ON c.concept_id = m.measurement_concept_id
    JOIN conceptset240 c240 ON c240.concept_id = m.value_as_concept_id
    
    UNION DISTINCT
    
    SELECT DISTINCT m.person_id
    	,m.measurement_concept_id
    	,SUBSTR(cast(m.value_source_value AS string), 0, 256)
    	,m.measurement_datetime
    FROM conceptset243 c --- R2D2 non-pre-coordinated viral lab tests		
    JOIN cdm_schema.measurement m ON c.concept_id = m.measurement_concept_id
    
    UNION DISTINCT
    
    SELECT DISTINCT m.person_id
    	,m.condition_concept_id
    	,SUBSTR(cast(m.condition_source_value AS string), 0, 256)
    	,m.condition_start_date
    FROM conceptset248 c -- R2D2 Diagnosis codes without logic
    JOIN cdm_schema.condition_occurrence m ON c.concept_id = m.condition_concept_id
    
    UNION DISTINCT
    
    SELECT DISTINCT m.person_id
    	,m.condition_concept_id
    	,SUBSTR(cast(m.condition_source_value AS string), 0, 256)
    	,m.condition_start_date
    FROM cond m;
    """, "cdm_schema", cdmSchema);
    
  EXECUTE IMMEDIATE replace("""
  CREATE TEMP TABLE return_table_name as
  SELECT * FROM r2d2;
    """, 'return_table_name', returnTableName);
  
END