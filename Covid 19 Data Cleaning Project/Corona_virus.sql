USE corona_analysis;

SELECT * 
FROM corona_data;

-- Data Cleaning

-- Q1) If NULL values are present, update them with zeros for all columns.
SELECT * 
FROM corona_data
WHERE Province IS NULL OR
'Country/Region' IS NULL OR
Latitude IS NULL OR
Longitude IS NULL OR 
`Date` IS NULL OR
Confirmed IS NULL OR
Deaths IS NULL OR
Recovered IS NULL;

UPDATE corona_data
SET Confirmed = 0 
WHERE Confirmed IS NULL;

SELECT * 
FROM corona_data;

-- Q2) Check total number of rows
SELECT 
	COUNT(*) AS total_rows 
FROM corona_data
;

-- Q3) Check total number of rows in the Province column
SELECT 
	COUNT(DISTINCT Province) AS total_province_rows 
FROM corona_data
;

-- Q4) Check what is start_date and end_date

-- First we convert the Date from a string to Date, format is (Year, Month, Day)
UPDATE 
	corona_data
SET `Date` = STR_TO_DATE(`Date`, '%Y-%m-%d');

ALTER TABLE corona_data
MODIFY COLUMN `Date` DATE;

SELECT 
	MIN(`Date`) AS start_date, 
	MAX(`Date`) AS end_date
FROM corona_data;

 
-- Q5) Get the number of months present in the dataset
SELECT COUNT(DISTINCT SUBSTR(`Date`, 1, 7)) AS `MONTH`     -- Need both the year and month to count total months because there's different months and years
FROM corona_data
;

-- Q6) Find the monthly average for Confirmed, Deaths and Recovered
SELECT 
	DISTINCT SUBSTR(`Date`, 1, 7) AS `MONTH`, 
	ROUND (AVG(Confirmed), 2) AS avg_confirmed,         -- Monthly average for Confirmed (rounded off to two decimal places) 
	AVG(Deaths) AS avg_deaths,        -- Monthly average for Deaths 
	AVG(Recovered) AS avg_recovered   -- Monthly average for Recovered 
FROM 
	corona_data
GROUP BY `MONTH`
ORDER BY `MONTH` DESC; 

-- Q7) Find minimum values for Confirmed, Deaths, Recovered per year
SELECT 
	DISTINCT YEAR(`Date`) AS `YEAR`,
	MIN(Confirmed) AS min_confirmed,
	MIN(Deaths) AS min_deaths,
	MIN(Recovered) AS min_recovered
FROM 
	corona_data
WHERE 
	Confirmed != 0 AND Deaths != 0 AND Recovered != 0 -- This is to avoid showing the zeros 
GROUP BY `YEAR`
ORDER BY `YEAR` DESC;

-- Q8) Find total number of cases for Confirmed, Deaths, Recovered each month
SELECT 
	DISTINCT SUBSTR(`Date`, 1, 7) AS `MONTH`, 
	SUM(Confirmed) AS tot_confirmed,         -- Total Confirmed
	SUM(Deaths) AS tot_deaths,        
	SUM(Recovered) AS tot_recovered    
FROM 
	corona_data
GROUP BY 
	`MONTH`
ORDER BY 
	`MONTH` DESC;

-- Q9) Find the country that has the highest number of Confirmed case

-- Solution 1

-- First we find the total Confirmed case for each country
SELECT 
	`Country/Region` AS Country, 
	SUM(Confirmed) AS tot_confirmed  
FROM 
	corona_data
GROUP BY 
	Country;

-- Then we find the Country with the highest total Confirmed case
SELECT 
	`Country/Region` AS Country, 
	SUM(Confirmed) AS tot_confirmed  
FROM corona_data
GROUP BY Country
ORDER BY tot_confirmed DESC
LIMIT 1;

-- Solution 2 (CTE)

WITH tot_confirmed_count AS
(
	SELECT 
		`Country/Region` AS Country,
		SUM(Confirmed) AS tot_confirmed
	FROM corona_data
	GROUP BY `Country/Region`
),

tot_confirmed_rank AS
(
    SELECT 
        Country,
        tot_confirmed,
        RANK() OVER (ORDER BY tot_confirmed DESC) AS Ranking
    FROM tot_confirmed_count
)

SELECT Country
FROM tot_confirmed_rank
WHERE Ranking = 1;

/*
____________Explanation of the code above:___________________

The first CTE: tot_confirmed_count
	- Groups the data by country
	- Calculates the total confirmed cases
    
The second CTE: tot_confirmed_rank
	- Uses a window function
	- Ranks countries by total confirmed cases
    
Final query: WHERE Ranking = 1 
	- Returns the country with the highest confirmed cases
*/