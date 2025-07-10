-- 1. Create the Library database
CREATE DATABASE [Library];
GO

USE [Library];
GO

-- Create the Books table with required columns
CREATE TABLE [Books](
    BookID INT PRIMARY KEY IDENTITY(1,1), 
    Title VARCHAR(100) NOT NULL,          
    Author VARCHAR(50) NOT NULL,          
    PublishedYear INT NOT NULL,           
    Price DECIMAL(10,2) NOT NULL                  
);
GO
----------------------------------------------------

-- 2. Insert 5 books into the Books table
INSERT INTO [Books] (Title, Author, PublishedYear, Price)
VALUES
    ('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 1997, 20),
    ('Azazeel', 'Youssef Ziedan', 2008, 13.50),
    ('Utopia', 'Ahmed Khaled Tawfik', 2008, 12),
    ('The Cairo Trilogy', 'Naguib Mahfouz', 1956, 25.30),
    ('1919', 'Ahmed Mourad', 2014, 14.2);
GO

-- . Select all records from the Books table to verify insertion
SELECT * FROM Books;
GO

-- 3. Perform Queries:
--     a. Update the price of the book with BookID = 4
UPDATE [Books]
SET Price = 17.00
WHERE BookID = 4;
GO

--     b. Delete the book with BookID = 2
DELETE FROM [Books]
WHERE BookID = 2;
GO

--     c. Select all books, sorted by PublishedYear
SELECT * FROM Books
ORDER BY PublishedYear;
GO

--     d. Select books that were published before the year 2000
SELECT * FROM Books
WHERE PublishedYear < 2000;
GO


