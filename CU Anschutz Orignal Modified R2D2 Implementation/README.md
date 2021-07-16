## SQL code used by CU-Anschutz Campus

The SQL code within this folder is used by CU-Anschutz Campus to answer questions for the Rapid Response Data Discovery for COVID Clinical Consultation using Patient Observations (R2D2 C3PO)  Research Project

The SQL Code used is written for use in Google BigQuery.  Usually on a weekly basis, the R2D2_Cohort_Refresh.sql script was executed to refresh the COVID-19 research dataset.  This script passes parameters to the sp_r2d2_identify_hospitalization_encounters stored procedure.  This stored procedure calls another stored procedure, sp_r2d2_identify_patients to identify the patients who meet the phenotype definition of being COVID Positive.  These patients become further inputs to sp_r2d2_identify_hospitalization_encounters stored procedure which then finds any inpatient hospitalizations.  Both the COVID Positive patients and their inpatient hospital stays are saved as a cohort for review and comparison to future queries and reruns.

The code here largely is the same as the code from the Canoncial SQL, https://github.com/DBMI/R2D2-Public/tree/master/Question_0000, from R2D2 except with discharge disposition concepts as they are unavailable in the dataset and with death dates as they are only largely accurate using the Death table rather than death observation concept IDs.
