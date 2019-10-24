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

-- view all entries
SELECT * FROM Products;

-- create table Orders
CREATE TABLE Orders (
	number INT PRIMARY KEY,
	date DATE NOT NULL
);

-- insert data into Orders
INSERT INTO Orders VALUES (101, '2017-09-12');
INSERT INTO Orders VALUES (202, '2018-09-27');
INSERT INTO Orders VALUES (303, '2018-09-30');
INSERT INTO Orders VALUES (404, '2018-10-12');

-- view all entries
SELECT * FROM Orders;

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

-- view all entries
SELECT * FROM Items;

-- create view 1 : OrdersTotalByMonth
CREATE VIEW OrdersTotalByMonth AS SELECT YEAR(date) AS Year, MONTH(date) AS Month, FLOOR(SUM(qtt*price)) AS Total
FROM Orders
NATURAL JOIN Items
NATURAL JOIN Products
GROUP BY year, month
ORDER BY year, month;

SELECT * FROM OrdersTotalByMonth;

-- create view 2 : OrdersTotalByYear
CREATE VIEW OrdersTotalByYear AS SELECT YEAR(date) AS Year, FLOOR(SUM(qtt*price)) AS Total
FROM Orders
NATURAL JOIN Items
NATURAL JOIN Products
GROUP BY year
ORDER BY year;

SELECT * FROM OrdersTotalByYear;

-- lists all the views
SHOW FULL TABLES IN orders WHERE TABLE_TYPE LIKE 'VIEW';
SHOW TABLES;

-- challenge 1: modify table Products by adding a column named 'cond' that describes the condition of the product, which can be 'new' or 'used'; have the attribute default ot 'new' IF not informed (hint: use DEFAULT); create a trigger to check if the informed value for the attribute is 'new' or 'used', having the trigger set the value to 'new' if informed value is different

ALTER TABLE Products ADD COLUMN cond VARCHAR(4) DEFAULT 'new';

-- make sure the new column is added
DESC Products;

DELIMITER |
CREATE TRIGGER product_cond_default
	BEFORE INSERT
	ON Products
	FOR EACH ROW
		BEGIN
		IF NEW.cond <> 'new' AND NEW.cond <> 'used' THEN
			SET NEW.cond = 'new';
			END IF;
		END;
|
DELIMITER;

-- try to insert the following product and make sure the condition is set to 'new' instead of 'fair'
INSERT INTO Products (descr, price, cond) VALUES ('Leather Coat', 350, 'fair');

-- try to insert the following product and make sure the condition remains 'used'
INSERT INTO Products (descr, price, cond) VALUES ('Laptop Computer', 450, 'used');

-- view all entries
SELECT * FROM Products;

-- challenge 2: create another view called OrdersTotalCurrentYear that is similar to OrdersTotalByMonth but only shows the current year
CREATE VIEW OrdersTotalCurrentYear AS SELECT YEAR(date) AS Year, MONTH(date) AS Month, FLOOR(SUM(qtt*price)) AS Total
FROM Orders
NATURAL JOIN Items
NATURAL JOIN Products
GROUP BY year, month HAVING year = YEAR(CURDATE())
ORDER BY year, month;

SELECT * FROM OrdersTotalCurrentYear;

-- unfortunately, this view is not going to show any rows because there aren't any items sold in 2019; replace year with 2018
DROP VIEW OrdersTotalCurrentYear;

CREATE VIEW OrdersTotalCurrentYear AS SELECT YEAR(date) AS Year, MONTH(date) AS Month, FLOOR(SUM(qtt*price)) AS Total
FROM Orders
NATURAL JOIN Items
NATURAL JOIN Products
GROUP BY year, month HAVING year = 2018
ORDER BY year, month;

SELECT * FROM OrdersTotalCurrentYear;