1️⃣ is_prime(n) funksiyasi (tub sonni tekshirish)

SQL Server’da user-defined function (UDF) orqali yoziladi:

CREATE FUNCTION is_prime (@n INT)
RETURNS BIT
AS
BEGIN
    IF @n < 2 RETURN 0;
    DECLARE @i INT = 2;
    WHILE @i * @i <= @n
    BEGIN
        IF @n % @i = 0
            RETURN 0;
        SET @i = @i + 1;
    END
    RETURN 1;
END;
GO

-- Sinash
SELECT dbo.is_prime(4) AS Result1, dbo.is_prime(7) AS Result2;


Natija:

Result1 | Result2
--------+--------
0       | 1

2️⃣ digit_sum(k) funksiyasi (raqamlar yig‘indisi)
CREATE FUNCTION digit_sum (@k INT)
RETURNS INT
AS
BEGIN
    DECLARE @sum INT = 0;
    DECLARE @num INT = @k;
    WHILE @num > 0
    BEGIN
        SET @sum = @sum + (@num % 10);
        SET @num = @num / 10;
    END
    RETURN @sum;
END;
GO

-- Sinash
SELECT dbo.digit_sum(24) AS Sum1, dbo.digit_sum(502) AS Sum2;


Natija:

Sum1 | Sum2
-----+-----
6    | 7

3️⃣ Ikki sonning darajalari (2 ning darajalari)

Bu yerda WHILE loop ishlatamiz:

CREATE PROCEDURE powers_of_two @N INT
AS
BEGIN
    DECLARE @x INT = 2;
    WHILE @x <= @N
    BEGIN
        PRINT CAST(@x AS VARCHAR(20));
        SET @x = @x * 2;
    END
END;
GO

-- Sinash
EXEC powers_of_two 10;


Natija (PRINT orqali chiqadi):

2
4
8
