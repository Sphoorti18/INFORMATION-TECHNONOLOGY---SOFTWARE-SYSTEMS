-- DDL Example
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE,
    Position VARCHAR(50)
);

-- DML Example
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, Position)
VALUES (1, 'John', 'Doe', '1980-01-15', 'Manager');

SELECT * FROM Employees;

-- DCL Example
GRANT SELECT ON Employees TO User1;

-- TCL Example
BEGIN TRANSACTION;
UPDATE Employees SET Position = 'Senior Manager' WHERE EmployeeID = 1;
COMMIT;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT FirstName, LastName, Position
FROM Employees
WHERE Position = 'Manager';
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Assuming we have another table Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'HR'), (2, 'Finance');

-- Add a foreign key to Employees table
ALTER TABLE Employees ADD DepartmentID INT;

-- Example of INNER JOIN
SELECT Employees.FirstName, Employees.LastName, Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM Employees
WHERE BirthDate > '1980-01-01' AND Position = 'Manager';
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT FirstName, LastName, BirthDate
FROM Employees
ORDER BY BirthDate DESC;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT Position, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY Position
HAVING COUNT(*) > 1;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT FirstName, LastName
FROM Employees
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'HR');
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT FirstName, LastName, Position, 
       RANK() OVER (ORDER BY BirthDate) AS RankByBirthDate
FROM Employees;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT FirstName, LastName, COALESCE(Position, 'Not Assigned') AS Position
FROM Employees;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BEGIN TRANSACTION;

UPDATE Employees SET Position = 'Manager' WHERE EmployeeID = 2;
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, Position) VALUES (3, 'Jane', 'Smith', '1990-05-20', 'Analyst');

IF @@ERROR > 0
BEGIN
    ROLLBACK;
END
ELSE
BEGIN
    COMMIT;
END;
-- :))) --
