Query Link
--https://console.cloud.google.com/bigquery?sq=587088543437:c9314133c0364255a5c4238dc8583426

-- Week 3 Homework
CREATE OR REPLACE EXTERNAL TABLE `dtc-de-course-376320.mrignytaxi.external_yellow_tripdata`
OPTIONS (
  format = 'CSV',
  uris = ['gs://mrignytaxi/fhv_tripdata_2019-*.csv.gz']);

-- Question 1
SELECT count(*) FROM dtc-de-course-376320.mrignytaxi.external_yellow_tripdata;

CREATE OR REPLACE TABLE dtc-de-course-376320.mrignytaxi.yellow_tripdata_non_partitoned AS
SELECT * FROM dtc-de-course-376320.mrignytaxi.external_yellow_tripdata;

-- Question 2
select count(distinct(affiliated_base_number)) from dtc-de-course-376320.mrignytaxi.yellow_tripdata_non_partitoned;

select count(distinct(affiliated_base_number)) from dtc-de-course-376320.mrignytaxi.external_yellow_tripdata;

-- Question 3
select count(*) from dtc-de-course-376320.mrignytaxi.yellow_tripdata_non_partitoned where PUlocationID IS NULL and DOlocationID IS NULL;

-- Question 5
CREATE OR REPLACE TABLE dtc-de-course-376320.mrignytaxi.yellow_tripdata_partitoned_clustered
PARTITION BY DATE(pickup_datetime)
CLUSTER BY affiliated_base_number AS
SELECT * FROM dtc-de-course-376320.mrignytaxi.yellow_tripdata_non_partitoned;

SELECT distinct(affiliated_base_number)
FROM dtc-de-course-376320.mrignytaxi.yellow_tripdata_non_partitoned
WHERE DATE(pickup_datetime) BETWEEN '2019-03-01' AND '2019-03-31';

SELECT distinct(affiliated_base_number)
FROM dtc-de-course-376320.mrignytaxi.yellow_tripdata_partitoned_clustered
WHERE DATE(pickup_datetime) BETWEEN '2019-03-01' AND '2019-03-31';
