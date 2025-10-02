✅ 1-qism: Exception Handling (SQL’da TRY...CATCH bilan)
1. ZeroDivisionError (Divide by zero)
BEGIN TRY
    SELECT 10 / 0 AS Result;
END TRY
BEGIN CATCH
    PRINT 'Error: Division by zero!';
END CATCH;

2. ValueError (integer emas bo‘lsa)

SQL’da CONVERT yoki TRY_CAST ishlatiladi:

DECLARE @val NVARCHAR(50) = 'abc';
BEGIN TRY
    SELECT CONVERT(INT, @val) AS Result;
END TRY
BEGIN CATCH
    PRINT 'Error: Not a valid integer!';
END CATCH;

3. FileNotFoundError

SQL’da faylni o‘qishda BULK INSERT ishlatiladi:

BEGIN TRY
    BULK INSERT MyTable
    FROM 'C:\data\non_existing_file.txt'
    WITH (ROWTERMINATOR = '\n');
END TRY
BEGIN CATCH
    PRINT 'Error: File not found!';
END CATCH;

4. TypeError (raqam emas bo‘lsa)
DECLARE @a NVARCHAR(50) = '10a';
DECLARE @b NVARCHAR(50) = '5';
BEGIN TRY
    SELECT CAST(@a AS INT) + CAST(@b AS INT);
END TRY
BEGIN CATCH
    PRINT 'Error: Inputs must be numeric!';
END CATCH;

5. PermissionError (fayl ruxsati yo‘q bo‘lsa)
BEGIN TRY
    BULK INSERT MyTable
    FROM 'C:\Windows\system32\config\secret.txt'
    WITH (ROWTERMINATOR = '\n');
END TRY
BEGIN CATCH
    PRINT 'Error: Permission denied!';
END CATCH;

6. IndexError (index out of range)

SQL’da massiv yo‘q, lekin row number orqali tekshirish mumkin:

BEGIN TRY
    ;WITH cte AS (
        SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS rn, name 
        FROM sys.objects
    )
    SELECT name FROM cte WHERE rn = 999999; -- mavjud bo‘lmagan index
END TRY
BEGIN CATCH
    PRINT 'Error: Index out of range!';
END CATCH;

7. KeyboardInterrupt (foydalanuvchi bekor qilsa)

SQL’da bunday emas, lekin timeout yoki KILL SESSION orqali o‘xshash holat bo‘lishi mumkin. CATCH orqali yozamiz:

BEGIN TRY
    WAITFOR DELAY '00:00:05'; -- vaqtni kutadi
END TRY
BEGIN CATCH
    PRINT 'Error: Query was interrupted!';
END CATCH;

8. ArithmeticError
BEGIN TRY
    SELECT SQRT(-1) AS BadMath;
END TRY
BEGIN CATCH
    PRINT 'Error: Arithmetic error!';
END CATCH;

9. UnicodeDecodeError (encoding masalasi)
BEGIN TRY
    BULK INSERT MyTable
    FROM 'C:\data\utf16_file.txt'
    WITH (DATAFILETYPE = 'widechar'); -- noto‘g‘ri kodlash bo‘lsa xato
END TRY
BEGIN CATCH
    PRINT 'Error: Unicode decode error!';
END CATCH;

10. AttributeError (mavjud bo‘lmagan ustun)
BEGIN TRY
    SELECT NonExistingColumn FROM sys.objects;
END TRY
BEGIN CATCH
    PRINT 'Error: Attribute (column) does not exist!';
END CATCH;

✅ 2-qism: File Input/Output (SQL’da BULK INSERT va OPENROWSET)
1. Faylni to‘liq o‘qish
SELECT * 
FROM OPENROWSET(BULK 'C:\data\myfile.txt', SINGLE_CLOB) AS FileContent;

2. Faylning birinchi n qatori
;WITH Lines AS (
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn, value
    FROM OPENROWSET(BULK 'C:\data\myfile.txt', SINGLE_CLOB) AS f
    CROSS APPLY STRING_SPLIT(f.BulkColumn, CHAR(10))
)
SELECT TOP 5 * FROM Lines; -- birinchi 5 qator

3. Faylga matn qo‘shish (append)

SQL bevosita yozolmaydi, lekin xp_cmdshell orqali yozish mumkin:

EXEC xp_cmdshell 'echo Yangi qator >> C:\data\myfile.txt';

4. Faylning oxirgi n qatori
;WITH Lines AS (
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn, value
    FROM OPENROWSET(BULK 'C:\data\myfile.txt', SINGLE_CLOB) AS f
    CROSS APPLY STRING_SPLIT(f.BulkColumn, CHAR(10))
)
SELECT TOP 5 * FROM Lines ORDER BY rn DESC; -- oxirgi 5 qator

5. Faylni qatorma-qator listga o‘qish
SELECT value AS Line
FROM OPENROWSET(BULK 'C:\data\myfile.txt', SINGLE_CLOB) AS f
CROSS APPLY STRING_SPLIT(f.BulkColumn, CHAR(10));
