-- Flowers database
-- Database Assignment #1
-- Ze Liu & Sarah Ferguson

CREATE DATABASE flowers;
USE flowers;

-- create table zones
CREATE TABLE Zones(
	id INTEGER(2) PRIMARY KEY,
	lowerTemp INTEGER(3),
	higherTemp INTEGER(3)
);

-- populate table Zones
INSERT INTO Zones VALUES(2, -50, -40);
INSERT INTO Zones VALUES(3, -40, -30);
INSERT INTO Zones VALUES(4, -30, -20);
INSERT INTO Zones VALUES(5, -20, -10);
INSERT INTO Zones VALUES(6, -10, 0);
INSERT INTO Zones VALUES(7, 0, 10);
INSERT INTO Zones VALUES(8, 10, 20);
INSERT INTO Zones VALUES(9, 20, 30);
INSERT INTO Zones VALUES(10, 30, 40);

-- create table deliveries
CREATE TABLE Deliveries(
	id INTEGER(1) PRIMARY KEY,
	categ VARCHAR(5),
	delSize DECIMAL(5,3)
);

-- populate table Deliveries
INSERT INTO Deliveries VALUES(1, 'pot', 1.500);
INSERT INTO Deliveries VALUES(2, 'pot', 2.250);
INSERT INTO Deliveries VALUES(3, 'pot', 2.625);
INSERT INTO Deliveries VALUES(4, 'pot', 4.250);
INSERT INTO Deliveries VALUES(5, 'plant', NULL);
INSERT INTO Deliveries VALUES(6, 'bulb', NULL);
INSERT INTO Deliveries VALUES(7, 'hedge', 18.000);
INSERT INTO Deliveries VALUES(8, 'shrub', 24.000);
INSERT INTO Deliveries VALUES(9, 'tree', 36.000);

-- create table FlowersInfo
CREATE TABLE FlowersInfo(
	id INTEGER(3) PRIMARY KEY,
	comName VARCHAR(30),
	latName VARCHAR(35),
	cZone INTEGER,
	hZone INTEGER,
	deliver INTEGER,
	sunNeeds VARCHAR(5)
);

-- populate table FlowersInfo
INSERT INTO FlowersInfo VALUES(101, 'Lady Fern', 'Atbyrium filix-femina', 2, 9, 5, 'SH');
INSERT INTO FlowersInfo VALUES(102, 'Pink Caladiums', 'C.x bortulanum', 10, 10, 6, 'PtoSH');
INSERT INTO FlowersInfo VALUES(103, 'Lily-of-the-Valley', 'Convallaria majalis', 2, 8, 5, 'PtoSH');
INSERT INTO FlowersInfo VALUES(105, 'Purple Liatris', 'Liatris spicata', 3, 9, 6, 'StoP');
INSERT INTO FlowersInfo VALUES(106, 'Black Eyed Susan', 'Rudbeckia fulgida var. specios', 4, 10, 2, 'StoP');
INSERT INTO FlowersInfo VALUES(107, 'Nikko ablue Hydrangea', 'Hydrangea macrophylla', 5, 9, 4, 'StoSH');
INSERT INTO FlowersInfo VALUES(108, 'Variegated Weigela', 'W. florida Variegata', 4, 9, 8, 'StoP');
INSERT INTO FlowersInfo VALUES(110, 'Lombardy Poplar', 'Populus nigra Italica', 3, 9, 9, 'S');
INSERT INTO FlowersInfo VALUES(111, 'Purple Leaf Plum Hedge', 'Prunus x cistena', 2, 8, 7, 'S');
INSERT INTO FlowersInfo VALUES(114, 'Thorndale Ivy', 'Hedera belix Thorndale', 3, 9, 1, 'StoSH');

-- queries
-- a) the total number of zones

-- b) the number of flowers per cool zone

-- c) common names of the plants that have delivery sizes less than 5

-- d) common names of the plants that require full sun (i.e., sun needs contains 'S')

-- e) all delivery category names order alphabetically (without repetition)

-- f) the exact output (note that it is order by name)

-- g) plant names that have the same hot zone as "pink Caladiums" (your solution MUST get the hot zone of "pink Caladiums" in a variable)

-- h) the total number of plants, the minimum delivery size, the maximum delivery size, and the average size based on the plants that have delivery sizes (note that the average value should be rounded using two decimals)

-- i) the Latin name of the plant that has the word 'Eyed' in its name (you must use LIKE in this query to get full credit)

-- j) the exact output (ordered by Category and then by Name)