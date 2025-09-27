✅ Easy-Level Tasks

1. Alias ProductName as Name in Products table

SELECT ProductName AS Name
FROM Products;


2. Alias Customers table as Client

SELECT *
FROM Customers AS Client;


3. UNION Products + Products_Discounted ProductName

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;


4. INTERSECT Products and Products_Discounted

SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;


5. DISTINCT customer names + Country

SELECT DISTINCT FirstName + ' ' + LastName AS CustomerName, Country
FROM Customers;


6. CASE conditional column Price > 1000

SELECT ProductName,
       Price,
       CASE 
            WHEN Price > 1000 THEN 'High'
            ELSE 'Low'
       END AS PriceCategory
FROM Products;


7. IIF conditional column StockQuantity > 100

SELECT ProductName,
       StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS StockAvailable
FROM Products_Discounted;

✅ Medium-Level Tasks

1. UNION Products + Products_Discounted ProductName (same as Easy #3, just repeat):

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;


2. EXCEPT → Products - Products_Discounted

SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;


3. IIF → Expensive vs Affordable

SELECT ProductName,
       Price,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceLevel
FROM Products;


4. Employees: Age < 25 OR Salary > 60000
(assuming Employees table exists with Age, Salary)

SELECT *
FROM Employees
WHERE Age < 25 OR Salary > 60000;


5. Update salary (HR + EmployeeID = 5)

UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR' OR EmployeeID = 5;

✅ Hard-Level Tasks

1. CASE for SaleAmount Tier

SELECT SaleID,
       SaleAmount,
       CASE
            WHEN SaleAmount > 500 THEN 'Top Tier'
            WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
            ELSE 'Low Tier'
       END AS SaleTier
FROM Sales;


2. EXCEPT → Customers with Orders but no Sales

SELECT DISTINCT CustomerID
FROM Orders
EXCEPT
SELECT DISTINCT CustomerID
FROM Sales;


3. CASE Discount by Quantity

SELECT CustomerID,
       Quantity,
       CASE
            WHEN Quantity = 1 THEN '3%'
            WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
            ELSE '7%'
       END AS Discount
FROM Orders;
