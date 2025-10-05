# Zomato SQL Project: Data Analysis for a Food Delivery Company
Welcome to the GitHub repository for the Zomato SQL Project. This project demonstrates my SQL problem-solving capabilities through an in-depth analysis of Zomato, a leading food delivery service in India. Within this repository, you will find a comprehensive breakdown of the project structure, meticulously crafted SQL queries, and the key insights derived from the data analysis.
<br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/zomato_Review-1.jpg">
## Project Overview

This project showcases my proficiency in addressing intricate SQL challenges within a business context. The primary objective was to analyze Zomato's customer and order data to uncover valuable insights, resolve business issues, and provide actionable recommendations. The database encompasses detailed information about customers, restaurants, orders, and deliveries.

## Entity-Relationship Diagram (ERD)
The dataset comprises five tables: `Customers`, `Resturants`, `riders`, `Orders`, and `Delivery`. Below is the structure of the ERD that represents the relationships among these tables.

<img width="646" alt="image" src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/ERD.png">


## Database Schema
### Tables and Columns
**customers**
- `customer_id`: Unique identifier for each customer
- `customer_name`: Name of the customer
- `reg_date`: registration date of the customer

**resturants**
- `resturant_id`: Unique identifier for each resturant
- `resturant_name`: Name of the resturant
- `city`: Name of the city where resturant is located
- `opening_hours`: Opening hours of the resturant

**riders**
- `rider_id`: Unique identifier for rider
- `product_name`: Name of the rider
- `sign_up`: sign up date

**sales**
- `order_id`: Unique identifier for each order
- `customer_id`: refrences from customer table
- `resturant_id`: refrences from resturants table
- `order_item`: Name of the Food order placed
- `order_date`: order date
- `order_time`: order time
- `order_status`: order status
- `total_amount`:The total amount for each order_id placed.

**deliveries**
- `delivery_id`: Unique identifier for each deliveries
- `order_id`: References the orders table
- `delivery_status`: Status of the delivery
- `delivery_time`: delivery time of the order
- `rider_id`: Refrences the riders table
## Objectives
Solve day-to-day complex business problems of online food delivery business using POSTGRESS SQL.
Develop complex queries to analyze and retrieve specific data:

# Business problems and Queries for solution
### Use collapsible drop down to view business problems and solutions
## Q1. Write a Query to find the top 5   most frequently ordered dishes by customer called  "Akhil Reddy" in the last 1 year.
<details><summary>
<strong>Description</strong>: Return the records of last 1 year with customer_id, customer_name,dishes and total count of dishes.</summary>
<br><strong>SQL Code</strong>

  ```sql

  SELECT
    customer_name,
    dishes,
    total_dishes
  FROM
    (SELECT
        c.customer_id,
        c.customer_name,
        o.order_item AS dishes,
        COUNT(order_id) AS total_dishes,
        DENSE_RANK() OVER (ORDER BY COUNT(order_id) DESC) AS RANK
      FROM
        orders o
        JOIN customers c ON o.customer_id = c.customer_id
      WHERE
        o.order_date >= CURRENT_DATE - INTERVAL '1 Year'
        AND c.customer_name = 'Akhil Reddy'
      GROUP BY
        1,
        2,
        3
      ORDER BY
        1,
        4 DESC
    ) AS t1
  WHERE
    RANK <= 5;
  ```
</details>
<details>
<summary><strong>Expected Output</strong>: A list of top 5 most frequently orderd dishes by Customer Name called "Akhil Reddy".</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_1_output.png" height="200">
</details>
    

## Q2. Write a query to find the Popular time slots.
<details><summary>
<strong>Description</strong>: Identify the time slots during which more orders are placed.Based on 2 hour interval.</summary>
<br><strong>SQL Code</strong>

  ```sql
--FIRST APPROACH--

SELECT 
	CASE
		when EXTRACT (HOUR FROM order_time) between 0 and 1 then '00:00:00 - 02:00:00'
		when EXTRACT (HOUR FROM order_time) between 2 and 3 then '02:00:00 - 04:00:00'
		when EXTRACT (HOUR FROM order_time) between 4 and 5 then '04:00:00 - 06:00:00'
		when EXTRACT (HOUR FROM order_time) between 6 and 7 then '06:00:00 - 08:00:00'
		when EXTRACT (HOUR FROM order_time) between 8 and 9 then '08:00:00 - 10:00:00'
		when EXTRACT (HOUR FROM order_time) between 10 and 11 then '10:00:00 - 12:00:00'
		when EXTRACT (HOUR FROM order_time) between 12 and 13 then '12:00:00 - 14:00:00'
		when EXTRACT (HOUR FROM order_time) between 14 and 15 then '14:00:00 - 16:00:00'
		when EXTRACT (HOUR FROM order_time) between 16 and 17 then '16:00:00 - 18:00:00'
		when EXTRACT (HOUR FROM order_time) between 18 and 19 then '18:00:00 - 20:00:00'
		when EXTRACT (HOUR FROM order_time) between 20 and 21 then '20:00:00 - 22:00:00'
		when EXTRACT (HOUR FROM order_time) between 22 and 23 then '22:00:00 - 00:00:00'
	END AS time_slot,
	count(order_id) as order_count
FROM
	orders
GROUP BY
	1
ORDER BY
	2 DESC;

--SECOND APPROACH--

SELECT
	FLOOR(EXTRACT(HOUR FROM order_time) / 2) * 2 AS start_time,
	FLOOR(EXTRACT(HOUR FROM order_time) / 2) * 2 +2 AS end_time,
	COUNT(order_id) AS order_count
FROM
	orders
GROUP BY
	1,
	2
ORDER BY
	3 DESC;

  ```
</details>
<details>
<summary><strong>Expected Output</strong>:Retrieving the count of orders placed within each 2-hour time slot throughout the day.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_2_output.png">
</details>

## Q3. Write a query to find Order value analysis.
<details><summary>
<strong>Description</strong>: Find the average order value per customer who has palced more than 750 orders.</summary>
<br><strong>SQL Code</strong>

  ```sql

SELECT
	c.customer_id,
	c.customer_name,
	COUNT(order_id) AS total_count,
	SUM(o.total_amount) AS total_spend 
FROM
	orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id 
GROUP BY
	1
HAVING
	COUNT(order_id) > 750;

	3 DESC;

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Retrieving the Customername and Average order value(AOV).</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_3_output.png">
</details>


## Q4. Write a query to find High value customer.
<details><summary>
<strong>Description</strong>: List the customers who hace spend more than 100K in total on food orders.</summary>
<br><strong>SQL Code</strong>

  ```sql

SELECT
	c.customer_id,
	c.customer_name,
	COUNT(order_id) AS total_count,
	SUM(o.total_amount) AS total_spend 
FROM
	orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id 
GROUP BY
	1
HAVING
	COUNT(order_id) > 750;

	3 DESC;

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Retrieving the return customer_name and customer_id who have spend more than 100K based on highest value.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_4_output.png">
</details>

## Q5. Write a query to find Orders without Delivery.
<details><summary>
<strong>Description</strong>: Identifying the orders that were placed but not deliverd.</summary>
<br><strong>SQL Code</strong>

  ```sql

SELECT
	r.resturant_name,
	r.city,
	COUNT(o.order_id) AS count_not_delivered
FROM
	orders o
	LEFT JOIN resturants r ON o.resturant_id = r.resturant_id
WHERE
	o.order_id NOT IN (
		SELECT
			order_id
		FROM
			deliveries
	)
GROUP BY
	1,
	2 
ORDER BY
	3 DESC;

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Return each Resturant name, City and the number of the orders that were not delivered.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_5_output.png">
</details>

## Q6. Write a query for Revenue Ranking.
<details><summary>
<strong>Description</strong>: Rank resturants by their total revenue from the last year, including their name,
total revenue and rank with in their city.</summary>
<br><strong>SQL Code</strong>

  ```sql

WITH
	ranking_table AS (
		SELECT
			r.city,
			r.resturant_name,
			SUM(o.total_amount) AS total_revenue,
			DENSE_RANK() OVER (PARTITION BY r.city ORDER BY SUM(o.total_amount) DESC) AS RANK
		FROM
			orders o
			JOIN resturants r ON o.resturant_id = r.resturant_id
		WHERE
			o.order_date > CURRENT_DATE - INTERVAL '1 Year'
		GROUP BY
			1,
			2
	)
SELECT
	*
FROM
	ranking_table
WHERE
	RANK = 1;

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Retrieving the top ranking resturants(rank=1) from each city base on the total revenue of the each resturant from the previous year </summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_6_output.png">
</details>

## Q7. Write a query for Most Popluar Dish by City
<details><summary>
<strong>Description</strong>: Identify the most popluar dish in each city based on the number of the orders.</summary>
<br><strong>SQL Code</strong>

  ```sql

WITH
	ranking_table AS (
		SELECT
			r.city,
			r.resturant_name,
			SUM(o.total_amount) AS total_revenue,
			DENSE_RANK() OVER (PARTITION BY r.city ORDER BY SUM(o.total_amount) DESC) AS RANK
		FROM
			orders o
			JOIN resturants r ON o.resturant_id = r.resturant_id
		WHERE
			o.order_date > CURRENT_DATE - INTERVAL '1 Year'
		GROUP BY
			1,
			2
	)
SELECT
	*
FROM
	ranking_table
WHERE
	RANK = 1;

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Retrieving the top ranking(rank=1) popular Dish Name from each city and the number of orders placed from each city </summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_7_output.png">
</details>

## Q8. Write a query to generate Customer churn
<details><summary>
<strong>Description</strong>: Identify the customers who havent placed orders in 2024 but in 2023.</summary>
<br><strong>SQL Code</strong>

  ```sql
SELECT DISTINCT
	c.customer_id,
	c.customer_name
FROM
	orders o
	LEFT JOIN customers c on o.customer_id = c.customer_id
WHERE
	EXTRACT(YEAR FROM order_date) = 2023
	AND c.customer_id 
	NOT IN (SELECT DISTINCT customer_id
			FROM
				orders
			WHERE EXTRACT(YEAR FROM order_date) = 2024) 
group by
	1,
	2;

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Retrieving the Customer ID and Customer Name </summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_8_output.png">
</details>


## Q9. Write a query to generate genrate Cancellation Rate Comparrison Report
<details><summary>
<strong>Description</strong>: Calcuate and compare the order cancellation rate for each resturant between the current year and the previous year.</summary>
<br><strong>SQL Code</strong>

  ```sql
--Finding number of orders that were place in previous year (2023) and got cancelled
--Creating CTE for the previous year(2023) cancelled orders

WITH canceled_orders_2023 AS (
    SELECT
        o.resturant_id,
        COUNT(o.order_id) AS total_orders,
        COUNT(CASE WHEN d.delivery_id IS NULL THEN 1 END) AS not_delivered
    FROM
        orders o
        LEFT JOIN deliveries d ON o.order_id = d.order_id
    WHERE
        EXTRACT(YEAR FROM order_date) = 2023
    GROUP BY
        o.resturant_id
),
--Finding number of orders that were place in current year (2024) and got cancelled
--Creating CTE for the current year(2024) cancelled orders
canceled_orders_2024 AS (
    SELECT
        o.resturant_id,
        COUNT(o.order_id) AS total_orders,
        COUNT(CASE WHEN d.delivery_id IS NULL THEN 1 END) AS not_delivered
    FROM
        orders o
        LEFT JOIN deliveries d ON o.order_id = d.order_id
    WHERE
        EXTRACT(YEAR FROM order_date) = 2024
    GROUP BY
        o.resturant_id
),

--Finding the previous year(2023) cancellation ratio with refference to CTE(canceled_orders_2023)
-- Creating CTE for cancellatiom ratio for the previous_year(2023) 
previous_year_data AS (
    SELECT
        resturant_id,
        total_orders,
        not_delivered,
        ROUND((not_delivered::NUMERIC / total_orders::NUMERIC) * 100, 2) AS cancellation_rate
    FROM
        canceled_orders_2023
),

--Finding the previous year(2024) cancellation ratio with refference to CTE(canceled_orders_2024)
-- Creating CTE for cancellatiom ratio for the current_year(2024) 
current_year_data AS (
    SELECT
        resturant_id,
        total_orders,
        not_delivered,
        ROUND((not_delivered::NUMERIC / total_orders::NUMERIC) * 100, 2) AS cancellation_rate
    FROM
        canceled_orders_2024
)

------Canellation Rate comparrision between Previous year and Current_year----

SELECT 
	p.resturant_id,
	p.cancellation_rate as previous_year_Cancellation_raton,
	cn.cancellation_rate as Current_year_cancelation_ratio
FROM
    previous_year_data p
    JOIN current_year_data cn ON p.resturant_id = cn.resturant_id;

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Retrieving the Resturant ID,cancellation ratio's of previous year and curent year.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_9_output.png">
</details>

## Q10. Write a query to find Rider average delivery_time.
<details><summary>
<strong>Description</strong>: Determine each rider's  average delivery time.</summary>
<br><strong>SQL Code</strong>

  ```sql

WITH average_rider_time AS(

SELECT
	o.order_id,
	rider_id,
	o.order_time,
	d.delivery_time,
	d.delivery_time - o.order_time AS time_difference,--Gives time diffrence in HH:MM:SS
	ROUND(EXTRACT(EPOCH FROM(d.delivery_time - o.order_time + --Using Epoch we can calculate the time differrence in seconds
	CASE 
		WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day'--Epoch can only capture the total number of seconds
		ELSE INTERVAL '0 day'END)),2) AS time_differrence_in_sec,
	ROUND(EXTRACT(EPOCH FROM(d.delivery_time - o.order_time + --However we can conver them into minutes by dividing
	CASE 
		WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day'--total diffrence time in seconds/60
		ELSE INTERVAL '0 day'END))/60,2) AS time_differrence_in_minutes
FROM
	orders o
	JOIN deliveries d ON o.order_id = d.order_id
WHERE
	d.delivery_status = 'Delivered'
)

SELECT
	rider_id,
	ROUND(AVG(time_differrence_in_minutes), 2) AS average_time
FROM
	average_rider_time 
GROUP BY
	1;

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Return each Rider ID City, Average time.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_10_output.png">
</details>

## Q11. Write a Query to find  Monthly Resturant growth Ratio.
<details><summary>
<strong>Description</strong>: Calculate each resturants growth ratio based on the total number of delivered orders since it's joining.</summary>
<br><strong>SQL Code</strong>

  ```sql

  WITH monthly_growth_rate as(
SELECT
	o.resturant_id,
	TO_CHAR(o.order_date, 'mm-yyyy') AS MONTH,
	COUNT(o.order_id) AS current_month_order_count,
	LAG(COUNT(o.order_id)) OVER (PARTITION BY o.resturant_id
	ORDER BY TO_CHAR(o.order_date, 'mm-yyyy')) AS previous_month_order_count
FROM
	orders o
	JOIN deliveries d ON o.order_id = d.order_id
WHERE
	d.delivery_status = 'Delivered'
GROUP BY
	1,
	2
ORDER BY
	1,
	2
)

select 
	resturant_id,
	month,
	previous_month_order_count,
	current_month_order_count,
	round((current_month_order_count::numeric -previous_month_order_count::numeric)/
	previous_month_order_count*100,2) as growth_ratio
from 
	monthly_growth_rate
  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Returning Resturant ID, month count of previous month and current month,groth rate.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_11_output.png">
</details>

## Q12. Write a Query to generate Customer Segmentation Report.
<details><summary>
<strong>Description</strong>: Customer Segmentation: Segment customers into 'Gold' or 'Silver' groups based on their total spending
compared to the average order value(AOV). If a customer's total spending exceeds the AOV, label them as 'Gold';otherwise, label tehm as 'Silver'. 
write an sql query to determine each segment's number of orders and total revenue.</summary>
<br><strong>SQL Code</strong>

  ```sql
 
SELECT
	customer_category,
	SUM(total_orders) AS total_orders,
	SUM(total_spent) AS total_revenue
FROM
	(SELECT
		customer_id,
		SUM(total_amount) AS total_spent,
		COUNT(order_id) AS total_orders,
		CASE
			WHEN SUM(total_amount) > (SELECT AVG(total_amount) FROM orders) THEN 'Gold'
			WHEN SUM(total_amount) < (SELECT AVG(total_amount) FROM orders) THEN 'Silver'
		END as customer_category
	FROM
		orders
	GROUP BY
		1
) as t1
GROUP BY	
	1;
  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Returning Customer Category,Total Orders,Total Revenue.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_13_output.png" height="200">
</details>

## Q13. Write a Query to find the Rider Monthly Earning.
<details><summary>
<strong>Description</strong>: Calculate each rider's total monthly earning, assuming earn 8% of the oder amount.</summary>
<br><strong>SQL Code</strong>

  ```sql

  SELECT
    customer_name,
    dishes,
    total_dishes
  FROM
    (SELECT
        c.customer_id,
        c.customer_name,
        o.order_item AS dishes,
        COUNT(order_id) AS total_dishes,
        DENSE_RANK() OVER (ORDER BY COUNT(order_id) DESC) AS RANK
      FROM
        orders o
        JOIN customers c ON o.customer_id = c.customer_id
      WHERE
        o.order_date >= CURRENT_DATE - INTERVAL '1 Year'
        AND c.customer_name = 'Akhil Reddy'
      GROUP BY
        1,
        2,
        3
      ORDER BY
        1,
        4 DESC
    ) AS t1
  WHERE
    RANK <= 5;
  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Returning Rider ID, Month, Total Revenue, Monthly revenue.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q13_output.png">
</details>

## Q14. Rider Rating Analysis.
<details><summary>
<strong>Description</strong>: --find the number of 5-star,Four-star, and 3-star ratings each rider has.
--riders receive this rating based on delivery time.
--if orders are delivered less than 15 minute of order recived time then rider '5star rating'
--if they deliver with in15 and 20 minutes they get 4 star rating
--if they deliver after 20 minute they get 3 star rating.</summary>
<br><strong>SQL Code</strong>

  ```sql

SELECT
	rider_id,
	rider_rating,
COUNT(rider_rating) AS total_ratings
FROM 
(WITH riders_rating as
(SELECT
	d.order_id,
	d.rider_id,
	o.order_time,
	d.delivery_time,
	ROUND(EXTRACT(EPOCH FROM(d.delivery_time - o.order_time + --However we can conver them into minutes by dividing
	CASE 
		WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day'--total diffrence time in seconds/60
		ELSE INTERVAL '0 day'END))/60,2) AS delivery_duration

FROM
	orders o
	JOIN deliveries d ON o.order_id = d.delivery_id
	WHERE d.delivery_status = 'Delivered' 

group by
	1,
	2,
	3,
	4
)
SELECT
	rider_id,
	delivery_duration,
	CASE
		WHEN delivery_duration < 15 THEN '5 Star'
		WHEN delivery_duration BETWEEN 15 AND 20  THEN '4 Star'
		ELSE '3 star'
	END AS rider_rating 
	FROM 
		riders_rating
	GROUP BY
	1,
	2)as t1
GROUP BY
	1,
	2
ORDER BY
	1,
	2
  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Grouping the results by Riders ID,Riders rating,Count of Ratings of each rider.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_14_output.png">
</details>

## Q15.  Order Frequency by Day.
<details><summary>
<strong>Description</strong>: Analyze Order frequency per day of the week and identify the peak day for each resturant </summary>
<br><strong>SQL Code</strong>

  ```sql
SELECT
	*
FROM( SELECT
			r.resturant_name,
			--o.order_date,
			TO_CHAR(o.order_date, 'Day'),
			COUNT(o.order_id) AS total_orders,
			RANK() OVER (PARTITION BY r.resturant_name ORDER BY COUNT(o.order_id) DESC) as rank
		FROM 
			orders o
			JOIN resturants r on o.resturant_id = r.resturant_id
		GROUP BY
		1,
		2
		ORDER BY
		1,
		3 DESC)
WHERE rank = 1

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Grouping the results by Riders ID,Riders rating,Count of Ratings of each rider.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_15_output.png">
</details>

## Q16.  Customer Life Time value
<details><summary>
<strong>Description</strong>: Calculate the total Revenue generated by the each customers on all the orders </summary>
<br><strong>SQL Code</strong>

  ```sql
SELECT
	o.customer_id,
	c.customer_name,
	count(o.order_item) as total_items,
	sum(o.total_amount) as CLV
FROM
	orders o
	JOIN deliveries d ON o.order_id = d.order_id
	JOIN customers c ON o.customer_id = c.customer_id
	where 	d.delivery_status = 'Delivered'
GROUP BY
	1,
	2
ORDER BY
	3 DESC;


  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Grouping the results by Customer ID,Customer Name,Count of orders, CLV.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_16_output.png">
</details>

## Q17. Monthly Sales trend
<details><summary>
<strong>Description</strong>: Identify sales trends by comparing each months total sales to the previous month. </summary>
<br><strong>SQL Code</strong>

  ```sql
SELECT 
	EXTRACT(YEAR FROM order_date) as year,
	EXTRACT(month FROM order_date) as month,
	sum(total_amount) as current_month_total_amount,
	LAG(SUM(total_amount),1) OVER (ORDER BY EXTRACT(YEAR FROM order_date),EXTRACT(MONTH FROM order_date))
	as previous_month_total_amount
FROM orders
group by
	1,
	2

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Grouping the results by YEAR,MONTH,Sales of current month and previous month.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_17_output.png">
</details>

## Q18. Rider Efficieny
<details><summary>
<strong>Description</strong>: Determine the rider efficieny by determing average delivery times and identifying those have highest and lowest averages. </summary>
<br><strong>SQL Code</strong>

  ```sql
WITH rider_efficiency AS
	(SELECT *,
		d.rider_id as riders_id,
		ROUND(EXTRACT(EPOCH FROM(d.delivery_time - o.order_time + --However we can conver them into minutes by dividing
		CASE 
			WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day'--total diffrence time in seconds/60
			ELSE INTERVAL '0 day'END))/60,2) AS time_duration
		
	FROM 
		orders o
		JOIN deliveries d ON o.order_id = d.order_id
	WHERE d.delivery_status = 'Delivered'
),
riders_time
as
	(SELECT 
	  		riders_id,
			round(avg(time_duration),2) avg_time
	FROM
		rider_efficiency
	GROUP BY 1
)
SELECT
	MIN(avg_time) as rider_minimum_average_time,
	MAX(avg_time) as rider_maximum_average_time
FROM
	riders_time;
	2

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Returning minimum and maximum average time.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_18_output.png">
</details>

## Q19. Order Item Popularity
<details><summary>
<strong>Description</strong>: Track the popularity of specific order items over a time and identify seasonal demand spikes. </summary>
<br><strong>SQL Code</strong>

  ```sql
WITH order_item_popularity AS
	(SELECT *,
			extract(month from order_date) as month,
			case
				WHEN extract(month from order_date) BETWEEN 4 and 6 then 'Spring'
				when extract(month from order_date) >6 and extract(month from order_date) <9 THEN 'Summer'
				ELSE 'Winter'
			End as seasons
	from orders
)
SELECT 
	order_item,
	seasons,
	count(order_id) as total_orders
FROM
	order_item_popularity
GROUP BY
	1,
	2
ORDER BY
	1,
	2 DESC;

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Grouping the results by Order items,Seasons,total orders.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_19_output.png">
</details>

## Q20. Rank each city based on the total revenue for the previous year 2023
<details><summary>
<strong>Description</strong>: Ranking each city based on the total revenue for the previous year 2023. </summary>
<br><strong>SQL Code</strong>

  ```sql
SELECT
	r.city,
	SUM(total_amount) AS revenue,
	RANK() OVER (ORDER BY SUM(total_amount) DESC) AS RANK
FROM
	orders o
JOIN resturants r ON o.resturant_id = r.resturant_id
GROUP BY
	1	

  ```
</details>
<details>
<summary><strong>Expected Output</strong>: Grouping the results by City, Revenue, Rank.</summary>
<br><strong>Query Output</strong>
 <br> <img src="https://github.com/prashanthkumarjoshi/SQL_PROJECT_3/blob/main/images/Q_20_output.png">
</details>


## Project Focus
This project emphasizes:
- **Complex Joins and Aggregations**: Advanced SQL joins and aggregations.
- **Window Functions**: Utilizing functions for running totals, growth analysis, and time-based queries.
- **Data Segmentation**: Time-based analysis for product performance.
- **Correlation Analysis**: Identifying relationships between variables like product price and warranty claims.
- **Real-World Problem Solving**: Addressing business challenges with SQL.
