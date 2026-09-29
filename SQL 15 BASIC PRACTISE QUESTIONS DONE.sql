CREATE DATABASE college;
USE college;

CREATE TABLE college(
id INT PRIMARY KEY auto_increment,
name VARCHAR(50),
marks INT NOT NULL,
subject VARCHAR(100),
grade VARCHAR(1),
status VARCHAR(100)
);

INSERT INTO college (name, marks, subject, grade, status)
VALUES
('Rahul', 85, 'SQL', 'A', 'Pass'),
('Aman', 72, 'Excel', 'B', 'Pass'),
('Priya', 45, 'SQL', 'C', 'Pass'),
('Riya', 32, 'Power BI', 'D', 'Fail');

--  Find students who scored more than 70 marks.
SELECT *
FROM   college
WHERE marks>70;

 -- Find students who have a Pass status.
SELECT *
FROM college
WHERE status = 'Pass';

-- Display only the name, marks, and grade columns.

SELECT name,marks,grade
FROM college;

-- Find students who studied SQL

SELECT name 
From college
WHERE subject="SQL";



-- Find the student with the highest marks.
SELECT max(marks),name  
FROM college
GROUP BY name
LIMIT 1; 

-- 7. Find the student with the lowest marks.

SELECT *
FROM college
WHERE marks = (SELECT MIN(marks) FROM college);

-- Find the average marks of all students.

SELECT avg(marks)
FROM college;

--  OR U CAN ALSO WRITE IN THIS WAY
 
SELECT AVG(marks) AS average_marks
FROM college;

-- 9. Find the number of students in each subject.
SELECT subject, COUNT(*) AS total_students
FROM college
GROUP BY subject;

SELECT subject,COUNT(*)
FROM college
GROUP BY subject;

-- 10 Find the average marks for each subject and display only subjects whose average marks are greater than 50.

SELECT avg(marks),subject
FROM college
GROUP BY subject
HAVING AVG(marks) > 50;



SELECT subject, AVG(marks) AS average_marks
FROM college
GROUP BY subject
HAVING AVG(marks) > 50;


-- Find all students whose marks are between 40 and 80.

SELECT *
FROM college
WHERE marks BETWEEN 40 AND 80;


-- Find all students whose name starts with the letter 'R'.
SELECT *
FROM college
WHERE name LIKE 'R%';


-- Display all students in descending order of their marks (highest to lowest).
SELECT marks,name
FROM college
ORDER BY marks desc;

-- Find the total number of students who passed.
SELECT COUNT(*) AS total_passed
FROM college
WHERE status = 'Pass';

-- Find the highest marks obtained in each subject.

SELECT max(marks),subject
FROM college
GROUP BY subject;



