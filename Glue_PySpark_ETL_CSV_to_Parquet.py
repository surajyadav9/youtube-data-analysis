# This code reads raw CSV data from source S3 bucket, apply few data type transformations and again writes back to a new S3 bucket partitioned by region

import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

from pyspark.sql.functions import regexp_extract, input_file_name, col
from pyspark.sql.types import LongType

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)


# STEP 1: Read CSV files from S3 with correct options
df = spark.read \
    .option("header", "true") \
    .option("multiLine", "true") \
    .option("quote", "\"") \
    .option("escape", "\"") \
    .option("encoding", "UTF-8") \
    .csv("s3://youtubeanalysis-raw-useast1-315380538310-dev/youtube-data/raw_data/")


# STEP 2: Extract region from file path
df = df.withColumn("region", regexp_extract(input_file_name(), r"region=([^/]+)", 1))


# STEP 3: Cast all required columns to correct types
df = df.withColumn("category_id", col("category_id").cast(LongType())) \
       .withColumn("views", col("views").cast(LongType())) \
       .withColumn("likes", col("likes").cast(LongType())) \
       .withColumn("dislikes", col("dislikes").cast(LongType())) \
       .withColumn("comment_count", col("comment_count").cast(LongType())) \
       .withColumn("comments_disabled", col("comments_disabled").cast("boolean")) \
       .withColumn("ratings_disabled", col("ratings_disabled").cast("boolean")) \
       .withColumn("video_error_or_removed", col("video_error_or_removed").cast("boolean"))



# STEP 4: Write to S3 in Parquet, partitioned by region
df.write \
    .mode("overwrite") \
    .partitionBy("region") \
    .option("compression", "snappy") \
    .parquet("s3://youtubeanalysis-cleansed-useast1-315380538310-lambda/youtube/raw_data_transformed/")



job.commit()
