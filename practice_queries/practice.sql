CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INTEGER REFERENCES departments(department_id),
    salary DECIMAL(10,2),
    hire_date DATE
)

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Inserting sample data into the departments table
INSERT INTO departments (department_name) VALUES 
    ('HR'), 
    ('Marketing'), 
    ('Finance'), 
    ('IT'), 
    ('Sales'), 
    ('Engineering'), 
    ('Customer Support'), 
    ('Administration'), 
    ('Research'), 
    ('Quality Assurance');

-- Inserting sample data into the employees table with a foreign key constraint
INSERT INTO employees (employee_name, department_id, salary, hire_date) VALUES 
    ('John Doe', 1, 60000.00, '2022-01-10'),
    ('Jane Smith', 2, 75000.50, '2021-05-22'),
    ('Bob Johnson', 3, 80000.75, '2020-11-15'),
    ('Alice Williams', 4, 90000.25, '2019-08-03'),
    ('David Lee', 5, 65000.50, '2020-03-18'),
    ('Sara Brown', 6, 70000.00, '2021-09-28'),
    ('Mike Miller', 7, 55000.75, '2022-02-05'),
    ('Emily Davis', 8, 95000.00, '2018-12-12'),
    ('Chris Wilson', 9, 72000.50, '2020-06-30'),
    ('Amy White', 10, 68000.25, '2021-11-09'),
    ('John Johnson', 1, 62000.00, '2022-01-15'),
    ('Jessica Thompson', 2, 78000.50, '2021-06-05'),
    ('Michael Harris', 3, 85000.75, '2020-11-25'),
    ('Emma Martinez', 4, 92000.25, '2019-09-15'),
    ('James Taylor', 5, 67000.50, '2020-04-08'),
    ('Sophia Anderson', 6, 72000.00, '2021-10-10'),
    ('William Jackson', 7, 56000.75, '2022-02-10'),
    ('Olivia Nelson', 8, 97000.00, '2018-12-20'),
    ('Daniel White', 9, 73000.50, '2020-07-05'),
    ('Ava Wilson', 10, 69000.25, '2021-11-15'),
    ('Matthew Brown', 1, 63000.00, '2022-01-20'),
    ('Emily Garcia', 2, 76000.50, '2021-06-15'),
    ('Christopher Allen', 3, 86000.75, '2020-12-05'),
    ('Madison Hall', 4, 93000.25, '2019-09-25'),
    ('Andrew Cook', 5, 68000.50, '2020-04-18'),
    ('Abigail Torres', 6, 73000.00, '2021-10-20'),
    ('Ethan Murphy', 7, 57000.75, '2022-02-15'),
    ('Ella King', 8, 98000.00, '2018-12-28'),
    ('Nathan Rivera', 9, 74000.50, '2020-07-15'),
    ('Mia Roberts', 10, 70000.25, '2021-11-20');

SELECT * FROM employees;

SELECT * FROM departments;



-- 1. **Inner Join to Retrieve Employee and Department Information**

SELECT * FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id;

-- - This joining we have do multiple time so, if any table contains same column name like here two `department_id ` is available. we can use a short syntax named `USING`

SELECT * FROM employees
INNER JOIN departments USING(department_id);

-- 2. **Group By Department with Average Salary**



SELECT department_name, round(avg(salary)) as avg_salary FROM employees
INNER JOIN departments USING(department_id)
GROUP BY department_name;



-- 3. **Count Employees in Each Department**

SELECT department_name, count(*) as employee_count FROM employees
INNER JOIN departments USING(department_id)
GROUP BY department_name;

-- 4. **Find the Department name with the Highest Average Salary**

SELECT department_name, round(avg(salary)) as avg_salary FROM employees
INNER JOIN departments USING(department_id)
GROUP BY department_name
ORDER BY avg_salary DESC
LIMIT 1;
;

-- 5. **Count Employees Hired Each Year**

SELECT extract(year from hire_date) as hired_years, count(*) FROM employees

GROUP BY hired_years;




--  **6:** Find customers who have placed more than 2 orders and calculate the total amount spent by  each of these customers.

CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
)


INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(101, '2025-03-01', 199.99),
(102, '2025-03-05', 89.50),
(103, '2025-03-12', 145.00),
(104, '2025-03-25', 320.75),
(101, '2025-04-02', 25.99),
(105, '2025-04-07', 470.00),
(106, '2025-04-15', 129.49),
(101, '2025-04-28', 250.00),
(102, '2025-05-01', 78.90),
(107, '2025-05-03', 199.00),
(101, '2025-05-08', 310.00),
(103, '2025-05-10', 59.99),
(108, '2025-05-15', 410.45),
(102, '2025-05-22', 120.00),
(104, '2025-05-29', 84.99),
(109, '2025-06-01', 520.00),
(101, '2025-06-05', 94.25),
(106, '2025-06-10', 239.00),
(102, '2025-06-15', 305.75),
(103, '2025-06-20', 157.30);


SELECT * FROM orders;
DROP table orders;
SELECT customer_id, COUNT(*) AS total_orders, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;



--  7: Find the total amount of orders placed each month in the year 2025.

SELECT extract(month FROM order_date) as order_months, count(order_date) FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2025
GROUP BY order_months;


