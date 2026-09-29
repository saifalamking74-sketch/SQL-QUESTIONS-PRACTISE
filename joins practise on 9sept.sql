CREATE DATABASE join_practice;
USE join_practice;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    salary INT,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT
);

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    hours_worked INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO departments VALUES
(1, 'IT', 'Kolkata'),
(2, 'HR', 'Delhi'),
(3, 'Finance', 'Mumbai'),
(4, 'Marketing', 'Bangalore'),
(5, 'Sales', 'Chennai'),
(6, 'Operations', 'Pune');


INSERT INTO employees VALUES
(101, 'Rahul', 1, 60000, NULL),
(102, 'Priya', 1, 50000, 101),
(103, 'Amit', 2, 45000, NULL),
(104, 'Sneha', 2, 55000, 103),
(105, 'Vikash', 3, 70000, NULL),
(106, 'Neha', 3, 48000, 105),
(107, 'Rohan', 4, 40000, NULL),
(108, 'Anjali', 4, 52000, 107),
(109, 'Arjun', NULL, 35000, NULL),
(110, 'Karan', 5, 65000, NULL);


INSERT INTO projects VALUES
(201, 'Website Development', 1),
(202, 'Recruitment System', 2),
(203, 'Financial Dashboard', 3),
(204, 'Marketing Campaign', 4),
(205, 'Sales Analysis', 5),
(206, 'Mobile App', 1),
(207, 'Customer Research', 4),
(208, 'Automation System', 6);

INSERT INTO employee_projects VALUES
(101, 201, 120),
(102, 201, 100),
(102, 206, 80),
(103, 202, 90),
(104, 202, 110),
(105, 203, 130),
(106, 203, 95),
(107, 204, 70),
(108, 204, 100),
(108, 207, 60),
(110, 205, 125);

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM projects;
SELECT * FROM employee_projects;





-- Q1. Display every employee along with their department name.
SELECT * FROM employees e
inner join departments d
on e.department_id=d.department_id;

-- Q3. Display all employees, including employees who don't belong to any department.
SELECT    e.employee_name,
    d.department_name FROM employees e
left join departments d
 on e.department_id=d.department_id;

-- Q5. Find employees who don't belong to any department.
SELECT 
    e.employee_id,
    e.employee_name
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- Q8. Display employees and the projects they are working on.
SELECT 
    e.employee_name,
    p.project_name
FROM employees e
JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
JOIN projects p
    ON ep.project_id = p.project_id;

-- Q9. Display employee name, project name, and hours worked.
SELECT 
    e.employee_name,
    p.project_name,
    ep.hours_worked
FROM employees e
JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
JOIN projects p
    ON ep.project_id = p.project_id;
    
--     Q10. Find employees who are not assigned to any project.
    SELECT 
    e.employee_id,
    e.employee_name
FROM employees e
LEFT JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL;
    
--     Q11. Display all projects, including projects that have no employees assigned to them.
    
    SELECT 
    p.project_name,
    e.employee_name
FROM projects p
LEFT JOIN employee_projects ep
    ON p.project_id = ep.project_id
LEFT JOIN employees e
    ON ep.employee_id = e.employee_id;
    
--     Q12. Find employees working in the IT department.

SELECT 
    e.employee_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE d.department_name = 'IT';

-- Q13. Find employees whose salary is greater than 50,000 and display their department name.
SELECT 
    e.employee_name,
    e.salary,
    d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.salary > 50000;

-- Q14. Display the total hours worked by each employee on projects.
SELECT 
    e.employee_name,
    SUM(ep.hours_worked) AS total_hours
FROM employees e
JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
GROUP BY e.employee_id, e.employee_name;



-- Q15. Find the employees who worked more than 100 hours on a project, showing employee name, project name, and hours worked.
SELECT 
    e.employee_name,
    p.project_name,
    ep.hours_worked
FROM employees e
JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
JOIN projects p
    ON ep.project_id = p.project_id
WHERE ep.hours_worked > 100;







    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    