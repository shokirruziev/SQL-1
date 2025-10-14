-- 1. Numbers table from 1 to 1000
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < 1000
)
SELECT n FROM Numbers
OPTION (MAXRECURSION 1000);

-- 2. Total sales per employee (Derived Table)
SELECT e.FirstName, e.LastName, s.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID;

-- 3. CTE: Average salary of employees
WITH AvgSalary AS (
    SELECT AVG(Salary) AS AvgSal FROM Employees
)
SELECT AvgSal FROM AvgSalary;

-- 4. Highest sales for each product (Derived Table)
SELECT p.ProductName, t.MaxSale
FROM Products p
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS MaxSale
    FROM Sales
    GROUP BY ProductID
) t ON p.ProductID = t.ProductID;

-- 5. Doubling number until < 1,000,000
WITH Doubles AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n * 2
    FROM Doubles
    WHERE n * 2 < 1000000
)
SELECT n FROM Doubles
OPTION (MAXRECURSION 1000);

-- 6. Employees with more than 5 sales
WITH SalesCount AS (
    SELECT EmployeeID, COUNT(*) AS SaleCount
    FROM Sales
    GROUP BY EmployeeID
    HAVING COUNT(*) > 5
)
SELECT e.FirstName, e.LastName
FROM Employees e
JOIN SalesCount s ON e.EmployeeID = s.EmployeeID;

-- 7. Products with sales > $500
WITH ProductSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT p.ProductName, ps.TotalSales
FROM Products p
JOIN ProductSales ps ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500;

-- 8. Employees with salaries above average
WITH AvgSal AS (
    SELECT AVG(Salary) AS avg_salary FROM Employees
)
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > (SELECT avg_salary FROM AvgSal);

-- Medium 1. Top 5 employees by number of orders
SELECT TOP 5 e.FirstName, e.LastName, t.OrderCount
FROM Employees e
JOIN (
    SELECT EmployeeID, COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) t ON e.EmployeeID = t.EmployeeID
ORDER BY t.OrderCount DESC;

-- Medium 2. Sales per product category
SELECT p.CategoryID, SUM(s.SalesAmount) AS TotalSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.CategoryID;

-- Medium 3. Factorial of each number
WITH Factorial AS (
    SELECT Number, CAST(Number AS BIGINT) AS Fact, Number AS StartVal
    FROM Numbers1
    UNION ALL
    SELECT f.StartVal, f.Fact * n.Number, f.StartVal
    FROM Factorial f
    JOIN Numbers1 n ON n.Number < f.StartVal
)
SELECT StartVal AS Number, MAX(Fact) AS Factorial
FROM Factorial
GROUP BY StartVal
ORDER BY StartVal
OPTION (MAXRECURSION 1000);

-- Medium 4. Split string into characters
WITH SplitCTE AS (
    SELECT Id, LEFT(String,1) AS CharPart, RIGHT(String,LEN(String)-1) AS Remain
    FROM Example
    UNION ALL
    SELECT Id, LEFT(Remain,1), RIGHT(Remain,LEN(Remain)-1)
    FROM SplitCTE
    WHERE LEN(Remain) > 0
)
SELECT Id, CharPart FROM SplitCTE
WHERE CharPart <> ''
OPTION (MAXRECURSION 1000);

-- Medium 5. Sales difference between current and previous month
WITH MonthlySales AS (
    SELECT YEAR(SaleDate) AS Y, MONTH(SaleDate) AS M,
           SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
),
Diff AS (
    SELECT Y, M,
           TotalSales - LAG(TotalSales) OVER (ORDER BY Y, M) AS DiffFromPrev
    FROM MonthlySales
)
SELECT * FROM Diff;

-- Medium 6. Employees with sales over 45000 per quarter
SELECT e.FirstName, e.LastName, q.QuarterTotal
FROM Employees e
JOIN (
    SELECT EmployeeID, DATEPART(QUARTER, SaleDate) AS Qtr,
           SUM(SalesAmount) AS QuarterTotal
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
    HAVING SUM(SalesAmount) > 45000
) q ON e.EmployeeID = q.EmployeeID;

-- Difficult 1. Fibonacci numbers
WITH Fibonacci AS (
    SELECT 0 AS a, 1 AS b
    UNION ALL
    SELECT b, a + b
    FROM Fibonacci
    WHERE b < 10000
)
SELECT a AS FibonacciNumber FROM Fibonacci
OPTION (MAXRECURSION 1000);

-- Difficult 2. Find same-character strings
SELECT Vals
FROM FindSameCharacters
WHERE LEN(Vals) > 1
  AND LEN(LTRIM(REPLACE(Vals, LEFT(Vals,1), ''))) = 0;

-- Difficult 3. Sequence 1, 12, 123, 1234, ...
WITH Seq AS (
    SELECT 1 AS n, CAST('1' AS VARCHAR(50)) AS SeqVal
    UNION ALL
    SELECT n + 1, SeqVal + CAST(n + 1 AS VARCHAR(10))
    FROM Seq
    WHERE n < 5
)
SELECT SeqVal FROM Seq
OPTION (MAXRECURSION 1000);

-- Difficult 4. Employees with most sales in last 6 months
SELECT TOP 1 e.FirstName, e.LastName, SUM(s.SalesAmount) AS TotalSales
FROM Employees e
JOIN Sales s ON e.EmployeeID = s.EmployeeID
WHERE s.SaleDate >= DATEADD(MONTH, -6, GETDATE())
GROUP BY e.FirstName, e.LastName
ORDER BY TotalSales DESC;

-- Difficult 5. Remove duplicate integers from string
SELECT PawanName,
       Pawan_slug_name,
       REPLACE(Pawan_slug_name,
               REPLICATE(RIGHT(Pawan_slug_name,1), LEN(RIGHT(Pawan_slug_name,1))),
               RIGHT(Pawan_slug_name,1)) AS CleanedName
FROM RemoveDuplicateIntsFromNames;
