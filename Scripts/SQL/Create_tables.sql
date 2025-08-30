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