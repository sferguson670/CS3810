-- File activity10.sql
-- Orders database
-- Author Sarah Ferguson
-- Date 10/17/2019

-- create database orders
CREATE DATABASE orders;
USE orders;

-- create table Products
CREATE TABLE Products (
	id INT AUTO_INCREMENT PRIMARY KEY,
	descr STRING,
	price DOUBLE
);

-- create table Orders
CREATE TABLE Orders (
	number INT NOT NULL PRIMARY KEY,
	date DATE
);

-- create table Items
CREATE TABLE Items (
	number INT NOT NULL,
	id INT NOT NULL,
	qtt INT,
	FOREIGN KEY (number) REFERENCES Orders (number),
	FOREIGN KEY (id) REFERENCES Products (id)
);

-- create trigger for items
DELIMITER |
CREATE TRIGGER qttChecker
	BEFORE INSERT
	ON Items
	FOR EACH ROW
		BEGIN
			IF NEW.qtt < 1 THEN
				SET NEW.qtt = 1;
			END IF;
		END;
|
DELIMITER;

-- insert data into Products
INSERT INTO Products VALUES ("Ninja Sword", 250);
INSERT INTO Products VALUES ("Dummy", 50);
INSERT INTO Products VALUES ("Fake Blood", 5);
INSERT INTO Products VALUES ("Rubber Ducky", 1);
INSERT INTO Products VALUES ("Bathtub Soap", 3);
INSERT INTO Products VALUES ("Brazilian Coffee", 5);
INSERT INTO Products VALUES ("Running Shoes", 50);

-- insert data into Orders
INSERT INTO Orders VALUES (101, '2017-09-12');
INSERT INTO Orders VALUES (202, '2018-09-27');
INSERT INTO Orders VALUES (303, '2018-09-30');
INSERT INTO Orders VALUES (404, '2019-10-12');

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


