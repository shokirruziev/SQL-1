Easy-Level Tasks

1. Kategoriyaga qarab nechta mahsulot borligini topish:

SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;


2. Electronics kategoriyasidagi mahsulotlarning o‘rtacha narxi:

SELECT AVG(Price) AS AvgPrice
FROM Products
WHERE Category = 'Electronics';


3. Shahri L harfi bilan boshlanadigan mijozlar:

SELECT *
FROM Customers
WHERE City LIKE 'L%';


4. Nomi er bilan tugaydigan mahsulotlar:

SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';


5. Davlati A bilan tugaydigan mijozlar:

SELECT *
FROM Customers
WHERE Country LIKE '%A';


6. Eng qimmat mahsulot narxi:

SELECT MAX(Price) AS HighestPrice
FROM Products;


7. Zaxira miqdoriga qarab status chiqarish:

SELECT ProductName,
       CASE WHEN StockQuantity < 30 THEN 'Low Stock'
            ELSE 'Sufficient' END AS StockStatus
FROM Products;


8. Har bir davlatdagi mijozlar soni:

SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;


9. Buyurtmalarda minimal va maksimal miqdor:

SELECT MIN(Quantity) AS MinQuantity, MAX(Quantity) AS MaxQuantity
FROM Orders;

✅ Medium-Level Tasks

10. 2023 yil yanvar oyida buyurtma bergan, lekin faktura olinmagan mijozlar:

SELECT DISTINCT o.CustomerID
FROM Orders o
WHERE YEAR(o.OrderDate) = 2023 AND MONTH(o.OrderDate) = 1
AND o.CustomerID NOT IN (
    SELECT CustomerID FROM Invoices
    WHERE YEAR(InvoiceDate) = 2023 AND MONTH(InvoiceDate) = 1
);


11. Ikki jadvaldagi productlarni birlashtirish (duplikatlar bilan):

SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;


12. Ikki jadvaldagi productlarni birlashtirish (duplikatlarni olib tashlash):

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;


13. Har yil bo‘yicha buyurtma summasining o‘rtacha qiymati:

SELECT YEAR(OrderDate) AS OrderYear, AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate);


14. Narx oralig‘iga ko‘ra guruhlash:

SELECT ProductName,
       CASE
            WHEN Price < 100 THEN 'Low'
            WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
            ELSE 'High'
       END AS PriceGroup
FROM Products;


15. Pivot qilib Population_Each_Year jadvalini yaratish:

SELECT district_name, [2012], [2013]
INTO Population_Each_Year
FROM
(SELECT district_name, population, year FROM city_population) AS src
PIVOT (
    SUM(population) FOR year IN ([2012], [2013])
) AS p;


16. Har bir mahsulot bo‘yicha umumiy savdo summasi:

SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;


17. Nomi ichida oo bor productlar:

SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';


18. Pivot qilib Population_Each_City jadvalini yaratish:

SELECT year, [Bektemir], [Chilonzor], [Yakkasaroy]
INTO Population_Each_City
FROM
(SELECT district_name, population, year FROM city_population) AS src
PIVOT (
    SUM(population) FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS p;

✅ Hard-Level Tasks

19. Eng ko‘p faktura summasiga ega top-3 mijoz:

SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;


20. Population_Each_Year jadvalini qayta normal formatga o‘tkazish (UNPIVOT):

SELECT district_name,
       year,
       population
FROM Population_Each_Year
UNPIVOT (
    population FOR year IN ([2012], [2013])
) AS unpvt;


21. Mahsulot nomi va sotilgan soni (JOIN bilan):

SELECT p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName;


22. Population_Each_City jadvalini qayta normal formatga o‘tkazish (UNPIVOT):

SELECT year, City, Population
FROM Population_Each_City
UNPIVOT (
    Population FOR City IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS unpvt;
