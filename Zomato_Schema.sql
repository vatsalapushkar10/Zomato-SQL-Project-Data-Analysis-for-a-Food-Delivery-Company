-------ZOMATO DATA ANALYSIS using SQL----

DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS customers;

DROP TABLE IF EXISTS resturants;

DROP TABLE IF EXISTS riders;

DROP TABLE IF EXISTS deliveries;



--Creating table for customers--
CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(55),
	reg_date DATE
);


--Creating table for restunrats--
CREATE TABLE resturants (
	resturant_id INT PRIMARY KEY,
	resturant_name VARCHAR(55),
	city VARCHAR(55),
	opening_hours VARCHAR(55) ---
);

--Creating table for Orders--
CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	customer_id INT, ---this is comming from customer table
	resturant_id INT, --this is comming from resturants
	order_item VARCHAR(55),
	order_date date,
	order_time TIME,
	order_status VARCHAR(55),
	total_amount FLOAT
);

	ALTER TABLE orders
	ADD constraint fk_customers 
	FOREIGN key (customer_id) 
	REFERENCES customers (customer_id);
	
	ALTER TABLE orders
	ADD constraint fk_resturants 
	FOREIGN key (resturant_id) 
	REFERENCES resturants (resturant_id);
--Creting table for riders--
CREATE TABLE riders (
	rider_id INT PRIMARY KEY,
	rider_name VARCHAR(55),
	sign_up DATE
);

--Creating table for Deliveries--
CREATE TABLE deliveries (
	delivery_id INT PRIMARY KEY,
	order_id INT, -- this is comming from order table
	deilvery_status VARCHAR(55),
	deilivery TIME,
	rider_id INT -- this is comming from the riders table
);

	ALTER TABLE deliveries
	ADD CONSTRAINT fk_orders 
	FOREIGN key (order_id) 
	REFERENCES orders (order_id);

	ALTER TABLE deliveries
	ADD CONSTRAINT fk_riders 
	FOREIGN key (rider_id) 
	REFERENCES riders(rider_id);


---EMD 0f Schema--


