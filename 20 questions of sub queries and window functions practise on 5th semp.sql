CREATE DATABASE sql_practice;
USE sql_practice;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    joining_date DATE,
    city VARCHAR(30)
    );

INSERT INTO employees
(employee_id, employee_name, department, salary, joining_date, city)
VALUES
(1, 'Amit', 'IT', 60000, '2021-01-15', 'Delhi'),
(2, 'Rahul', 'IT', 75000, '2020-03-10', 'Mumbai'),
(3, 'Priya', 'HR', 50000, '2022-06-20', 'Delhi'),
(4, 'Neha', 'HR', 65000, '2021-08-12', 'Kolkata'),
(5, 'Rohan', 'Finance', 70000, '2019-11-05', 'Mumbai'),
(6, 'Sneha', 'Finance', 55000, '2022-01-18', 'Delhi'),
(7, 'Vikash', 'IT', 90000, '2018-04-25', 'Bangalore'),
(8, 'Anjali', 'Marketing', 48000, '2023-02-14', 'Kolkata'),
(9, 'Karan', 'Marketing', 62000, '2021-09-30', 'Mumbai'),
(10, 'Pooja', 'HR', 75000, '2020-12-01', 'Delhi'),
(11, 'Arjun', 'Finance', 80000, '2018-07-19', 'Bangalore'),
(12, 'Meera', 'IT', 65000, '2022-10-10', 'Delhi'),
(13, 'Sahil', 'Marketing', 70000, '2020-05-15', 'Kolkata'),
(14, 'Riya', 'Finance', 60000, '2023-01-11', 'Mumbai'),
(15, 'Deepak', 'IT', 75000, '2021-03-22', 'Bangalore');

-- Q1. Find employees who earn more than the average salary of all employees.
SELECT employee_name,e.department,e.salary
FROM employees e
WHERE salary >
(SELECT avg( salary ) from employees);

-- Q2. Find employees who earn the highest salary in the company.
SELECT *
FROM employees
WHERE salary =
(SELECT max(salary) FROM employees);

-- Q3. Find employees who earn the lowest salary in the company.
SELECT *
FROM employees
WHERE salary =
(SELECT min(salary) FROM employees);

-- Q4. Find employees who earn more than the average salary of the IT department.
select * 
FROM employees
WHERE salary >
(SELECT avg(salary) from employees
WHERE department= 'IT');

-- Q5. Find employees who earn the same salary as any employee in the HR department.
select *
FROM employees
WHERE salary IN
(SELECT salary from employees
where department= 'HR');

-- Q6. Find employees who earn more than all employees in the HR department.
select *
FROM employees
WHERE salary >ALL
(SELECT salary from employees
where department= 'HR');

-- Q7. Find employees who earn more than at least one employee in the Finance department.
select *
FROM employees
WHERE salary > ANY
(SELECT salary from employees
where department= 'Finance');

-- Q8. Find the second-highest salary using a subquery.
SELECT max(salary) FROM employees
WHERE salary <
(SELECT max(salary) FROM employees);

-- Q9. Find employees working in the same department as Amit.
SELECT * FROM employees
WHERE department=
(SELECT department FROM employees
WHERE employee_name='Amit');

-- Q10. Find the department whose average salary is higher than the overall company average salary.
SELECT department,avg(salary) FROM employees
group by department
HAVING avg(salary) >
(SELECT avg(salary) FROM employees);

                 --  REMEMBER THIS QUESTION NEED TO PRACTISE THIS TYPE OF QUE

              --     WINDOW FUNCTIONS QUERIES

-- Q11. Display every employee along with their overall salary rank.
select *,
RANK() over(order by salary DESC) AS salary
from employees;

-- Q12. Rank employees separately within each department based on salary.
select *,
RANK() over(partition by department order by salary ) AS salary
from employees;

-- Q13. Display each employee's salary along with the average salary of their department.
SELECT employee_name,department,salary,
avg(salary)over(partition by department ) AS avg_sal
FROM employees;

-- Q14. Display each employee's salary and the difference between their salary and their department's average salary.
SELECT *,
salary -avg(salary)over(partition by department) AS Differenceavg_sal
FROM employees;

-- Q15. Highest-paid employee from each department
            --   THIS ONE IS IMPORTANT PRACTISE THIS
                    

SELECT *
FROM (
    SELECT
        employee_name,
        department,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
) AS ranked_employees
WHERE rn = 1;

-- Q16. Top 2 employees from each department

        --     important


SELECT *
FROM (
    SELECT
        employee_name,
        department,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
) AS ranked_employees
WHERE rn <= 2;

-- Q17. Row number based on salary
SELECT *,
row_number()over(order by salary) as sal
FROM employees;

-- Q18. Previous employee's salary
SELECT *,
lag(SALARY) OVER(ORDER BY SALARY DESC) AS PREVIOUS_SAL
FROM EMPLOYEES;

-- Q19. Next employee's salary
SELECT *,
LEAD(SALARY) OVER(ORDER BY SALARY DESC) AS AFTER_SAL
FROM EMPLOYEES;

-- Q20. Running total of salaries by joining date
select *,
sum(salary)over(order by joining_date) as totalsal
from employees;


