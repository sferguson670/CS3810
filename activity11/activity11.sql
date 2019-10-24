-- File activty11.sql
-- Music database
-- Author Sarah Ferguson
-- Date 10/22/2019

CREATE DATABASE music;

USE music;

CREATE TABLE Albums (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(30) NOT NULL,
  artist VARCHAR(30) NOT NULL,
  year INT NOT NULL
);

DESC Albums;

CREATE TABLE Tracks (
  id INT NOT NULL,
  num INT NOT NULL,
  name VARCHAR(30) NOT NULL,
  PRIMARY KEY (id, num),
  FOREIGN KEY (id) REFERENCES Albums (id)
);

DESC Tracks;

-- enable the following configuration setting
SET GLOBAL log_bin_trust_function_creators = 1;

-- create a function called check_year that accepts an integer and checks if the given value is >= 1950, returning the value if valid or raising an exception otherwise
DELIMITER |
CREATE FUNCTION check_year(year INT) RETURNS INT
BEGIN
	DECLARE result INT;
	IF year >= 1950 THEN
		SET result = year;
	ELSE
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'You cannot add an album with year < 1950!';
	END IF;
	RETURN (result);
END;
|
DELIMITER;

-- insert data into Albums
-- try to insert an album that has an invalid year
INSERT INTO Albums (title, artist, year) VALUES ('Roots', 'Sepultura', check_year(1925));

-- now insert the following two albums
INSERT INTO Albums (title, artist, year) VALUES ('Roots', 'Sepultura', check_year(1996));
INSERT INTO Albums (title, artist, year) VALUES ('Morbid Visions', 'Sepultura', check_year(1986));

-- view data in Albums
SELECT * FROM Albums;

-- insert data into Tracks
INSERT INTO Tracks VALUES (1, 1, 'Roots Bloody Roots');
INSERT INTO Tracks VALUES (1, 2, 'Attitude');
INSERT INTO Tracks VALUES (1, 3, 'Ratamahatta');
INSERT INTO Tracks VALUES (2, 1, 'Morbid Visions');
INSERT INTO Tracks VALUES (2, 2, 'Mayhem');

-- view data in Tracks
SELECT * FROM Tracks;

-- create a procedure called number_albums that shows the number of albums of a given artist

-- call procedure
CALL number_albums('Sepultura');

-- create a procedure called albums_number_tracks that shows the year, title and number of tracks of each album of a given artist sorted by year and title

-- call procedure
CALL albums_number_tracks('Sepultura');