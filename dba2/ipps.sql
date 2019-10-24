-- File: ipps.sql
-- Database: ipps
-- Project: Database Assignment #2
-- Authors: Sarah Ferguson & Ze Liu
-- Date: 10/22/2019

CREATE DATABASE ipps;

USE ipps;

DROP TABLE IF EXISTS IPPS;

CREATE TABLE DRGs (
	code INTEGER PRIMARY KEY,
	definition VARCHAR(30),
);

CREATE TABLE Providers (
	id INTEGER PRIMARY KEY,
	name VARCHAR(30),
	streetAddress VARCHAR(30),
	city VARCHAR(30),
	state VARCHAR(30),
	zipCode VARCHAR(30),
);

CREATE TABLE Charges (
	totalDischarges INTEGER PRIMARY KEY,
	avgCoveredCharges DOUBLE,
	avgTotalPayments DOUBLE,
	avgMedicarePayments DOUBLE
);

CREATE TABLE HospitalReferralRegions (
	code INTEGER PRIMARY KEY,
	description VARCHAR(30)
);

CREATE TABLE HospitalVisits (
	drgCode INTEGER PRIMARY KEY,
	FOREIGN KEY (drgCode) REFERENCES DRGs (code),
	providerId INTEGER PRIMARY KEY,
	FOREIGN KEY (providerId) REFERENCES Providers (id),
	hospitalReferralRegionCode INTEGER PRIMARY KEY,
	FOREIGN KEY (hospitalReferralRegionCode) REFERENCES HospitalReferralRegions (code)
	totalDischarges INTEGER PRIMARY KEY,
	FOREIGN KEY (totalDischarges) REFERENCES Charges (totalDischarges)
);

CREATE USER 'test_user' IDENTIFIED BY '032423';
GRANT ALL ON TABLE ____ TO 'test_user';