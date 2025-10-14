EASY TASKS
1️⃣ "100–Steven King" (emp_id + first_name + last_name)
SELECT CONCAT(EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME) AS FullNameFormat
FROM Employees
WHERE EMPLOYEE_ID = 100;

2️⃣ Phone_number ichidagi '124'ni '999'ga almashtirish
UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999');

3️⃣ Ismi 'A', 'J', yoki 'M' harflaridan boshlanuvchi xodimlar
SELECT
    FIRST_NAME AS FirstName,
    LEN(FIRST_NAME) AS NameLength
FROM Employees
WHERE FIRST_NAME LIKE 'A%'
   OR FIRST_NAME LIKE 'J%'
   OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME;

4️⃣ Har bir manager uchun umumiy ish haqi
SELECT
    MANAGER_ID,
    SUM(SALARY) AS TotalSalary
FROM Employees
GROUP BY MANAGER_ID;

5️⃣ TestMax jadvalidan har yil uchun eng katta qiymatni topish
SELECT
    Year1,
    GREATEST(Max1, Max2, Max3) AS HighestValue
FROM TestMax;


(Agar SQL Server 2019 dan oldin bo‘lsa, GREATEST ishlamasa — quyidagicha yoziladi):

SELECT
    Year1,
    (SELECT MAX(v)
     FROM (VALUES (Max1), (Max2), (Max3)) AS value(v)) AS HighestValue
FROM TestMax;

6️⃣ Notoqimay (odd) raqamli filmlar, va tasviri “boring” bo‘lmaganlar
SELECT *
FROM cinema
WHERE id % 2 = 1
  AND description <> 'boring';

7️⃣ Id bo‘yicha tartiblash, lekin Id = 0 oxirda chiqsin
SELECT *
FROM SingleOrder
ORDER BY
    CASE WHEN Id = 0 THEN 1 ELSE 0 END,
    Id;

8️⃣ Birinchi NULL bo‘lmagan qiymatni olish
SELECT
    id,
    COALESCE(ssn, passportid, itin) AS FirstNonNullValue
FROM person;

🟡 MEDIUM TASKS
9️⃣ FullName ni 3 qismga ajratish (Students)
SELECT
    StudentID,
    PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS MiddleName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
FROM Students;

🔟 Kaliforniyaga yetkazilgan buyurtmalari bor mijozlarning Texasdagi buyurtmalari
SELECT *
FROM Orders
WHERE DeliveryState = 'TX'
  AND CustomerID IN (
        SELECT DISTINCT CustomerID
        FROM Orders
        WHERE DeliveryState = 'CA'
    );

11️⃣ DMLTable dagi satrlarni bitta qatorga birlashtirish
SELECT STRING_AGG(String, ' ') WITHIN GROUP (ORDER BY SequenceNumber) AS FullQuery
FROM DMLTable;

12️⃣ Ism va familiyasida kamida 3 marta “a” harfi qatnashgan xodimlar
SELECT *
FROM Employees
WHERE (LEN(LOWER(FIRST_NAME) + LOWER(LAST_NAME))
     - LEN(REPLACE(LOWER(FIRST_NAME) + LOWER(LAST_NAME), 'a', ''))) >= 3;

13️⃣ Har bir bo‘limdagi xodimlar soni va 3 yildan ortiq ishlaganlar ulushi
SELECT
    DEPARTMENT_ID,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) AS Over3Years,
    CAST(SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) * 100.0 /
         COUNT(*) AS DECIMAL(5,2)) AS PercentageOver3Years
FROM Employees
GROUP BY DEPARTMENT_ID;

🔴 DIFFICULT TASKS
14️⃣ Har bir o‘quvchi uchun o‘z qiymati + oldingi satrlarning yig‘indisi
SELECT
    StudentID,
    FullName,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Students;

15️⃣ Tug‘ilgan kuni bir xil bo‘lgan talabalarni topish
SELECT s1.StudentName, s1.Birthday
FROM Student s1
JOIN (
    SELECT Birthday
    FROM Student
    GROUP BY Birthday
    HAVING COUNT(*) > 1
) s2 ON s1.Birthday = s2.Birthday
ORDER BY s1.Birthday;

16️⃣ Har bir noyob o‘yinchi juftligi uchun umumiy ball
SELECT
    LEAST(PlayerA, PlayerB) AS Player1,
    GREATEST(PlayerA, PlayerB) AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY LEAST(PlayerA, PlayerB), GREATEST(PlayerA, PlayerB);


(Agar SQL Server 2019 dan avval bo‘lsa — LEAST/GREATEST yo‘q — quyidagicha yoziladi):

SELECT
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;

17️⃣ Belgilarni toifalarga ajratish (‘tf56sd#%OqH’)
DECLARE @txt VARCHAR(50) = 'tf56sd#%OqH';

SELECT
    @txt AS OriginalString,
    (SELECT STRING_AGG(SUBSTRING(@txt, number, 1), '')
     FROM master.dbo.spt_values
     WHERE type = 'P' AND number BETWEEN 1 AND LEN(@txt)
           AND SUBSTRING(@txt, number, 1) LIKE '[A-Z]') AS UppercaseLetters,
    (SELECT STRING_AGG(SUBSTRING(@txt, number, 1), '')
     FROM master.dbo.spt_values
     WHERE type = 'P' AND number BETWEEN 1 AND LEN(@txt)
           AND SUBSTRING(@txt, number, 1) LIKE '[a-z]') AS LowercaseLetters,
    (SELECT STRING_AGG(SUBSTRING(@txt, number, 1), '')
     FROM master.dbo.spt_values
     WHERE type = 'P' AND number BETWEEN 1 AND LEN(@txt)
           AND SUBSTRING(@txt, number, 1) LIKE '[0-9]') AS Numbers,
    (SELECT STRING_AGG(SUBSTRING(@txt, number, 1), '')
     FROM master.dbo.spt_values
     WHERE type = 'P' AND number BETWEEN 1 AND LEN(@txt)
           AND SUBSTRING(@txt, number, 1) NOT LIKE '[A-Za-z0-9]') AS SpecialCharacters;
