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
-- A) the total number of astronauts
SELECT COUNT(*) AS Total FROM Astronauts;
-- B) the total number of American astronauts
SELECT COUNT(*) AS Total FROM Astronauts WHERE country = "USA";
-- C) the list of nationalities of all astronauts in alphabetical order
SELECT DISTINCT country FROM Astronauts ORDER BY country;
-- D) all astronaut names ordered by last name (use the format Last Name, First Name, Suffix)
SELECT CONCAT (lastName, ",", firstName) As Name FROM Astronauts ORDER BY lastName, firstName;
-- E) the total number of astronauts by gender
SELECT gender AS Gender, COUNT(gender) AS Total FROM Astronauts GROUP BY gender;
-- F) the total number of female astronauts that are still active
SELECT COUNT(*) AS Total FROM Astronauts WHERE gender = "F" AND status = "Active";
-- G) the total number of American female astronauts that are still active
SELECT COUNT(*) AS Total FROM Astronauts WHERE gender = "F" AND status = "Active" AND country = "USA";
-- H) the list of all American female astronauts that are still active ordered by last name
SELECT CONCAT(lastName, ",", firstName) AS Name FROM Astronauts WHERE gender = "F" AND status = "Active" AND country = "USA" ORDER BY lastName;
-- I) the list of Chinese astronauts, displaying only their names and ages 
SELECT CONCAT(lastName, ",", firstName) AS Name, TIMESTAMPDIFF(YEAR, birth, CURDATE()) AS age FROM Astronauts WHERE country = "China" ORDER BY age DESC;
-- J) the total number of astronauts by country
SELECT country AS Country, COUNT(*) AS Total FROM Astronauts GROUP BY country ORDER BY country;
-- K) the total number of American astronauts per state ordered by the totals in descendent order
SELECT state AS State, COUNT(*) AS Total FROM Astronauts WHERE country = "USA" GROUP BY state ORDER BY Total DESC;
-- L) the total number of astronauts by statuses (i.e., active or retired)
SELECT status AS Status, COUNT(*) AS Total FROM Astronauts GROUP BY status ORDER BY status;
-- M) name and age of all non-American astronauts in alphabetical order
SELECT CONCAT(lastName, ",", firstName) AS Name, TIMESTAMPDIFF(YEAR, birth, CURDATE()) AS age FROM Astronauts WHERE country != "USA" ORDER BY age DESC;
-- N) the average age of all American astronauts that are still active
SELECT AVG(TIMESTAMPDIFF(YEAR, birth, CURDATE())) AS age FROM Astronauts WHERE country = "USA" AND status = "Active" ORDER BY age DESC;