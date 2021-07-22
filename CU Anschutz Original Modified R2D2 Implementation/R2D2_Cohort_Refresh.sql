DECLARE cdm_schema STRING DEFAULT 'omop_covid19_kratos';
DECLARE return_table_name STRING DEFAULT 'covid_hsp';
DECLARE runDate STRING DEFAULT (select format_date('%Y_%m_%d',current_date()));

CALL `omop_covid19_kratos.sp_r2d2_identify_hospitalization_encounters`(cdm_schema, return_table_name);

--Creates table of persons with COVID
create or replace table `r2d2_query_cohorts.covid_persons`
as 
select pers.person_id, pers.concept_id, c.concept_name, pers.source_value, pers.cohort_start_date from r2d2 pers
join omop_covid19_kratos.concept c on  c.concept_id = pers.concept_id;

--Creates a copy of COVID patients table with date appended to preserve cohort
EXECUTE IMMEDIATE(replace("""
CREATE TABLE IF NOT EXISTS `r2d2_query_cohorts.covid_persons_runDate`
as 
select * from `r2d2_query_cohorts.covid_persons`;
""", "runDate", runDate));


--Creates table of hospitalizations of COVID patients
create or replace table `r2d2_query_cohorts.covid_inpatient_hosp_encounters`
as 
select * from covid_hsp
where visit_end_datetime is not null;

--Creates a copy of hospitalized patients table with date appended to preserve cohort
EXECUTE IMMEDIATE(replace("""
CREATE TABLE IF NOT EXISTS `r2d2_query_cohorts.covid_inpatient_hosp_encounters_runDate`
as 
select * from r2d2_query_cohorts.covid_inpatient_hosp_encounters
where visit_end_datetime is not null;
""", "runDate", runDate));
