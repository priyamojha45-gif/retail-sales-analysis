-- E-Commerce Sales Analysis | MySQL
-- Dataset: Olist Brazilian E-Commerce Public Dataset
-- MySQL 8.0+
-- This project demonstrates SELECT, WHERE, GROUP BY, JOIN, aggregations, CASE and CTEs.

CREATE DATABASE IF NOT EXISTS ecommerce_sales;
USE ecommerce_sales;

DROP VIEW IF EXISTS vw_sales_analysis;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);

CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME NULL,
    order_delivered_carrier_date DATETIME NULL,
    order_delivered_customer_date DATETIME NULL,
    order_estimated_delivery_date DATETIME NULL
);

CREATE TABLE products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_lenght INT NULL,
    product_description_lenght INT NULL,
    product_photos_qty INT NULL,
    product_weight_g INT NULL,
    product_length_cm INT NULL,
    product_height_cm INT NULL,
    product_width_cm INT NULL
);

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME NULL,
    price DECIMAL(12,2),
    freight_value DECIMAL(12,2)
);

-- Import the four required CSV files after placing them in MySQL's secure upload folder.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Basic validation
SELECT COUNT(*) AS customers FROM customers;
SELECT COUNT(*) AS orders FROM orders;
SELECT COUNT(*) AS products FROM products;
SELECT COUNT(*) AS order_items FROM order_items;

-- 1. Total sales
SELECT ROUND(SUM(price),2) AS total_sales FROM order_items;

-- 2. Total orders
SELECT COUNT(DISTINCT order_id) AS total_orders FROM orders;

-- 3. Total customers
SELECT COUNT(DISTINCT customer_unique_id) AS total_customers FROM customers;

-- 4. Average order value
SELECT ROUND(SUM(oi.price) / COUNT(DISTINCT oi.order_id),2) AS average_order_value
FROM order_items oi;

-- 5. Monthly sales
SELECT DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS sales_month,
       ROUND(SUM(oi.price),2) AS sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m')
ORDER BY sales_month;

-- 6. Sales by customer state
SELECT c.customer_state,
       ROUND(SUM(oi.price),2) AS sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY sales DESC;

-- 7. Top 10 product categories
SELECT p.product_category_name,
       ROUND(SUM(oi.price),2) AS sales
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY sales DESC
LIMIT 10;

-- 8. Order status distribution
SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- 9. Top 10 products
SELECT product_id, ROUND(SUM(price),2) AS sales
FROM order_items
GROUP BY product_id
ORDER BY sales DESC
LIMIT 10;

-- 10. Average item price by category
SELECT p.product_category_name,
       ROUND(AVG(oi.price),2) AS average_price
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY average_price DESC;

-- 11. Average delivery time
SELECT ROUND(AVG(DATEDIFF(order_delivered_customer_date,
                           order_purchase_timestamp)),1) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- 12. CASE statement for order grouping
SELECT order_status,
       COUNT(*) AS order_count,
       CASE
           WHEN order_status = 'delivered' THEN 'Completed'
           WHEN order_status IN ('canceled','unavailable') THEN 'Unsuccessful'
           ELSE 'In Progress / Other'
       END AS performance_group
FROM orders
GROUP BY order_status;

-- 13. CTE for monthly sales
WITH monthly_sales AS (
    SELECT DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS sales_month,
           SUM(oi.price) AS sales
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m')
)
SELECT sales_month, ROUND(sales,2) AS sales
FROM monthly_sales
ORDER BY sales DESC;

-- 14. Customer order frequency
SELECT c.customer_unique_id,
       COUNT(DISTINCT o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY order_count DESC
LIMIT 20;

-- 15. Power BI-ready analytical view
CREATE OR REPLACE VIEW vw_sales_analysis AS
SELECT o.order_id,
       o.order_status,
       o.order_purchase_timestamp,
       c.customer_unique_id,
       c.customer_city,
       c.customer_state,
       oi.order_item_id,
       oi.product_id,
       p.product_category_name,
       oi.price,
       oi.freight_value,
       (oi.price + oi.freight_value) AS total_item_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id;

SELECT * FROM vw_sales_analysis LIMIT 100;
