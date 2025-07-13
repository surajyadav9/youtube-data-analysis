-- Below are the queries run to analyze/debug the data on AWS Athena.

-- fetch the first 10 rows from the cleaned ref data catalog table containing all regions data combined. 
SELECT * FROM "db_youtube_cleaned"."cleaned_statistics_ref_data" limit 10;

-- join raw transformed catalog table with the cleaned ref catalog table
-- produces 3,734,265 records
-- this was impleted in Glue Visual ETL job to create 1 final data for analysis/reporting.
SELECT * 
FROM "db_youtube_cleaned"."cleaned_statistics_ref_data" ref 
INNER JOIN "db_youtube_cleaned"."raw_data_transformed" raw 
ON ref.id = raw.category_id
;

-- create analytics glue database to store final result of Glue Visual ETL job for above goal 
create database analytics;

-- query the final table which was created by the Glue Visual ETL job after joining the cleaned raw and ref data
SELECT * FROM "analytics"."combined_ref_raw_catalog" limit 10;
