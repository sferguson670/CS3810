-- File: ipps.sql
-- Database: ipps
-- Project: Database Assignment #2
-- Authors: Sarah Ferguson & Ze Liu
-- Date: 10/22/2019

CREATE DATABASE ipps;

USE ipps;

CREATE TABLE DRGs (
	code INTEGER PRIMARY KEY NOT NULL,
	definition VARCHAR(80)
);

CREATE TABLE Providers (
	id INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL,
	streetAddress VARCHAR(50),
	city VARCHAR(20),
	state VARCHAR(20),
	zipCode INTEGER
);

CREATE TABLE Charges (
    chargeId INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	totalDischarges INTEGER,
	avgCoveredCharges DECIMAL(11,2),
	avgTotalPayments DECIMAL(11,2),
	avgMedicarePayments DECIMAL(11,2)
);

CREATE TABLE HospitalReferralRegions (
	code VARCHAR(5) NOT NULL,
	description VARCHAR(30) NOT NULL PRIMARY KEY
);

CREATE TABLE HospitalVisits (
    drgCode INTEGER NOT NULL,
    providerId INTEGER NOT NULL,
    hospitalDescription VARCHAR(30) NOT NULL,
    chargeId INTEGER NOT NULL,
    PRIMARY KEY (drgCode, providerId, hospitalDescription, chargeId),
    FOREIGN KEY (drgCode) REFERENCES DRGs (code),
    FOREIGN KEY (providerId) REFERENCES Providers (id),
    FOREIGN KEY (hospitalDescription) REFERENCES HospitalReferralRegions (description),
    FOREIGN KEY (chargeId) REFERENCES Charges (chargeId)
);

CREATE USER 'ipps' IDENTIFIED BY '032423';
GRANT ALL ON TABLE DRGs TO 'ipps';
GRANT ALL ON TABLE Providers TO 'ipps';
GRANT ALL ON TABLE Charges TO 'ipps';
GRANT ALL ON TABLE HospitalReferralRegions TO 'ipps';
GRANT ALL ON TABLE HospitalVisits TO 'ipps';