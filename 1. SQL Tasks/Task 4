CREATE DATABASE [e-commerce];
GO

USE [e-commerce];
GO

-- Create the Sales table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10, 2)
);
GO

-- Insert sample data into the Sales table
INSERT INTO Sales (sale_id, product_id, quantity_sold, sale_date, total_price) VALUES
(1, 101, 5, '2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);
GO

-- Create the Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);
GO

-- Insert sample data into the Products table
INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'PC', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Headphones', 'Electronics', 30.00),
(104, 'Keyboard', 'PC', 20.00),
(105, 'Mouse', 'PC', 15.00);
GO

-- 1. Retrieve all columns from the Sales table
SELECT * FROM Sales;
GO

-- 2. Retrieve the product_name and unit_price from the Products table
SELECT product_name, unit_price FROM Products;
GO

-- 3. Retrieve the sale_id and sale_date from the Sales table
SELECT sale_id, sale_date FROM Sales;
GO

-- 4. Filter the Sales table to show only sales with a total_price greater than $100
SELECT * FROM Sales
WHERE total_price > 100;
GO

-- 5. Filter the Products table to show only products in the 'Electronics' category
SELECT * FROM Products 
WHERE category = 'Electronics';
GO

-- 6. Retrieve the sale_id and total_price from the Sales table for sales made on January 3, 2024
SELECT sale_id, total_price FROM Sales
WHERE sale_date = '2024-01-03';
GO

-- 7. Retrieve the product_id and product_name from the Products table for products with a unit_price greater than $100
SELECT product_id, product_name FROM Products
WHERE unit_price > 100; 
GO

-- 8. Calculate the total revenue generated from all sales in the Sales table
SELECT SUM(total_price) AS total_revenue 
FROM Sales;
GO

-- 9. Retrieve the sale_id, product_id, and total_price from the Sales table for sales with a quantity_sold greater than 4
SELECT sale_id, product_id, total_price FROM Sales
WHERE quantity_sold > 4; 
GO

-- 10. Calculate the total revenue generated from sales of products in the 'Electronics' category
SELECT SUM(S.total_price) AS total_rev_electronics
FROM Sales S
JOIN Products P ON S.product_id = P.product_id
WHERE P.category = 'Electronics';
GO

-- 11. Calculate the total quantity_sold of products in the 'Electronics' category
SELECT SUM(S.quantity_sold) AS quantity_sold_electronics
FROM Sales S
JOIN Products P ON S.product_id = P.product_id
WHERE P.category = 'Electronics';
GO
