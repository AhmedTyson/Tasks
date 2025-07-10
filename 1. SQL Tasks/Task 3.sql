CREATE DATABASE online_shop;
GO

USE online_shop;
GO

-- Create the salesman table
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    salesman_name VARCHAR(250),
    city VARCHAR(250),
    commission DECIMAL(3, 2)
);
GO

-- Create the customer table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(250),
    city VARCHAR(250),
    grade INT,
    salesman_id INT
);
GO

-- Create the orders table
CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);
GO

-- Insert data into the salesman table 
INSERT INTO salesman (salesman_id, salesman_name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);
GO

-- Insert data into the customer table
INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
(3001, 'Brad Guzan', 'London', 200, 5005);
GO

-- Insert data into the orders table
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.40, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007);
GO

-- TASK3
-- 1. Find salesperson and customer who reside in the same city.
-- Returns Salesman name, customer name, and their shared city.
SELECT
    s.salesman_name AS Salesman,
    c.cust_name,
    c.city
FROM
    salesman s
JOIN
    customer c ON s.city = c.city;
GO

-- 2. Find orders with a purchase amount between 500 and 2000.
-- Returns order number, purchase amount, customer name, and customer city.
SELECT
    o.ord_no,
    o.purch_amt,
    c.cust_name,
    c.city
FROM
    orders o
JOIN
    customer c ON o.customer_id = c.customer_id
WHERE
    o.purch_amt BETWEEN 500 AND 2000;
GO
