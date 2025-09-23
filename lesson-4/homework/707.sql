🟢 Easy-Level Tasks (10)
-- 1. Select the top 5 employees
SELECT TOP 5 * 
FROM Employees;

-- 2. Select unique Category values from Products
SELECT DISTINCT Category 
FROM Products;

-- 3. Products with Price > 100
SELECT * 
FROM Products
WHERE Price > 100;

-- 4. Customers whose FirstName starts with 'A'
SELECT * 
FROM Customers
WHERE FirstName LIKE 'A%';

-- 5. Order Products by Price ascending
SELECT * 
FROM Products
ORDER BY Price ASC;

-- 6. Employees with Salary >= 60000 and DepartmentName = 'HR'
SELECT * 
FROM Employees
WHERE Salary >= 60000 AND DepartmentName = 'HR';

-- 7. Replace NULL Email with default text
SELECT EmployeeID, FirstName, LastName, 
       ISNULL(Email, 'noemail@example.com') AS Email
FROM Employees;

-- 8. Products with Price between 50 and 100
SELECT * 
FROM Products
WHERE Price BETWEEN 50 AND 100;

-- 9. DISTINCT on two columns
SELECT DISTINCT Category, ProductName
FROM Products;

-- 10. DISTINCT on two columns + order by ProductName desc
SELECT DISTINCT Category, ProductName
FROM Products
ORDER BY ProductName DESC;

🟠 Medium-Level Tasks (10)
-- 1. Top 10 products ordered by Price DESC
SELECT TOP 10 * 
FROM Products
ORDER BY Price DESC;

-- 2. COALESCE FirstName or LastName
SELECT EmployeeID, COALESCE(FirstName, LastName) AS NameValue
FROM Employees;

-- 3. Distinct Category and Price
SELECT DISTINCT Category, Price
FROM Products;

-- 4. Employees Age between 30 and 40 OR Marketing dept
SELECT * 
FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR DepartmentName = 'Marketing';

-- 5. OFFSET-FETCH rows 11 to 20, ordered by Salary DESC
SELECT * 
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- 6. Products with Price <= 1000 and StockQuantity > 50
SELECT * 
FROM Products
WHERE Price <= 1000 AND StockQuantity > 50
ORDER BY StockQuantity ASC;

-- 7. Products containing 'e'
SELECT * 
FROM Products
WHERE ProductName LIKE '%e%';

-- 8. Employees in HR, IT, Finance
SELECT * 
FROM Employees
WHERE DepartmentName IN ('HR', 'IT', 'Finance');

-- 9. Customers ordered by City ASC, PostalCode DESC
SELECT * 
FROM Customers
ORDER BY City ASC, PostalCode DESC;

🔴 Hard-Level Tasks (8)
-- 1. Top 5 products with highest sales
SELECT TOP 5 p.ProductID, p.ProductName, SUM(s.SaleAmount) AS TotalSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSales DESC;

-- 2. Combine FirstName + LastName as FullName
SELECT EmployeeID, 
       (ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'')) AS FullName,
       DepartmentName, Salary
FROM Employees;

-- 3. DISTINCT Category, ProductName, Price for Price > 50
SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;

-- 4. Products with Price < 10% of avg price
SELECT * 
FROM Products
WHERE Price < (SELECT AVG(Price) * 0.1 FROM Products);

-- 5. Employees Age < 30 AND Dept HR or IT
SELECT * 
FROM Employees
WHERE Age < 30 AND DepartmentName IN ('HR', 'IT');

-- 6. Customers with Gmail domain
SELECT * 
FROM Customers
WHERE Email LIKE '%@gmail.com%';

-- 7. Employees with Salary > ALL employees in Sales dept
SELECT * 
FROM Employees
WHERE Salary > ALL (
    SELECT Salary 
    FROM Employees 
    WHERE DepartmentName = 'Sales'
);

-- 8. Orders placed in last 180 days
SELECT * 
FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();
