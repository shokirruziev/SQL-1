-- 1. Employees with Minimum Salary
SELECT name, salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);

-- 2. Products Above Average Price
SELECT product_name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- 3. Employees in Sales Department
SELECT name
FROM employees
WHERE department_id = (
    SELECT id
    FROM departments
    WHERE department_name = 'Sales'
);

-- 4. Customers with No Orders
SELECT name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

-- 5. Products with Max Price in Each Category
SELECT product_name, price, category_id
FROM products p
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);

-- 6. Employees in Department with Highest Average Salary
SELECT name, salary
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

-- 7. Employees Earning Above Department Average
SELECT name, salary, department_id
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

-- 8. Students with Highest Grade per Course
SELECT s.name, g.course_id, g.grade
FROM grades g
JOIN students s ON s.student_id = g.student_id
WHERE g.grade = (
    SELECT MAX(grade)
    FROM grades
    WHERE course_id = g.course_id
);

-- 9. Third-Highest Price per Category
SELECT p1.product_name, p1.price, p1.category_id
FROM products p1
WHERE 2 = (
    SELECT COUNT(DISTINCT p2.price)
    FROM products p2
    WHERE p2.category_id = p1.category_id
      AND p2.price > p1.price
);

-- 10. Employees whose Salary Between Company Average and Department Max Salary
SELECT name, salary, department_id
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
AND salary < (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);
