# YouTube Data Analysis 📊📺

## 🚀 Project Overview

This project is a complete end-to-end data engineering pipeline for analyzing YouTube data using AWS cloud services. The core goal is to extract insights from raw CSV and JSON data formats using AWS Glue, Lambda, Athena, and QuickSight. 

Through this project, I aimed to strengthen my understanding of:
- Cloud data lakes and cataloging using AWS
- Real-world challenges with JSON normalization
- Automating ETL workflows with Lambda and PySpark
- Building analytical dashboards with Athena and QuickSight

---

## 🧰 AWS Services & Tools Used

- **Amazon S3** – Storage of raw and processed data
- **AWS CLI** – Upload data to S3 with hive-style partitioning
- **AWS Lambda** – Transform/normalize JSON to Parquet
- **AWS Glue** – Data cataloging, crawling, and ETL jobs (both visual and PySpark-based)
- **Amazon Athena** – Serverless querying of datasets
- **Amazon QuickSight** – Dashboard and reporting

---

## 🧠 Prerequisites

Before you start, make sure the following are in place:

- An active **AWS Account**
- **AWS CLI** installed and configured with credentials
- Familiarity with:
  - **Python**
  - **PySpark**
  - Basic **AWS Services** (especially Glue, S3, Lambda, Athena, QuickSight)
- IAM roles/policies granting S3, Glue, Lambda, and Athena access

---

## 📂 Project Workflow

### 1. 📥 Upload Raw Data to S3

- Download raw **CSV** and **JSON** data locally.
- Create an S3 bucket and upload the data:
  - CSV files with **Hive-style partitioning** (e.g., `/region=us/`, `/region=ca/`)
  - JSON files stored in a separate folder without partitioning
- Use `aws s3 cp` or `aws s3 sync` via AWS CLI for uploads.

---

### 2. 🧭 Glue Catalog for JSON (Initial Attempt)

- Tried creating a **Glue Crawler** over JSON data.
- Encountered issues due to **Glue's limited support for nested JSON structures**.
- Decided to normalize the JSON before further processing.

---

### 3. 🔁 JSON Normalization with Lambda

- Wrote a **Lambda function** to:
  - Read JSON from raw S3
  - Normalize/flatten JSON
  - Write as **Parquet** to a new "cleaned" S3 bucket
- Successfully tested on one file.
- Verified results using **Athena** queries on the generated **Glue Catalog**.

---

### 4. 🕸️ Glue Crawler for CSV Data

- Created a **Glue Crawler** to crawl the partitioned CSV files.
- Table was created with **`region`** as the partition key.

---

### 5. 🔗 Joining Reference and Raw Tables

- Used **Athena** to join the JSON (reference) and CSV (raw) tables.
- Adjusted data types in the Glue catalog to avoid repeated casting.

---

## 🛠️ Production Workflow

### 6. 🔄 Automate JSON Normalization

- Added an **S3 trigger** on the raw JSON folder to invoke the Lambda function.
- Lambda automatically creates a Parquet version and updates the Glue catalog.

---

### 7. 🧪 ETL for CSV Data with PySpark

- Initially attempted Glue Visual ETL – faced encoding & special character issues.
- Switched to **custom PySpark job**:
  - Read CSV from raw S3
  - Added "region" column manually
  - Wrote cleaned Parquet to a new S3 location partitioned by region
- Crawled the cleaned CSV folder to update Glue Catalog.

---

### 8. 🔁 Final Join with Glue Visual ETL

- Used **Glue Visual ETL Job** to join the cleaned JSON and cleaned CSV datasets.
- Output written to a new **Analytics S3 folder**.
- Created final **Analytics Glue Catalog Table**.

---

### 9. 📊 Visualization with QuickSight

- Connected **QuickSight** to **Athena**.
- Imported the **Analytics table** for reporting.
- Built insightful dashboards using dimensions like region, category, and more.

---

## 📌 Final Notes

- The project demonstrates an end-to-end Data Lake architecture.
- Highlights the strengths and limitations of AWS-native tools.
- Offers hands-on experience with data wrangling, schema handling, and reporting.

---

## 📁 Directory Structure

