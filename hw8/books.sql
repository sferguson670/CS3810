CREATE DATABASE books;

USE books;

CREATE TABLE Books (
  id INT PRIMARY KEY,
  title VARCHAR(30) NOT NULL,
  author VARCHAR(30) NOT NULL
);

INSERT INTO Books VALUES (1, "The Rig", "Roger Levy");
INSERT INTO Books VALUES (2, "Annihilation", "Jeff VanderMeer");
INSERT INTO Books VALUES (3, "The Three Body Problem", "Cixin Liu");

CREATE USER 'book_admin' IDENTIFIED BY '024680';

GRANT ALL ON TABLE Books TO 'book_admin';
