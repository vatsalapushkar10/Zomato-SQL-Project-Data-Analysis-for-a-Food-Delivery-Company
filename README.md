
# Zomato SQL Project: Data Analysis for a Food Delivery Company
Welcome to the GitHub repository for the Zomato SQL Project. This project demonstrates my SQL problem-solving capabilities through an in-depth analysis of Zomato, a leading food delivery service in India. Within this repository, you will find a comprehensive breakdown of the project structure, meticulously crafted SQL queries, and the key insights derived from the data analysis.
<br> <img src="https://github.com/vatsalapushkar10/Zomato-SQL-Project-Data-Analysis-for-a-Food-Delivery-Company/blob/main/zomato_Review-1.jpg">

## Project Overview
This project showcases my proficiency in addressing intricate SQL challenges within a business context. The primary objective was to analyze Zomato's customer and order data to uncover valuable insights, resolve business issues, and provide actionable recommendations. The database encompasses detailed information about customers, restaurants, orders, and deliveries.

## Entity-Relationship Diagram (ERD)
The dataset comprises five tables: `Customers`, `Resturants`, `riders`, `Orders`, and `Delivery`. Below is the structure of the ERD that represents the relationships among these tables.
<img width="646" alt="image" src="https://github.com/vatsalapushkar10/Zomato-SQL-Project-Data-Analysis-for-a-Food-Delivery-Company/blob/main/ERD.png">




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

## Project Focus
This project emphasizes:
- **Complex Joins and Aggregations**: Advanced SQL joins and aggregations.
- **Window Functions**: Utilizing functions for running totals, growth analysis, and time-based queries.
- **Data Segmentation**: Time-based analysis for product performance.
- **Correlation Analysis**: Identifying relationships between variables like product price and warranty claims.
- **Real-World Problem Solving**: Addressing business challenges with SQL.
