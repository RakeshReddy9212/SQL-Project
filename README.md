Retail Sales Analysis – SQL & Python Project

📌 Project Overview

This project demonstrates a Retail Sales Analysis workflow, combining data cleaning with Python (Pandas) and insightful SQL queries for business intelligence.
It is designed to answer key business questions like top-performing regions, customer profitability, seasonal trends, and discount impact.

Project Structure

Retail-Sales-Analysis/
│
├── README.md                  # Project overview (GitHub shows this automatically)
│
├── data/
│   ├── raw/                   # Original datasets (Superstore.csv, orders.csv)
│   └── cleaned/               # Cleaned data (Superstore_clean.csv, clean_orders.csv)
│
├── scripts/
│   ├── python/                # Data cleaning and processing scripts
│   │   ├── clean_order.py
│   │   └── clean_superstore.py
│   └── sql/                   # SQL schema and queries
│       ├── Create_tables.sql
│       └── SQL_code.sql


🛠️ Tools & Technologies

Python (Pandas) – For data cleaning, preprocessing, and preparing datasets for analysis

PostgreSQL – For structured data storage and relational querying

SQL – For running analytical queries and generating business intelligence insights

CSV – As a format for raw and cleaned datasets

⚙️ Setup & Usage
1️⃣ Data Cleaning with Python

Run the cleaning scripts to preprocess datasets:

# Clean Orders dataset
import pandas as pd

df = pd.read_csv("Datasets/orders.csv", encoding="latin1")
#Changing DATE Formate 

df['order_date'] =pd.to_datetime(df['order_date'],format="%m/%d/%Y").dt.strftime("%Y-%m-%d")
df['ship_date'] =pd.to_datetime(df['ship_date'],format="%m/%d/%Y").dt.strftime("%Y-%m-%d")

df = df.drop_duplicates()

df.to_csv("clean_orders.csv", index=False, encoding="utf-8")

# Clean Superstore dataset

import pandas as pd
df = pd.read_csv("Datasets/Superstore.csv", encoding="latin1")

#Convert dates

df["Order Date"] = pd.to_datetime(df["Order Date"], format="%m/%d/%Y").dt.strftime("%Y-%m-%d")
df["Ship Date"] = pd.to_datetime(df["Ship Date"], format="%m/%d/%Y").dt.strftime("%Y-%m-%d")

df = df.drop_duplicates()

#Clean text fields (remove newlines, extra quotes)

for col in df.select_dtypes(include="object").columns:
    df[col] = df[col].astype(str).str.replace("\n", " ", regex=False).str.replace("\r", " ", regex=False).str.replace('"', '""', regex=False)

df.to_csv("Superstore_clean.csv", index=False, encoding="utf-8", quoting=1)

These scripts:

Convert date formats to YYYY-MM-DD

Remove duplicate rows

Clean text fields for consistency (Superstore dataset)

Save cleaned CSVs ready for database import

2️⃣ Create Database Schema

Use the provided schema to set up tables:

CREATE DATABASE SQL_Project;

CREATE TABLE superstore (
row_id INT,
order_id TEXT,
order_date DATE,
ship_date DATE,
ship_mode TEXT,
customer_id TEXT,
customer_name TEXT,
segment TEXT,
country TEXT,
city TEXT,
state TEXT,
postal_code INT,
region TEXT,
product_id TEXT,
category TEXT,
sub_category TEXT,
product_name TEXT,
sales NUMERIC,
quantity INT,
discount NUMERIC,
profit NUMERIC
);

CREATE TABLE regions(
region TEXT,
region_id INT
);

CREATE TABLE products(
product_id	TEXT,
product_name TEXT,
subcategory_id INT
);
Create table orders (
order_id Text,
order_date	Date,
ship_date	Date,
customer_id	Text,
region_id  INT

);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
customer_id	TEXT,
customer_name	TEXT,
segment TEXT
);

CREATE TABLE categories
(
category	TEXT,
category_id INT
);

CREATE TABLE order_details(
order_id TEXT,
product_id	TEXT,
sales	FLOAT,
quantity INT,
discount FLOAT,
profit FLOAT

);

This creates the following tables:

superstore

orders

order_details

customers

regions

products

categories

3️⃣ Run Business Queries

    Execute analytical queries from SQL_code.sql to answer questions like:

    Revenue & Profit by Region

    Top 10 Most Valuable Customers

    Impact of Discounts on Profitability

    Seasonal Sales Trends

    Regions Most Dependent on Discounts

    Profitability of Repeat vs One-Time Customers

📊 Key Insights

    Identified high-revenue regions and their profit margins.

    Determined top customers driving revenue.

    Analyzed discount strategies to reveal their impact on profitability.

    Discovered seasonal sales peaks for better inventory planning.

    Compared profitability of repeat vs. one-time customers.

🚀 Future Improvements

    Automate data pipeline with Airflow or Prefect.

    Add interactive dashboards with Power BI or Tableau.

    Deploy insights through a Flask or Streamlit app.

🤝 Contribution

    Pull requests are welcome! For major changes, please open an issue first to discuss what you’d like to modify.