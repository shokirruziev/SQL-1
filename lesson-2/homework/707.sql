Basic-Level Tasks (10)

1. Create a table Employees

CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);


2. Insert three records using different INSERT INTO approaches

-- Single-row insert
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Alice Johnson', 6000.00);

-- Another single-row insert
INSERT INTO Employees VALUES (2, 'Bob Smith', 5000.00);

-- Multi-row insert
INSERT INTO Employees (EmpID, Name, Salary)
VALUES
    (3, 'Charlie Brown', 5500.00),
    (4, 'Dana White', 4800.00);


3. Update the salary of EmpID = 1 to 7000

UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;


4. Delete the record where EmpID = 2

DELETE FROM Employees
WHERE EmpID = 2;


5. Difference between DELETE, TRUNCATE, and DROP

-- DELETE: Removes specific rows. Can use WHERE. Can be rolled back.
-- TRUNCATE: Removes all rows. Faster. Cannot use WHERE. Cannot be rolled back (in most cases).
-- DROP: Deletes entire table and its structure from the database.


6. Modify Name column to VARCHAR(100)

ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);


7. Add new column Department (VARCHAR(50))

ALTER TABLE Employees
ADD Department VARCHAR(50);


8. Change data type of Salary to FLOAT

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;


9. Create another table Departments

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);


10. Remove all records from Employees table without deleting structure

TRUNCATE TABLE Employees;


🔸 Intermediate-Level Tasks (6)

1. Insert 5 records into Departments using INSERT INTO SELECT

INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR'
UNION ALL
SELECT 2, 'Finance'
UNION ALL
SELECT 3, 'IT'
UNION ALL
SELECT 4, 'Marketing'
UNION ALL
SELECT 5, 'Operations';


2. Update Department to 'Management' where Salary > 5000

UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;


3. Query to remove all employees but keep table structure

TRUNCATE TABLE Employees;


4. Drop the Department column from Employees

ALTER TABLE Employees
DROP COLUMN Department;


5. Rename Employees table to StaffMembers

EXEC sp_rename 'Employees', 'StaffMembers';


6. Remove the Departments table completely

DROP TABLE Departments;


🔺 Advanced-Level Tasks (9)

1. Create Products table with at least 5 columns

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    SupplierName VARCHAR(100)
);


2. Add CHECK constraint for Price > 0

ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);


3. Add StockQuantity column with default 50

ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;


4. Rename Category to ProductCategory

EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';


5. Insert 5 records

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, SupplierName)
VALUES
(1, 'Laptop', 'Electronics', 1200.00, 'TechCorp'),
(2, 'Phone', 'Electronics', 800.00, 'MobileHub'),
(3, 'Desk', 'Furniture', 300.00, 'FurniStore'),
(4, 'Chair', 'Furniture', 150.00, 'FurniStore'),
(5, 'Printer', 'Electronics', 200.00, 'PrintWorld');


6. Create backup using SELECT INTO

SELECT *
INTO Products_Backup
FROM Products;


7. Rename Products table to Inventory

EXEC sp_rename 'Products', 'Inventory';


8. Change Price datatype from DECIMAL to FLOAT

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;


9. Add IDENTITY column ProductCode starting from 1000 and increment by 5


SQL Server does not support adding an IDENTITY column to an existing table directly. So you need to:





Create a new table with the identity column




Copy data




Drop old table and rename




-- Step 1: Create new table with identity
CREATE TABLE Inventory_New (
    ProductCode INT IDENTITY(1000,5) PRIMARY KEY,
    ProductID INT,
    ProductName VARCHAR(100),
    ProductCategory VARCHAR(50),
    Price FLOAT,
    SupplierName VARCHAR(100),
    StockQuantity INT
);

-- Step 2: Copy data
INSERT INTO Inventory_New (ProductID, ProductName, ProductCategory, Price, SupplierName, StockQuantity)
SELECT ProductID, ProductName, ProductCategory, Price, SupplierName, StockQuantity
FROM Inventory;

-- Step 3: Drop old table
DROP TABLE Inventory;

-- Step 4: Rename new table
EXEC sp_rename 'Inventory_New', 'Inventory';
