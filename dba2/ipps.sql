-- File: ipps.sql
-- Database: ipps
-- Project: Database Assignment #2
-- Authors: Sarah Ferguson & Ze Liu
-- Date: 10/22/2019

CREATE DATABASE ipps;

USE ipps;

DROP TABLE IF EXISTS IPPS;

CREATE TABLE DRGs (
	code INTEGER PRIMARY KEY NOT NULL,
	definition VARCHAR(60)
);

CREATE TABLE Providers (
	id INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(30) NOT NULL,
	streetAddress VARCHAR(50),
	city VARCHAR(20),
	state VARCHAR(20),
	zipCode INTEGER
);

CREATE TABLE Charges (
	totalDischarges INTEGER PRIMARY KEY NOT NULL,
	avgCoveredCharges DECIMAL(11,2),
	avgTotalPayments DECIMAL(11,2),
	avgMedicarePayments DECIMAL(11,2)
);

CREATE TABLE HospitalReferralRegions (
	code VARCHAR(5) PRIMARY KEY NOT NULL,
	description VARCHAR(30)
);

CREATE TABLE HospitalVisits (
	drgCode INTEGER NOT NULL,
	providerId INTEGER NOT NULL,
	hospitalReferralRegionCode INTEGER NOT NULL,
	totalDischarges INTEGER NOT NULL,
	PRIMARY KEY (drgCode, providerId, hospitalReferralRegionCode, totalDischarges),
	FOREIGN KEY (drgCode) REFERENCES DRGs (code),
	FOREIGN KEY (providerId) REFERENCES Providers (id),
	FOREIGN KEY (hospitalReferralRegionCode) REFERENCES HospitalReferralRegions (code),
	FOREIGN KEY (totalDischarges) REFERENCES Charges (totalDischarges)
);

CREATE USER 'ipps' IDENTIFIED BY '032423';
GRANT ALL ON TABLE DRGs TO 'ipps';
GRANT ALL ON TABLE Providers TO 'ipps';
GRANT ALL ON TABLE Charges TO 'ipps';
GRANT ALL ON TABLE HospitalReferralRegions TO 'ipps';
GRANT ALL ON TABLE HospitalVisits TO 'ipps';