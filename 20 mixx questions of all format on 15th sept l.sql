CREATE DATABASE sql_practice;
USE sql_practice;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    age INT,
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    employee_id INT,
    order_date DATE,
    quantity INT,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO customers VALUES
(1, 'Rahul', 'Delhi', 25, '2024-01-15'),
(2, 'Aman', 'Mumbai', 30, '2024-02-20'),
(3, 'Priya', 'Kolkata', 28, '2024-03-10'),
(4, 'Riya', 'Delhi', 22, '2024-04-05'),
(5, 'Arjun', 'Bangalore', 35, '2024-05-12'),
(6, 'Sneha', 'Mumbai', 27, '2024-06-18'),
(7, 'Vikash', 'Kolkata', 32, '2024-07-22'),
(8, 'Neha', 'Pune', 26, '2024-08-14'),
(9, 'Karan', 'Delhi', 29, '2024-09-01'),
(10, 'Anjali', 'Pune', 24, '2024-10-11');


INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Mobile', 'Electronics', 30000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Keyboard', 'Accessories', 1500),
(105, 'Mouse', 'Accessories', 800),
(106, 'Monitor', 'Electronics', 15000),
(107, 'Tablet', 'Electronics', 25000),
(108, 'Chair', 'Furniture', 7000),
(109, 'Desk', 'Furniture', 12000),
(110, 'Printer', 'Electronics', 10000);

INSERT INTO employees VALUES
(201, 'Raj', 'Sales', 45000),
(202, 'Simran', 'Sales', 50000),
(203, 'Amit', 'IT', 65000),
(204, 'Pooja', 'HR', 55000),
(205, 'Rohan', 'Sales', 48000),
(206, 'Kavita', 'IT', 70000);


INSERT INTO orders VALUES
(1001, 1, 101, 201, '2024-11-01', 1, 60000),
(1002, 2, 102, 202, '2024-11-02', 2, 60000),
(1003, 3, 103, 201, '2024-11-03', 3, 6000),
(1004, 4, 104, 205, '2024-11-04', 2, 3000),
(1005, 5, 106, 202, '2024-11-05', 1, 15000),
(1006, 6, 107, 205, '2024-11-06', 2, 50000),
(1007, 7, 108, 201, '2024-11-07', 1, 7000),
(1008, 8, 109, 202, '2024-11-08', 1, 12000),
(1009, 9, 101, 205, '2024-11-09', 2, 120000),
(1010, 10, 110, 201, '2024-11-10', 1, 10000),
(1011, 1, 102, 202, '2024-11-11', 1, 30000),
(1012, 2, 103, 205, '2024-11-12', 5, 10000),
(1013, 3, 106, 201, '2024-11-13', 2, 30000),
(1014, 5, 108, 202, '2024-11-14', 2, 14000),
(1015, 6, 101, 205, '2024-11-15', 1, 60000);


select * from customers;
select * from products;
select * from employees;
select * from orders;

-- Q3. Find customers who live in Delhi.
select customer_name from customers
where city='Delhi';

-- Q4. Find all customers whose age is greater than 25.
select * from customers 
 where age> 25;


-- Q5. Display products whose price is between ₹5,000 and ₹30,000.
select * from products 
where price between 5000 and 30000;


-- Q6. Find the total number of customers in each city.
select count(customer_name),city
from customers
 group by city;


-- Q7. Find the average product price for each category.
select avg(price),category 
from products
group by category;


-- Q8. Find categories where the average product price is greater than ₹10,000.
select category ,avg(price)  from products
group by category
having avg(price)>10000;


-- Q9. Find the total sales amount.
select sum(total_amount) from orders;

-- Q10. Find the customer who has spent the most money.
select customer_name,sum(total_amount) from customers as c
join  orders as o on 
c.customer_id=o.customer_id
group by customer_name
limit 1;
              -- the upper one is done by mw but its incorrect kindly lo9ok forwrd in it afterwards and undewrstand it


SELECT c.customer_name,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 1;

-- Q12. Find employees who handled orders worth more than ₹50,000 in total.

                 --         look this carefullly
SELECT e.employee_name,
       SUM(o.total_amount) AS total_sales
FROM employees e
JOIN orders o
    ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.employee_name
HAVING SUM(o.total_amount) > 50000;


-- Q13. Find the second-highest product price.
select * from products
where price <
(select max(price) from products)
limit 1;

-- Q14. Find customers who have spent more than the average customer spending.

SELECT c.customer_name,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT customer_id,
               SUM(total_amount) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) AS customer_sales
);

-- Q15. Show every product and indicate whether its price is Low, Medium, or High.

SELECT product_name,
       price,
       CASE
           WHEN price < 5000 THEN 'Low'
           WHEN price BETWEEN 5000 AND 20000 THEN 'Medium'
           ELSE 'High'
       END AS price_category
FROM products;

-- Q16. Find the highest-selling product based on total sales amount.
select product_name,sum(total_amount)
from products as p
join orders as o 
on p.product_id=o.product_id
group by product_name ;


-- Q17. Rank employees according to their total sales.
                                       --    look this
SELECT e.employee_name,
       SUM(o.total_amount) AS total_sales,
       RANK() OVER (
           ORDER BY SUM(o.total_amount) DESC
       ) AS sales_rank
FROM employees e
JOIN orders o
    ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.employee_name;


-- Q18. Find the top 3 customers based on total spending.( look  this questions )
SELECT c.customer_name,
       SUM(o.total_amount) AS total_spent,
       DENSE_RANK() OVER (
           ORDER BY SUM(o.total_amount) DESC
       ) AS customer_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
LIMIT 3;

-- Q19. For each customer, show their total spending and the average spending of all customers.
          --   ( CTE QUEESTIONS LOKK )
WITH customer_sales AS (
    SELECT customer_id,
           SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_name,
       cs.total_spent,
       AVG(cs.total_spent) OVER () AS average_customer_spending
FROM customer_sales cs
JOIN customers c
    ON cs.customer_id = c.customer_id;


-- Q20. For each employee, show their sales, sales rank, and difference between their sales and the highest employee sales.

WITH employee_sales AS (
    SELECT e.employee_id,
           e.employee_name,
           SUM(o.total_amount) AS total_sales
    FROM employees e
    JOIN orders o
        ON e.employee_id = o.employee_id
    GROUP BY e.employee_id, e.employee_name
)
SELECT employee_name,
       total_sales,

       RANK() OVER (
           ORDER BY total_sales DESC
       ) AS sales_rank,

       MAX(total_sales) OVER () - total_sales
           AS difference_from_top
FROM employee_sales
ORDER BY sales_rank;









