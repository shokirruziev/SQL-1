🧩 1. Distributors and their sales by region (0 qiymatlar bilan)
-- 1. All distributors and regions with zero sales where missing
SELECT r.Region,
       d.Distributor,
       ISNULL(s.Sales, 0) AS Sales
FROM (SELECT DISTINCT Region FROM #RegionSales) r
CROSS JOIN (SELECT DISTINCT Distributor FROM #RegionSales) d
LEFT JOIN #RegionSales s
  ON r.Region = s.Region AND d.Distributor = s.Distributor
ORDER BY r.Region, d.Distributor;

🧩 2. Managers with at least five direct reports
SELECT e1.name
FROM Employee e1
JOIN Employee e2 ON e1.id = e2.managerId
GROUP BY e1.id, e1.name
HAVING COUNT(e2.id) >= 5;

🧩 3. Products with at least 100 units ordered in February 2020
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE YEAR(o.order_date) = 2020 AND MONTH(o.order_date) = 2
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

🧩 4. Vendor with most orders per customer
SELECT CustomerID, Vendor
FROM (
    SELECT CustomerID, Vendor,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY COUNT(*) DESC) AS rn
    FROM Orders
    GROUP BY CustomerID, Vendor
) t
WHERE rn = 1;

🧩 5. Check if a number is prime
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2, @isPrime BIT = 1;

WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;
        BREAK;
    END
    SET @i = @i + 1;
END

IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

🧩 6. Device locations and most frequent signal
SELECT 
    Device_id,
    COUNT(DISTINCT Locations) AS no_of_location,
    (
        SELECT TOP 1 Locations
        FROM Device d2
        WHERE d2.Device_id = d1.Device_id
        GROUP BY Locations
        ORDER BY COUNT(*) DESC
    ) AS max_signal_location,
    COUNT(*) AS no_of_signals
FROM Device d1
GROUP BY Device_id;

🧩 7. Employees earning more than average in department
SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
JOIN (
    SELECT DeptID, AVG(Salary) AS avg_sal
    FROM Employee
    GROUP BY DeptID
) a ON e.DeptID = a.DeptID
WHERE e.Salary > a.avg_sal;

🧩 8. Lottery winnings calculation
SELECT SUM(Reward) AS Total_Winnings
FROM (
    SELECT 
        t.TicketID,
        COUNT(DISTINCT t.Number) AS TotalNums,
        COUNT(DISTINCT n.Number) AS MatchCount,
        CASE 
            WHEN COUNT(DISTINCT n.Number) = (SELECT COUNT(*) FROM Numbers) THEN 100
            WHEN COUNT(DISTINCT n.Number) > 0 THEN 10
            ELSE 0
        END AS Reward
    FROM Tickets t
    LEFT JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
) x;


✅ Expected Output: 110

🧩 9. Spending by platform type
SELECT 
    ROW_NUMBER() OVER (ORDER BY Spend_date, Platform) AS Row,
    Spend_date,
    Platform,
    SUM(Amount) AS Total_Amount,
    COUNT(DISTINCT User_id) AS Total_users
FROM (
    SELECT Spend_date, User_id, 'Mobile' AS Platform, SUM(Amount) AS Amount
    FROM Spending WHERE Platform = 'Mobile'
    GROUP BY Spend_date, User_id
    UNION ALL
    SELECT Spend_date, User_id, 'Desktop', SUM(Amount)
    FROM Spending WHERE Platform = 'Desktop'
    GROUP BY Spend_date, User_id
    UNION ALL
    SELECT Spend_date, User_id, 'Both', SUM(Amount)
    FROM Spending
    GROUP BY Spend_date, User_id
) x
GROUP BY Spend_date, Platform
ORDER BY Spend_date, Platform;

🧩 10. De-grouping (expand rows by quantity)
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN master..spt_values v
  ON v.type = 'P' AND v.number < g.Quantity
ORDER BY g.Product;
