CREATE DATABASE ipps;

USE ipps;

DROP TABLE IF EXISTS IPPS;



CREATE TABLE Provide(
    id    INTEGER PRIMARY KEY, 
    name  VARCHAR(20),
    address VARCHAR(50),
    city   VARCHAR(15),
    state VARCHAR(20),
    zip   INTEGER  
);
CREATE TABLE Average(
    total   INTEGER PRIMARY KEY, 
    coverA INTEGER,
    totalA INTEGER,
    medicareA   INTEGER
);
CREATE TABLE DRG (
    code       INTEGER PRIMARY KEY,
    desc       VARCHAR(60),
    FOREIGN KEY (id) REFERENCES Provide (id),
    hospitalSi  VARCHAR(2),
    hospitalSd  VARCHAR(20),
    FOREIGN KEY (total) REFERENCES Average (total)
);

    

