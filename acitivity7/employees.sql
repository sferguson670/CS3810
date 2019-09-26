-- Employees database
-- Sarah Ferguson

CREATE DATABASE employees;
USE employees;

-- create table departments;
CREATE TABLE Departments (
	code  CHAR(2)   PRIMARY KEY,
	`desc` VARCHAR(25)   NOT NULL
);

-- populate table departments
INSERT INTO Departments VALUES('HR', 'Human Resources');
INSERT INTO Departments VALUES('IT', 'Information Technology');
INSERT INTO Departments VALUES('SL', 'Sales');

-- create table employees
CREATE TABLE Employees(
   id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(30) NOT NULL, 
   sal INT NOT NULL, 
   deptCode CHAR(2),
   FOREIGN KEY (deptCode) REFERENCES Departments(code)
);

-- populate table Employees
INSERT INTO Employees(name, sal, deptCode) VALUES ('Sam Mai Tai',        50000, 'HR');
INSERT INTO Employees(name, sal, deptCode) VALUES ('James Brandy',       55000, 'HR');
INSERT INTO Employees(name, sal, deptCode) VALUES ('Whisky Strauss',     60000, 'HR');
INSERT INTO Employees(name, sal, deptCode) VALUES ('Romeo Curacau',      65000, 'IT');
INSERT INTO Employees(name, sal, deptCode) VALUES ('Jose Caipirinha',    65000, 'IT');
INSERT INTO Employees(name, sal, deptCode) VALUES ('Tony Gin and Tonic', 80000, 'SL');
INSERT INTO Employees(name, sal, deptCode) VALUES ('Debby Derby',        85000, 'SL');
INSERT INTO Employees(name, sal, deptCode) VALUES ('Mobid Mojito',       150000, NULL);

-- queries
-- a) list all rows in Departments
SELECT * FROM Departments;

-- b) list only the codes in Departments
SELECT code FROM Departments;

-- c) list all rows in Employees
SELECT * FROM Employees;

-- d) list only the names in Employees in alphabetical order
SELECT name FROM Employees ORDER BY name;

-- e) list only the names and salaries in Employees, from the highest to lowest salary
SELECT name, sal FROM Employees ORDER BY sal;

-- f) list the cartesian product of Employees and Departments
SELECT * FROM Employees, Departments;

-- g) do the natural join of Employees and Departments; the resul hsould be exactly the same as the cartesian product; do you know why?
SELECT * FROM Employees NATURAL JOIN Departments;

-- i) do an equi join of Employees and Departments matching thr rows by Employees.deptCode and Departments.code (hint: use JOIN and the ON clause)
SELECT * FROM Employees A INNER JOIN Departments B ON A.deptCode = B.code;

-- j) same as previous query but project name and salary of the meployees plus the description of their departments
SELECT A.name, A.sal, B.`desc` FROM Employees A INNER JOIN Departments B ON A.deptCode = B.code;

-- k) same as previous query but only the employees that earn less than 60000
SELECT A.name, A.sal, B.`desc` FROM Employees A INNER JOIN Departments B ON A.deptCode = B.code WHERE  sal < 60000;

-- l) same as query 'i' but only the employees that earn more than 'Jose Caipirinha'
SET @salCaipirinha := (SELECT sal FROM Employees WHERE name = 'Jose Caipirinha');
SELECT * FROM Employees A INNER JOIN Departments B ON A.deptCode = B.code WHERE sal > @salCaipirinha;

-- m) list the left outer join of Employees and Departments (use the ON clause to match by department code); how does the result of this query differs from query 'i'?
SELECT * FROM Employees A LEFT JOIN Departments B ON A.deptCode = B.code;

-- n) from query 'm', how would you do the left anti-join?
SELECT * FROM Employees A LEFT JOIN Departments B ON A.deptCode = B.code WHERE deptCode IS NULL;

-- o) show the number of employees per department
SELECT deptCode AS Department, COUNT(*) AS Total FROM Employees GROUP BY deptCode HAVING deptCode IS NOT NULL;

SELECT deptCode AS Department, COUNT(*) AS Total FROM Employees WHERE deptCode IS NOT NULL GROUP BY deptCode;

-- p) same as query 'o' but I want to see the description of each department (not just their codes).
SELECT B.desc, A.total FROM (SELECT deptCode, COUNT(*) AS Total FROM Employees GROUP BY deptCode HAVING deptCode IS NOT NULL) A INNER JOIN Departments B ON A.deptCode = B.code;