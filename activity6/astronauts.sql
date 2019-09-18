-- astronauts database
-- my first database
-- created: 09/12/19
-- author: Sarah Ferguson

CREATE DATABASE astronauts;

USE astronauts;

DROP TABLE IF EXISTS Astronauts;

-- table astronauts
CREATE TABLE Astronauts (
	id			INTEGER PRIMARY KEY AUTO_INCREMENT,
	lastName	VARCHAR(25),
	firstName	VARCHAR(20),
	suffix		VARCHAR(5),
	gender		CHAR(1),
	birth		DATE,
	city		VARCHAR(20),
	state		VARCHAR(20),
	country		VARCHAR(15),
	status		VARCHAR(7),
	daysInSpace	INTEGER,
	flights		INTEGER
);

-- load data
LOAD DATA INFILE '/Users/sarahdee/Git/CS3810/activity6/astronauts.csv' INTO TABLE Astronauts
FIELDS TERMINATED BY ',' IGNORE 1 ROWS
(lastName, firstName, suffix, gender, birth, city, state, country, status, daysInSpace, flights);

-- run queries
