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
LOAD DATA INFILE 'sample?.csv' INTO TABLE Sample FIELDS TERMINATED BY ',';

-- query before indexing
SELECT * FROM Sample WHERE rnd = 500;

-- index commands
CREATE INDEX rnd ON Sample(rnd);

-- query after indexing
SELECT * FROM Sample WHERE rnd = 500;

-- make sure to drop the index before timing a new sample
DROP INDEX rnd ON Sample;