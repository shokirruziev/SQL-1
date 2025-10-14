EASY TASKS
1️⃣ Split Name by comma (TestMultipleColumns)
SELECT
    Id,
    LEFT(Name, CHARINDEX(',', Name) - 1) AS FirstName,
    LTRIM(RIGHT(Name, LEN(Name) - CHARINDEX(',', Name))) AS LastName
FROM TestMultipleColumns;

2️⃣ Strings containing ‘%’ (TestPercent)
SELECT *
FROM TestPercent
WHERE Strs LIKE '%[%]%';

3️⃣ Split string by dot (Splitter)
SELECT
    Id,
    LEFT(Vals, CHARINDEX('.', Vals) - 1) AS Part1,
    RIGHT(Vals, LEN(Vals) - CHARINDEX('.', Vals)) AS Part2
FROM Splitter;

4️⃣ Rows where Vals has more than 2 dots (testDots)
SELECT *
FROM testDots
WHERE (LEN(Vals) - LEN(REPLACE(Vals, '.', ''))) > 2;

5️⃣ Count spaces in string (CountSpaces)
SELECT
    texts,
    LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

6️⃣ Employees earning more than their manager (Employee)
SELECT e.Name AS EmployeeName, e.Salary AS EmpSalary, m.Name AS ManagerName, m.Salary AS ManagerSalary
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;

7️⃣ Employees with 10–15 years service (Employees)
SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 15;

🟡 MEDIUM TASKS
8️⃣ Dates where temperature higher than previous (weather)
SELECT w1.Id, w1.RecordDate, w1.Temperature
FROM weather w1
JOIN weather w2
     ON DATEADD(DAY, -1, w1.RecordDate) = w2.RecordDate
WHERE w1.Temperature > w2.Temperature;

9️⃣ First login date for each player (Activity)
SELECT
    player_id,
    MIN(event_date) AS FirstLoginDate
FROM Activity
GROUP BY player_id;

🔟 Return the third item from list (fruits)
SELECT
    TRIM(value) AS ThirdFruit
FROM STRING_SPLIT((SELECT fruit_list FROM fruits), ',')
WHERE (SELECT COUNT(*) FROM STRING_SPLIT((SELECT fruit_list FROM fruits), ',')
       WHERE value <= STRING_SPLIT((SELECT fruit_list FROM fruits), ',').value) = 3;


(Yengilroq usul SQL Server 2022+ bilan:)

SELECT TRIM(value) AS ThirdFruit
FROM (
    SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM STRING_SPLIT((SELECT fruit_list FROM fruits), ',')
) t
WHERE rn = 3;

11️⃣ Employment stage based on hire date (Employees)
SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsWorked,
    CASE
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;

12️⃣ Extract integer at start (GetIntegers)
SELECT
    Id,
    VALS,
    LEFT(VALS, PATINDEX('%[^0-9]%', VALS + 'X') - 1) AS StartingInteger
FROM GetIntegers
WHERE VALS IS NOT NULL AND VALS LIKE '[0-9]%';

🔴 DIFFICULT TASKS
13️⃣ Swap first two letters of comma-separated string (MultipleVals)
SELECT
    Id,
    STUFF(Vals, 1, 1, SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, 1)) AS Swapped
FROM MultipleVals;


👉 ‘a,b,c’ → ‘b,a,c’

14️⃣ Each character of string as row ('sdgfhsdgfhs@121313131')
DECLARE @txt VARCHAR(100) = 'sdgfhsdgfhs@121313131';
SELECT SUBSTRING(@txt, number, 1) AS Character
FROM master.dbo.spt_values
WHERE type = 'P' AND number BETWEEN 1 AND LEN(@txt);

15️⃣ First logged-in device per player (Activity)
SELECT a.player_id, a.device_id
FROM Activity a
WHERE a.event_date = (
    SELECT MIN(b.event_date)
    FROM Activity b
    WHERE b.player_id = a.player_id
);

16️⃣ Separate integer and character values ('rtcfvty34redt')
DECLARE @str VARCHAR(50) = 'rtcfvty34redt';

SELECT
  (SELECT STRING_AGG(SUBSTRING(@str, number, 1), '')
   FROM master.dbo.spt_values
   WHERE type='P' AND number BETWEEN 1 AND LEN(@str)
         AND SUBSTRING(@str, number, 1) LIKE '[0-9]') AS Integers,
  (SELECT STRING_AGG(SUBSTRING(@str, number, 1), '')
   FROM master.dbo.spt_values
   WHERE type='P' AND number BETWEEN 1 AND LEN(@str)
         AND SUBSTRING(@str, number, 1) LIKE '[A-Za-z]') AS Characters;
