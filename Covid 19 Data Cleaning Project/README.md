# 🦠 COVID-19 Data Analysis (SQL Project)



## 📌 Project Overview

This project focuses on analyzing COVID-19 data using SQL. The dataset contains information on confirmed cases, deaths, and recoveries across different countries and time periods.

The goal of this project is to:

1) Clean and prepare raw COVID-19 data

2) Perform exploratory data analysis (EDA)

3) Extract meaningful insights using SQL queries



## 🗂️ Dataset Description

The dataset (corona_data.csv) includes the following columns:

- Province – Region or state within a country

- Country/Region – Country name

- Latitude & Longitude – Geographic coordinates

- Date – Recorded date of data

- Confirmed – Number of confirmed COVID-19 cases

- Deaths – Number of deaths

- Recovered – Number of recoveries



## 🧹 Data Cleaning Steps

Before performing analysis, the dataset was cleaned:

- Identified NULL values across all columns
- Replaced NULL values in - Confirmed with 0
- Converted Date column from string to proper DATE format
- Modified table structure to ensure accurate date handling


## 🔍 Key SQL Analysis Tasks



**1. Data Validation**

- Checked for NULL values

- Counted total number of rows

- Counted distinct provinces



**2. Time-Based Analysis**

- Identified dataset start and end dates

- Calculated number of months in dataset

- Converted date format for accurate time analysis



**3. Monthly Trends**

Calculated monthly averages for:

- Confirmed cases

- Deaths

- Recoveries

- Calculated monthly totals for all key metrics



**4. Yearly Insights**

Found minimum yearly values for:

- Confirmed cases

- Deaths

- Recoveries

Excluded zero values for more meaningful insights



**5. Country-Level Analysis**

- Identified the country with the highest total confirmed cases

- Implemented two approaches:

- Basic aggregation with GROUP BY

- Advanced approach using CTEs and window functions



## Sample SQL Queries



🔹 1. Checking for NULL Values
```sql
SELECT *

FROM corona_data

WHERE Confirmed IS NULL 

   OR Deaths IS NULL 

   OR Recovered IS NULL;
```


🔹 2. Total Number of Rows
```sql
SELECT COUNT(*) AS total_rows

FROM corona_data;
```


🔹 3. Dataset Date Range
```sql
SELECT 

    MIN(Date) AS start_date,

    MAX(Date) AS end_date

FROM corona_data;
```


🔹 4. Monthly Average Cases
```sql
SELECT 

    YEAR(Date) AS year,

    MONTH(Date) AS month,

    AVG(Confirmed) AS avg_confirmed,

    AVG(Deaths) AS avg_deaths,

    AVG(Recovered) AS avg_recovered

FROM corona_data

GROUP BY YEAR(Date), MONTH(Date)

ORDER BY year, month;
```


🔹 5. Monthly Total Cases
```sql
SELECT 

    YEAR(Date) AS year,

    MONTH(Date) AS month,

    SUM(Confirmed) AS total_confirmed,

    SUM(Deaths) AS total_deaths,

    SUM(Recovered) AS total_recovered

FROM corona_data

GROUP BY YEAR(Date), MONTH(Date)

ORDER BY year, month;
```


🔹 6. Country with Highest Confirmed Cases
```sql
SELECT Country_Region, SUM(Confirmed) AS total_confirmed

FROM corona_data

GROUP BY Country_Region

ORDER BY total_confirmed DESC

LIMIT 1;
```


🔹 7. Using CTE & Ranking
```sql
WITH country_totals AS (

    SELECT 

        Country_Region,

        SUM(Confirmed) AS total_confirmed

    FROM corona_data

    GROUP BY Country_Region

)

SELECT *,

       RANK() OVER (ORDER BY total_confirmed DESC) AS rank_position

FROM country_totals;
```




## 🧠 Advanced SQL Concepts Used



This project demonstrates practical use of:

- Aggregate Functions (SUM, AVG, MIN)

- Date Functions (YEAR, SUBSTR, STR_TO_DATE)

- Grouping (GROUP BY)

- Sorting (ORDER BY)

- Common Table Expressions (CTEs)

- Window Functions (RANK())



## 📊 Key Insights



- Monthly trends help track the progression of the pandemic over time
- Aggregated country-level data highlights the most affected regions
- Data cleaning ensures accuracy in all analytical results


## 🎯 What I Learned



Through this project, I developed and strengthened my skills in:
- Writing efficient SQL queries for real-world datasets
- Cleaning and preparing messy data for analysis
- Using date functions to analyze time-series data
- Applying aggregations to uncover trends and patterns
- Leveraging CTEs and window functions for advanced analysis
- Structuring SQL projects in a way that is clear and portfolio-ready