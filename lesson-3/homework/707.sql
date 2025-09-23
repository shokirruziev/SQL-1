🟢 Easy-Level Tasks (10)
-- 1. Define and explain the purpose of BULK INSERT in SQL Server
-- BULK INSERT is used to quickly import large amounts of data 
-- from a file (text, CSV, etc.) into a SQL Server table.

-- 2. List four file formats that can be imported into SQL Server:
-- TXT, CSV, XLS/XLSX (Excel), XML, JSON.

-- 3. Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

-- 4. Insert three records into Products
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (1, 'Laptop', 1500.00),
       (2, 'Mouse', 20.50),
       (3, 'Keyboard', 45.00);

-- 5. Difference between NULL and NOT NULL
-- NULL means no value (missing/unknown).
-- NOT NULL means the column must always have a value.

-- 6. Add UNIQUE constraint to ProductName
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

-- 7. Write a comment in SQL query
-- This query selects all data from Products table
SELECT * FROM Products;

-- 8. Add CategoryID column to Products
ALTER TABLE Products
ADD CategoryID INT;

-- 9. Create Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

-- 10. Purpose of IDENTITY column
-- IDENTITY automatically generates sequential numeric values 
-- for a column (e.g., auto-increment for primary key).

🟠 Medium-Level Tasks (10)
-- 1. BULK INSERT example
BULK INSERT Products
FROM 'C:\data\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

-- 2. Create FOREIGN KEY in Products
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

-- 3. Difference between PRIMARY KEY and UNIQUE KEY
-- PRIMARY KEY: uniquely identifies each row, only one allowed per table, NOT NULL enforced.
-- UNIQUE KEY: ensures uniqueness of values, multiple allowed, allows one NULL.

-- 4. Add CHECK constraint (Price > 0)
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

-- 5. Add Stock column (NOT NULL)
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

-- 6. Replace NULL values in Price with 0
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

-- 7. Purpose of FOREIGN KEY
-- FOREIGN KEY links two tables, enforcing referential integrity (ensures data consistency).

🔴 Hard-Level Tasks (10)
-- 1. Create Customers table with CHECK constraint
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT CHECK (Age >= 18)
);

-- 2. Create table with IDENTITY (start at 100, increment by 10)
CREATE TABLE Orders (
    OrderID INT IDENTITY(100, 10) PRIMARY KEY,
    OrderDate DATE
);

-- 3. Composite PRIMARY KEY in OrderDetails
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

-- 4. Explain COALESCE and ISNULL
-- ISNULL(expression, value) → replaces NULL with specified value.
-- COALESCE(expr1, expr2, ...) → returns first non-NULL value from list.

-- 5. Employees table with PRIMARY KEY and UNIQUE KEY
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- 6. FOREIGN KEY with ON DELETE CASCADE, ON UPDATE CASCADE
CREATE TABLE OrdersCascade (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
