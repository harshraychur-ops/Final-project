CREATE DATABASE UniversityDB;
USE UniversityDB;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    BirthDate DATE,
    EnrollmentDate DATE
);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    DepartmentID INT,
    Credits INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

INSERT INTO Students VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');

INSERT INTO Instructors VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2);

INSERT INTO Courses VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);

INSERT INTO Enrollments VALUES
(1, 1, 101),
(2, 1, 102),
(3, 2, 101);

INSERT INTO Students VALUES
(3, 'Robert', 'Miller', 'robert.miller@email.com', '2001-03-20', '2023-01-10');

SELECT * FROM Students;

UPDATE Students
SET Email = 'john.new@email.com'
WHERE StudentID = 1;

DELETE FROM Students WHERE StudentID = 3;

SELECT * FROM Students
WHERE EnrollmentDate > '2022-01-01';

SELECT * FROM Courses
WHERE DepartmentID = 2
LIMIT 5;

SELECT C.CourseName, COUNT(E.StudentID) AS TotalStudents
FROM Enrollments E
JOIN Courses C ON E.CourseID = C.CourseID
GROUP BY C.CourseID
HAVING TotalStudents > 5;

SELECT s.StudentID, s.FirstName, s.LastName
FROM Students s
WHERE s.StudentID IN (
    SELECT StudentID FROM Enrollments WHERE CourseID = 101
)
AND s.StudentID IN (
    SELECT StudentID FROM Enrollments WHERE CourseID = 102
);

SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IN (101, 102);

SELECT AVG(Credits) AS AverageCredits FROM Courses;

ALTER TABLE Instructors ADD Salary INT;

UPDATE Instructors SET Salary = 50000 WHERE InstructorID = 1;
UPDATE Instructors SET Salary = 60000 WHERE InstructorID = 2;

SELECT MAX(Salary) FROM Instructors
WHERE DepartmentID = 1;




SELECT d.DepartmentName, COUNT(e.StudentID) AS TotalStudents
FROM Departments d
LEFT JOIN Courses c ON d.DepartmentID = c.DepartmentID
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY d.DepartmentID;





SELECT s.FirstName, s.LastName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;





SELECT s.FirstName, s.LastName, c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID;