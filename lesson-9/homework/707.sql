Задания легкого уровня (10)

1. Товары × Поставщики – комбинационные предложения

ВЫБЕРИТЕ P.НазваниеПродукта, S.НазваниеПоставщика
ИЗ ПРОДУКТОВ P
CROSS JOIN Поставщики S;


2. Подразделения × Сотрудники – barcha kombinatsiyalar

ВЫБЕРИТЕ D.НазваниеОтдела, E.Название AS ИмяСотрудника
ИЗ Департаментов D
CROSS JOIN Сотрудники E;


3. Продукты и поставщики – хакики етказиб берувчи комбинацияси

ВЫБЕРИТЕ S.НазваниеПоставщика, P.НазваниеПродукта
ИЗ ПРОДУКТОВ P
INNER JOIN Поставщики S ON P.SupplierID = S.SupplierID;


4. Клиенты и заказы – mijoz va buyurtma IDlari

SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
ОТ клиентов C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID;


5. Студенты × Курсы – barcha kombinatsiyalar

ВЫБЕРИТЕ S.Name AS StudentName, C.CourseName
ОТ студентов S
CROSS JOIN Курсы C;


6. Products va Orders – ProductID mos bo'lsa

ВЫБРАТЬ P.НазваниеПродукта, O.IDЗаказа
ИЗ ПРОДУКТОВ P
INNER JOIN Заказы O ON P.ProductID = O.ProductID;


7. Отделы и сотрудники – DepartmentID mos kelgan xodimlar

ВЫБЕРИТЕ E.Name AS EmployeeName, D.DepartmentName
ОТ сотрудников E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;


8. Набор студентов – kursga yozilganlar

ВЫБЕРИТЕ S.Name AS StudentName, E.CourseID
ОТ студентов S
INNER JOIN Зачисления E ON S.StudentID = E.StudentID;


9. Платежи и заказы – самое важное

ВЫБЕРИТЕ O.OrderID, P.PaymentID, P.Amount
ОТ Платежи P
INNER JOIN Orders O ON P.OrderID = O.OrderID;


10. Заказы и продукты – общая сумма > 100 фунтов стерлингов.

ВЫБРАТЬ O.OrderID, P.ProductName, P.Price
ОТ Приказов О
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Товары P НА O.ProductID = P.ProductID
ГДЕ P.Price > 100;

🟡 Задачи среднего уровня (10)

1. Сотрудники × Подразделения – IDlari teng bo'lmagan kombinatsiyalar

ВЫБЕРИТЕ E.Name AS EmployeeName, D.DepartmentName
ОТ сотрудников E
INNER JOIN Departments D ON E.DepartmentID <> D.DepartmentID;


2. Заказы против товаров – Количество > StockQuantity

ВЫБРАТЬ O.OrderID, P.ProductName, O.Quantity, P.StockQuantity
ОТ Приказов О
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Товары P НА O.ProductID = P.ProductID
ГДЕ O.Количество > P.КоличествоНаличии;


3. Клиенты и продажи – сумма продажи >= 500

SELECT C.FirstName + ' ' + C.LastName AS CustomerName, S.ProductID, S.SaleAmount
ОТ клиентов C
INNER JOIN Sales S ON C.CustomerID = S.CustomerID
ГДЕ S.SaleAmount >= 500;


4. Курсы, набор, студенты – йозилган курслари

ВЫБЕРИТЕ S.Name AS StudentName, C.CourseName
ОТ студентов S
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Зачисления E ON S.StudentID = E.StudentID
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Курсы C ON E.CourseID = C.CourseID;


5. Products va Suppliers – SupplierName “Tech” bo'lsa

ВЫБЕРИТЕ P.НазваниеПродукта, S.НазваниеПоставщика
ИЗ ПРОДУКТОВ P
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Поставщики S ON P.SupplierID = S.SupplierID
WHERE S.SupplierName LIKE '%Tech%';


6. Заказы и платежи – Оплата < Общая сумма

ВЫБРАТЬ O.OrderID, O.TotalAmount, P.Amount
ОТ Приказов О
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Платежи P ON O.OrderID = P.OrderID
ГДЕ P.Сумма < O.ОбщаяСумма;


7. Сотрудники и отделы – Сотрудник + Название отдела

ВЫБЕРИТЕ E.Name AS EmployeeName, D.DepartmentName
ОТ сотрудников E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;


8. Товары категории – Электроника yoki Мебель

ВЫБРАТЬ P.НазваниеПродукта, C.НазваниеКатегории
ИЗ ПРОДУКТОВ P
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Категории C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Электроника', 'Мебель');


9. Продажи и клиенты – faqat USA mijozlari

SELECT S.SaleID, S.SaleAmount, C.FirstName + ' ' + C.LastName AS CustomerName
ОТ ПРОДАЖ S
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Клиенты C ON S.CustomerID = C.CustomerID
ГДЕ C.Country = 'США';


10. Заказы клиентов – Германия, TotalAmount > 100

SELECT O.OrderID, O.TotalAmount, C.FirstName + ' ' + C.LastName AS CustomerName
ОТ Приказов О
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
ГДЕ C.Country = 'Германия' И O.TotalAmount > 100;

🔴 Задания сложного уровня (5)

1. Сотрудники – turli Departmentdagi Juftliklar

ВЫБЕРИТЕ E1.Name AS Employee1, D1.DepartmentName AS Dept1,
E2.Name AS Employee2, D2.DepartmentName AS Dept2
ОТ сотрудников E1
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Сотрудники E2 НА E1.EmployeeID < E2.EmployeeID
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Отделы D1 НА E1.DepartmentID = D1.DepartmentID
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Отделы D2 НА E2.DepartmentID = D2.DepartmentID
ГДЕ E1.IDОтдела <> E2.IDОтдела;


2. Платежи, заказы, товары – Сумма ≠ Количество × Цена

ВЫБРАТЬ P.PaymentID, O.OrderID, P.Amount, (O.Quantity * PR.Price) AS ExpectedAmount
ОТ Платежи P
INNER JOIN Orders O ON P.OrderID = O.OrderID
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Products PR ON O.ProductID = PR.ProductID
ГДЕ P.Сумма <> (O.Количество * PR.Цена);


3. Студенты – курсга йозилмаганлар

ВЫБЕРИТЕ S.StudentID, S.Name
ОТ студентов S
LEFT JOIN Зачисления E ON S.StudentID = E.StudentID
ГДЕ E.StudentID РАВЕН NULL;


4. Сотрудники – менеджер бо'лган, лекин ойлиги <= бошкарадиган одамдан

ВЫБЕРИТЕ M.Name AS ManagerName, M.Salary AS ManagerSalary,
E.Name AS EmployeeName, E.Salary AS EmployeeSalary
ОТ сотрудников E
ВНУТРЕННЕЕ СОЕДИНЕНИЕ Сотрудники M ON E.ManagerID = M.EmployeeID
ГДЕ M.Зарплата <= E.Зарплата;


5. Заказы, платежи, клиенты – buyurtma qilgan, lekin Payment yo'q

SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
ОТ Приказов О
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
LEFT JOIN Платежи P ON O.OrderID = P.OrderID
ГДЕ P.PaymentID РАВЕН NULL;
