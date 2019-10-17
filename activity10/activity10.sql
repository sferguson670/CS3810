-- File activity10.sql
-- Orders database
-- Author Sarah Ferguson
-- Date 10/17/2019

-- create database orders
CREATE DATABASE orders;

USE orders;

-- create table Products
CREATE TABLE Products (
	id INT PRIMARY KEY AUTO_INCREMENT,
	descr VARCHAR(20) NOT NULL,
	price DECIMAL(10,2) NOT NULL
);

-- insert data into Products
INSERT INTO Products (descr, price) VALUES ("Ninja Sword", 250);
INSERT INTO Products (descr, price) VALUES ("Dummy", 50);
INSERT INTO Products (descr, price) VALUES ("Fake Blood", 5);
INSERT INTO Products (descr, price) VALUES ("Rubber Ducky", 1);
INSERT INTO Products (descr, price) VALUES ("Bathtub Soap", 3);
INSERT INTO Products (descr, price) VALUES ("Brazilian Coffee", 5);
INSERT INTO Products (descr, price) VALUES ("Running Shoes", 50);

-- create table Orders
CREATE TABLE Orders (
	number INT PRIMARY KEY,
	date DATE NOT NULL
);

-- insert data into Orders
INSERT INTO Orders VALUES (101, '2017-09-12');
INSERT INTO Orders VALUES (202, '2018-09-27');
INSERT INTO Orders VALUES (303, '2018-09-30');
INSERT INTO Orders VALUES (404, '2019-10-12');

-- create table Items
CREATE TABLE Items (
	number INT,
	id INT,
	PRIMARY KEY (number, id),
	qtt INT NOT NULL,
	FOREIGN KEY (number) REFERENCES Orders (number),
	FOREIGN KEY (id) REFERENCES Products (id)
);

-- create trigger for items
DELIMITER |
CREATE TRIGGER item_qtt_default
	BEFORE INSERT
	ON Items
	FOR EACH ROW
		BEGIN
			IF NEW.qtt <= 0 THEN
				SET NEW.qtt = 1;
			END IF;
		END;
|
DELIMITER;

-- insert data into Items
INSERT INTO Items VALUES (101, 1, -1);
-- above entry will cause a trigger
INSERT INTO Items VALUES (101, 2, 10);
INSERT INTO Items VALUES (101, 3, 5);
INSERT INTO Items VALUES (202, 4, 200);
INSERT INTO Items VALUES (202, 6, 10);
INSERT INTO Items VALUES (303, 7, 0);
-- above entry will cause a trigger
INSERT INTO Items VALUES (303, 1, 10);
INSERT INTO Items VALUES (404, 4, 1);
INSERT INTO Items VALUES (404, 7, 3);

-- create view 1 : OrdersTotalByMonth
SELECT YEAR(date) AS year, MONTH(date) AS month, FLOOR(SUM(qtt = price)) AS total 
FROM Orders 
NATURAL JOIN Items 
NATURAL JOIN Products 
GROUP BY year, month 
ORDER BY year, month;

-- create view 2 : OrdersTotalByYear
