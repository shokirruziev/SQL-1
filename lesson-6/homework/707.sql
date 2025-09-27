Puzzle 1: Finding Distinct Values

Bizda a-b va b-a bir xil hisoblanishi kerak.
Buni ikkita usulda qilsa bo‘ladi:

Usul 1: DISTINCT + CASE
SELECT DISTINCT 
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;

Usul 2: GROUP BY bilan
SELECT 
       MIN(col1) AS col1,
       MAX(col2) AS col2
FROM InputTbl
GROUP BY 
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END;


Natija:

| col1 | col2 |
|------|------|
| a    | b    |
| c    | d    |
| m    | n    |

Puzzle 2: Removing Rows with All Zeroes
SELECT *
FROM TestMultipleZero
WHERE A <> 0 OR B <> 0 OR C <> 0 OR D <> 0;

Puzzle 3: Find those with odd ids
SELECT *
FROM section1
WHERE id % 2 = 1;

Puzzle 4: Person with the smallest id
SELECT TOP 1 *
FROM section1
ORDER BY id ASC;

Puzzle 5: Person with the highest id
SELECT TOP 1 *
FROM section1
ORDER BY id DESC;

Puzzle 6: People whose name starts with b

(SQL Server LIKE default case-insensitive)

SELECT *
FROM section1
WHERE name LIKE 'B%';

Puzzle 7: Code containing underscore _ (literal)

Underscore (_) — bu wildcard, shuning uchun uni escape qilish kerak.

SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';


Natija:

| Code  |
|-------|
| X_456 |
| X_ABC |
