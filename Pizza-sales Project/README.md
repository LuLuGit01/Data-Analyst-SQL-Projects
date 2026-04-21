# 🍕 Pizza Sales Analysis (SQL Project)



## 📌 Project Overview



This project focuses on analyzing pizza sales data using SQL. The dataset includes information about orders, pizza types, pricing, and quantities sold.

The goal of this project is to:

- Clean and prepare raw sales data

- Perform exploratory data analysis (EDA)

- Extract meaningful business insights using SQL queries



## 🗂️ Dataset Description



The project uses four related datasets:



**1. orders**

- order_id – Unique identifier for each order

- date – Order date

- time – Order time



**2. order_details**

- order_details_id – Unique row identifier

- order_id – Links to orders table

- pizza_id – Links to pizzas table

- quantity – Number of pizzas ordered



**3. pizzas**

- pizza_id – Unique pizza identifier

- pizza_type_id – Links to pizza types

- size – Pizza size (S, M, L, XL, XXL)

- price – Price of the pizza



**4. pizza_types**

- pizza_type_id – Unique pizza type

- name – Name of the pizza

- category – Category (e.g., Classic, Veggie, Chicken)

- ingredients – List of ingredients



## 🧹 Data Preparation Steps



Before analysis, the database was structured and prepared:

1) Created tables using SQL scripts
2) Defined relationships between datasets using keys
3) Ensured correct data types for date, time, and numeric fields
4) Verified data integrity across all tables


## 🔍 Key SQL Analysis Tasks



### 1. Basic Analysis

- Total number of orders

- Total revenue generated

- Highest priced pizza

- Most common pizza size ordered



### 2. Intermediate Analysis

- Top 5 most ordered pizzas

- Total quantity of pizzas per category

- Order distribution by hour of the day

- Category-wise distribution of pizzas



### 3. Advanced Analysis

- Revenue contribution by each pizza type

- Cumulative revenue over time

- Top 3 pizzas by revenue within each category



## 💻 Sample SQL Queries



🔹 1. Total Number of Orders
```SQL
SELECT COUNT(*) AS total_orders

FROM orders;
```


🔹 2. Total Revenue
```SQL
SELECT SUM(od.quantity * p.price) AS total_revenue

FROM order_details od

JOIN pizzas p ON od.pizza_id = p.pizza_id;
```


🔹 3. Most Common Pizza Size
```SQL
SELECT p.size, COUNT(*) AS order_count

FROM pizzas p

JOIN order_details od ON p.pizza_id = od.pizza_id

GROUP BY p.size

ORDER BY order_count DESC;
```


🔹 4. Top 5 Most Ordered Pizzas
```SQL
SELECT pt.name, SUM(od.quantity) AS total_quantity

FROM order_details od

JOIN pizzas p ON od.pizza_id = p.pizza_id

JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id

GROUP BY pt.name

ORDER BY total_quantity DESC

LIMIT 5;
```


🔹 5. Revenue by Pizza Type
```SQL
SELECT pt.name, SUM(od.quantity * p.price) AS revenue

FROM order_details od

JOIN pizzas p ON od.pizza_id = p.pizza_id

JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id

GROUP BY pt.name

ORDER BY revenue DESC;
```


🔹 6. Cumulative Revenue Over Time
```SQL
SELECT 

    o.date,

    SUM(od.quantity * p.price) AS daily_revenue,

    SUM(SUM(od.quantity * p.price)) OVER (ORDER BY o.date) AS cumulative_revenue

FROM orders o

JOIN order_details od ON o.order_id = od.order_id

JOIN pizzas p ON od.pizza_id = p.pizza_id

GROUP BY o.date;
```


## 🧠 Advanced SQL Concepts Used



This project demonstrates practical use of:

- Aggregate Functions (SUM, COUNT)
- Joins (INNER JOIN across multiple tables)
- Grouping (GROUP BY)
- Sorting (ORDER BY)
- Window Functions (OVER, cumulative calculations)
- Subqueries and multi-table analysis


## 📊 Key Insights



- Certain pizza sizes are significantly more popular than others
- A small number of pizza types contribute heavily to total revenue
- Sales patterns vary by time of day, indicating peak ordering hours
- Category-level analysis reveals customer preferences


## 🎯 What I Learned



Through this project, I developed and strengthened my skills in:

- Writing efficient SQL queries for relational datasets
- Designing and working with multi-table databases
Performing real-world sales analysis
- Extracting business insights from raw transactional data
- Using advanced SQL features like window functions
- Structuring a clean and professional data project for a portfolio