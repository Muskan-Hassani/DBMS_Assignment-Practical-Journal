-- =========================================
-- DATABASE & TABLE CREATION (DDL)
-- =========================================

-- Create Database
CREATE DATABASE BankDB;
USE BankDB;

-- Create Table
CREATE TABLE AccountDetails (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    CurrentBalance DECIMAL(10,2)
);

-- Insert Sample Records
INSERT INTO AccountDetails (Name, Age, Gender, CurrentBalance) VALUES
('Ram', 25, 'Male', 5000.00),
('Sana', 27, 'Female', 7500.00),
('John', 30, 'Male', 6200.50),
('Peter', 28, 'Male', 3000.00),
('Neha', 26, 'Female', 8200.75);

-- Alter Table Examples
ALTER TABLE AccountDetails ADD Email VARCHAR(100);
ALTER TABLE AccountDetails MODIFY Age VARCHAR(3);
ALTER TABLE AccountDetails DROP COLUMN Email;

-- Truncate Table Example (removes data but keeps structure)
-- TRUNCATE TABLE AccountDetails;

-- Drop Table Example
-- DROP TABLE AccountDetails;

-- Drop Database Example
-- DROP DATABASE BankDB;

-- =========================================
-- DML (Insert / Update / Delete)
-- =========================================

-- Insert More Data
INSERT INTO AccountDetails (Name, Age, Gender, CurrentBalance) VALUES
('Karan', 29, 'Male', 4500.00),
('Anita', 24, 'Female', 9100.00),
('Vikas', 31, 'Male', 7000.00);

-- Update Record
UPDATE AccountDetails
SET CurrentBalance = 10000
WHERE Name = 'Ram';

-- Delete Record
DELETE FROM AccountDetails
WHERE Name = 'Peter';

-- =========================================
-- DQL (Select Queries)
-- =========================================

-- Select All Records
SELECT * FROM AccountDetails;

-- Select Specific Columns
SELECT Name, CurrentBalance FROM AccountDetails;

-- Select with Condition
SELECT * FROM AccountDetails
WHERE CurrentBalance > 6000;

-- Select with Ordering
SELECT * FROM AccountDetails
ORDER BY CurrentBalance DESC;

-- =========================================
-- TCL (Transaction Control Language)
-- =========================================

-- Commit Example
START TRANSACTION;
UPDATE AccountDetails
SET CurrentBalance = CurrentBalance - 500
WHERE Name = 'Sana';
COMMIT;

-- Rollback Example
START TRANSACTION;
UPDATE AccountDetails
SET CurrentBalance = CurrentBalance - 1000
WHERE Name = 'John';
ROLLBACK;

-- Savepoint Example
START TRANSACTION;
SAVEPOINT BeforeUpdate;
UPDATE AccountDetails
SET CurrentBalance = 12000
WHERE Name = 'Neha';
ROLLBACK TO BeforeUpdate;

-- =========================================
-- DCL (Data Control Language)
-- =========================================

-- Grant privilege (requires admin/root)
GRANT SELECT ON BankDB.AccountDetails
TO 'student'@'localhost';

-- Revoke privilege (requires admin/root)
REVOKE SELECT ON BankDB.AccountDetails
FROM 'student'@'localhost';
