CREATE DATABASE company;
USE company;


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);

INSERT INTO employees VALUES
(1, 'Rahul', 'IT', 60000, '2021-01-15'),
(2, 'Priya', 'HR', 50000, '2020-03-10'),
(3, 'Amit', 'IT', 75000, '2019-07-20'),
(4, 'Sneha', 'Finance', 65000, '2022-02-05'),
(5, 'Ravi', 'IT', 55000, '2023-06-12'),
(6, 'Neha', 'HR', 60000, '2021-08-18'),
(7, 'Arjun', 'Finance', 80000, '2018-11-25'),
(8, 'Pooja', 'HR', 45000, '2024-01-10'),
(9, 'Karan', 'Finance', 70000, '2020-09-15'),
(10, 'Anjali', 'IT', 90000, '2018-05-30');

-- Q1. Assign a unique row number to every employee based on salary from highest to lowest.

SELECT *,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;
 
                  --   OR U CAN WRITE IN THIS METHOD
SELECT 
    name,
    department,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

-- Q2. Rank employees based on salary from highest to lowest. Employees with the same salary should have the same rank.

SELECT *,
RANK() OVER(ORDER BY salary DESC) as h_salary
FROM employees;

-- Q3. Rank employees based on salary without leaving gaps when salaries are tied.
SELECT *,
DENSE_RANK() OVER(ORDER BY salary DESC ) as h_salary
FROM employees;
                         --      OR
SELECT 
    name,
    department,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- Q4. Find the salary rank of each employee within their own department.
SELECT *,
RANK() OVER(partition by department order by salary DESC) AS department_rnk
FROM employees;

-- Q5. Find the highest-paid employee from each department.

SELECT e.name,e.department,e.salary,
RANK() OVER(partition by departmenT order by salary DESC) AS RNK
FROM employees e;


SELECT *
FROM (
    SELECT 
        name,
        department,
        salary,
        RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
) t
WHERE rnk = 1;


-- Q6. Show each employee's salary along with the average salary of their department.
SELECT *,
avg(salary) OVER(partition by department) AS avg_sal
FROM employees;

                       --       OR

SELECT 
    name,
    department,
    salary,
    AVG(salary) OVER (
        PARTITION BY department
    ) AS department_avg_salary
FROM employees;

-- Q7. Calculate the running total of salaries ordered by employee's hire date.

SELECT *,
SUM(salary) OVER(order by salary DESC) AS highest_salary
FROM employees;

-- Q8. Show each employee's salary and the salary of the employee hired immediately before them.

SELECT *,
LAG(salary) OVER(order by salary DESC) AS pre_salary
FROM employees;

-- Q9. Show each employee's salary and the salary of the employee hired immediately after them.

SELECT *,
LEAD(salary) OVER(order by salary DESC) AS AFTER_salary
FROM employees;

-- Q10. Find the difference between each employee's salary and the average salary of their department.

SELECT  name,
    department,
    salary,
avg(salary) OVER(partition by department) AS avg_sal,
e.salary - avg(salary) OVER(partition by department) AS diff_sal
FROM employees e;


--    THE UPPER ONE I TRIED CAREFULLY LOOK INTO IT....


SELECT 
    name,
    department,
    salary,
    AVG(salary) OVER (
        PARTITION BY department
    ) AS avg_department_salary,
    salary - AVG(salary) OVER (
        PARTITION BY department
    ) AS salary_difference
FROM employees;
