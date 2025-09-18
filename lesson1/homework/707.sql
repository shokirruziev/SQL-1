 Easy
1. Define the following terms:

Data:
Raw facts and figures without context. For example, numbers, text, or symbols like 25, "John".

Database:
An organized collection of data stored electronically and accessed using a database management system.

Relational Database:
A type of database that stores data in tables with relationships between them using keys.

Table:
A structure inside a database consisting of rows (records) and columns (fields), similar to a spreadsheet.

2. Five key features of SQL Server:

Data Storage and Retrieval: Supports complex queries to manage large volumes of data efficiently.

Security: Supports user authentication, encryption, and roles.

Backup and Restore: Built-in support for backing up and restoring databases.

High Availability: Features like Always On, Replication, and Clustering.

Integration Services: Tools for data integration (SSIS), reporting (SSRS), and analysis (SSAS).

3. Authentication Modes in SQL Server:

Windows Authentication Mode:
Uses Windows user accounts for access control.

SQL Server Authentication Mode:
Requires users to provide a SQL Server-specific username and password.

✅ Medium
4. Create a new database in SSMS:
CREATE DATABASE SchoolDB;

5. Create the Students table:
USE SchoolDB;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

6. Differences between SQL Server, SSMS, and SQL:
Term	Description
SQL Server	A Relational Database Management System (RDBMS) by Microsoft that stores and retrieves data.
SSMS (SQL Server Management Studio)	A GUI tool for managing SQL Server databases. Allows writing queries, designing tables, and managing servers.
SQL (Structured Query Language)	A language used to interact with relational databases. It is used to query, insert, update, and delete data.
✅ Hard
7. Different SQL Commands:
Command Type	Full Form	Purpose	Example
DQL	Data Query Language	Used to fetch data	SELECT * FROM Students;
DML	Data Manipulation Language	Insert, update, delete data	INSERT INTO Students VALUES (1, 'John', 20);
DDL	Data Definition Language	Create, alter, drop structures	CREATE TABLE Students (...);
DCL	Data Control Language	Control access to data	GRANT SELECT ON Students TO User1;
TCL	Transaction Control Language	Manage transactions	BEGIN TRANSACTION; COMMIT; ROLLBACK;
8. Insert 3 records into the Students table:
INSERT INTO Students (StudentID, Name, Age)
VALUES 
(1, 'Alice', 18),
(2, 'Bob', 19),
(3, 'Charlie', 20);

9. Restore AdventureWorksDW2022.bak File – Steps:
🔗 Link:

AdventureWorksDW2022.bak

📌 Steps:

Download the .bak file from the link and save it locally (e.g., C:\Backups\AdventureWorksDW2022.bak).

Open SSMS and connect to your SQL Server instance.

Right-click "Databases" > Restore Database…

In the Restore Database dialog:

Choose Device > Click the ... button > Add > Select the .bak file.

Click OK.

SQL Server will automatically detect the database name.

Go to the Files tab and ensure the file paths are valid for your system.

Click OK to start restoring.

Once restored, the database AdventureWorksDW2022 will appear in your Databases list.
