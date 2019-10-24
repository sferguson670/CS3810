-- File activty12.sql
-- Database 'sample'
-- Author Sarah Ferguson
-- Date 10/24/2019

CREATE DATABASE sample;

USE sample;

CREATE TABLE Sample (
	id INT NOT NULL PRIMARY KEY,
	rnd INT NOT NULL
);

-- replace ? by 1,2,3,or 4 depending which file you want to load
LOAD DATA INFILE 'sample1.csv' INTO TABLE Sample FIELDS TERMINATED BY ',';
