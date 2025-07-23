-- ============================================================================
-- COLLEGE DATABASE PROJECT
-- ============================================================================
-- Database: CollegeDB
-- Description: Complete college management system with tables, constraints, 
--              sample data, views, and role-based access control
-- ============================================================================

-- Step 1: Create Database
CREATE DATABASE CollegeDB;
GO

USE CollegeDB;
GO

-- ============================================================================
-- STEP 2: CREATE TABLES
-- ============================================================================

-- Create Categories table 
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    DescriptionCat NVARCHAR(255)
);
GO

-- Create Department table 
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Budget MONEY NOT NULL CHECK (Budget >= 0),
    StartDate DATE NOT NULL,
    Administrator INT NULL
);
GO

-- Create Person table 
CREATE TABLE Person (
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    HireDate DATE NULL,
    EnrollmentDate DATE NULL,
    Discriminator NVARCHAR(50) NOT NULL CHECK (Discriminator IN ('Student', 'Instructor'))
);
GO

-- Create Course table
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Credits INT NOT NULL CHECK (Credits > 0 AND Credits <= 6),
    DepartmentID INT NOT NULL,
    CategoryID INT NULL
);
GO

-- Create OnsiteCourse table
CREATE TABLE OnsiteCourse (
    CourseID INT PRIMARY KEY,
    Location NVARCHAR(100) NOT NULL,
    Days NVARCHAR(50) NOT NULL,
    Time TIME NOT NULL
);
GO

-- Create OnlineCourse table
CREATE TABLE OnlineCourse (
    CourseID INT PRIMARY KEY,
    URL NVARCHAR(200) NOT NULL
);
GO

-- Create CourseInstructor junction table
CREATE TABLE CourseInstructor (
    CourseID INT NOT NULL,
    PersonID INT NOT NULL,
    PRIMARY KEY (CourseID, PersonID)
);
GO

-- Create OfficeAssignment table
CREATE TABLE OfficeAssignment (
    InstructorID INT PRIMARY KEY,
    Location NVARCHAR(100) NOT NULL
);
GO

-- Create StudentGrade table
CREATE TABLE StudentGrade (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL,
    StudentID INT NOT NULL,
    Grade DECIMAL(3,2) CHECK (Grade >= 0 AND Grade <= 4.0)
);
GO

-- ============================================================================
-- STEP 3: ADD FOREIGN KEY CONSTRAINTS
-- ============================================================================

-- Course references to Department and Category
ALTER TABLE Course
ADD CONSTRAINT FK_Course_Department
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);
GO

ALTER TABLE Course
ADD CONSTRAINT FK_Course_Category
FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID);
GO

-- OnsiteCourse reference to Course
ALTER TABLE OnsiteCourse
ADD CONSTRAINT FK_OnsiteCourse_Course
FOREIGN KEY (CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE;
GO

-- OnlineCourse reference to Course
ALTER TABLE OnlineCourse
ADD CONSTRAINT FK_OnlineCourse_Course
FOREIGN KEY (CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE;
GO

-- CourseInstructor many-to-many relationships
ALTER TABLE CourseInstructor
ADD CONSTRAINT FK_CourseInstructor_Course
FOREIGN KEY (CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE;
GO

ALTER TABLE CourseInstructor
ADD CONSTRAINT FK_CourseInstructor_Person
FOREIGN KEY (PersonID) REFERENCES Person(PersonID) ON DELETE CASCADE;
GO

-- OfficeAssignment reference to Person (Instructor)
ALTER TABLE OfficeAssignment
ADD CONSTRAINT FK_OfficeAssignment_Person
FOREIGN KEY (InstructorID) REFERENCES Person(PersonID) ON DELETE CASCADE;
GO

-- StudentGrade references to Course and Person (Student)
ALTER TABLE StudentGrade
ADD CONSTRAINT FK_StudentGrade_Course
FOREIGN KEY (CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE;
GO

ALTER TABLE StudentGrade
ADD CONSTRAINT FK_StudentGrade_Student
FOREIGN KEY (StudentID) REFERENCES Person(PersonID) ON DELETE CASCADE;
GO

-- ============================================================================
-- STEP 4: INSERT SAMPLE DATA 
-- ============================================================================

-- Insert Categories FIRST 
INSERT INTO Category (CategoryName, DescriptionCat) VALUES
('STEM', 'Science, Technology, Engineering & Math'),
('Humanities', 'Languages and Arts'),
('Business', 'Business and Management'),
('Law', 'Legal Studies'),
('Arts', 'Creative Arts and Design'),
('Social Sciences', 'Social and Behavioral Sciences');
GO

-- Insert Departments WITHOUT administrators 
INSERT INTO Department (DepartmentID, Name, Budget, StartDate, Administrator) VALUES
(1, 'Engineering', 400000, '2015-08-01', NULL),
(2, 'Business', 200000, '2016-09-15', NULL),
(3, 'Law', 150000, '2017-07-10', NULL),
(4, 'Arts', 180000, '2014-03-20', NULL),
(5, 'Computer Science', 250000, '2018-11-05', NULL),
(6, 'Sciences', 220000, '2013-01-25', NULL);
GO

-- Insert People (Instructors first, then Students)
INSERT INTO Person (FirstName, LastName, HireDate, EnrollmentDate, Discriminator) VALUES
('Mohamed', 'Saeed', '2010-05-01', NULL, 'Instructor'),
('Laila', 'Farouk', '2012-09-15', NULL, 'Instructor'),
('Tarek', 'Mostafa', '2013-08-22', NULL, 'Instructor'),
('Ayman', 'Hassan', '2015-06-20', NULL, 'Instructor'),
('Nadia', 'Khalil', '2014-03-10', NULL, 'Instructor'),
('Amr', 'Elsayed', '2016-11-25', NULL, 'Instructor');
GO

-- Insert Students 
INSERT INTO Person (FirstName, LastName, HireDate, EnrollmentDate, Discriminator) VALUES
('Omar', 'Khalil', NULL, '2022-09-01', 'Student'),
('Mona', 'Hassan', NULL, '2021-09-10', 'Student'),
('Sherif', 'Samir', NULL, '2023-02-12', 'Student'),
('Alia', 'Farghaly', NULL, '2020-09-08', 'Student'),
('Yasmine', 'Elsheikh', NULL, '2022-09-15', 'Student'),
('Karim', 'Mahrous', NULL, '2021-10-01', 'Student'),
('Sara', 'Abdel Rahman', NULL, '2023-01-15', 'Student'),
('Ahmed', 'Mansour', NULL, '2020-09-05', 'Student'),
('Dina', 'Fouad', NULL, '2022-02-20', 'Student'),
('Hossam', 'Ezz', NULL, '2021-08-30', 'Student');
GO

-- NOW add the Department Administrator constraint and update data
ALTER TABLE Department
ADD CONSTRAINT FK_Department_Administrator
FOREIGN KEY (Administrator) REFERENCES Person(PersonID);
GO

-- Update Department administrators now that Person records exist
UPDATE Department SET Administrator = 1 WHERE DepartmentID = 1;
UPDATE Department SET Administrator = 2 WHERE DepartmentID = 2;
UPDATE Department SET Administrator = 3 WHERE DepartmentID = 3;
UPDATE Department SET Administrator = 4 WHERE DepartmentID = 4;
UPDATE Department SET Administrator = 1 WHERE DepartmentID = 5;
UPDATE Department SET Administrator = 2 WHERE DepartmentID = 6;
GO

-- Insert Courses 
INSERT INTO Course (CourseID, Title, Credits, DepartmentID, CategoryID) VALUES
(1001, 'Data Structures', 3, 5, 1),
(1002, 'Business Management', 3, 2, 3),
(1003, 'Criminal Law', 4, 3, 4),
(1004, 'Organic Chemistry', 4, 6, 1),
(1005, 'Introduction to Engineering', 3, 1, 1),
(1006, 'Modern Art', 2, 4, 5),
(1007, 'Database Systems', 4, 5, 1),
(1008, 'Marketing Principles', 3, 2, 3),
(1009, 'Constitutional Law', 4, 3, 4),
(1010, 'Physics I', 4, 6, 1);
GO

-- Insert Course Types (Onsite) 
INSERT INTO OnsiteCourse (CourseID, Location, Days, Time) VALUES
(1001, 'CS Building - Room 201', 'Sun, Tue', '09:00'),
(1003, 'Law Hall 3', 'Mon, Wed', '10:00'),
(1005, 'Eng Lab A1', 'Tue, Thu', '09:30'),
(1007, 'CS Building - Room 105', 'Sun, Thu', '11:00'),
(1009, 'Law Hall 1', 'Mon, Wed', '13:00'),
(1010, 'Science Lab B2', 'Tue, Thu', '14:00');
GO

-- Insert Course Types (Online) 
INSERT INTO OnlineCourse (CourseID, URL) VALUES
(1002, 'https://college.edu/business-management'),
(1004, 'https://college.edu/organic-chemistry'),
(1006, 'https://college.edu/modern-art'),
(1008, 'https://college.edu/marketing-principles');
GO

-- Assign Instructors to Courses 
INSERT INTO CourseInstructor (CourseID, PersonID) VALUES
(1001, 1), (1002, 2), (1003, 3), (1004, 4), (1005, 5), (1006, 6),
(1007, 1), (1008, 2), (1009, 3), (1010, 4);
GO

-- Assign Office Locations
INSERT INTO OfficeAssignment (InstructorID, Location) VALUES
(1, 'Office E101'),
(2, 'Office B202'),
(3, 'Office L303'),
(4, 'Office S404'),
(5, 'Office E105'),
(6, 'Office A201');
GO

-- Insert Student Grades 
INSERT INTO StudentGrade (CourseID, StudentID, Grade) VALUES
(1001, 7, 3.7), (1002, 8, 3.4), (1003, 9, 2.9), (1004, 10, 3.8),
(1005, 11, 3.0), (1006, 12, 2.5), (1007, 13, 3.9), (1008, 14, 3.2),
(1009, 15, 3.6), (1010, 16, 2.8), (1001, 8, 3.5), (1002, 9, 3.1),
(1003, 10, 3.3), (1004, 11, 3.7), (1005, 12, 2.9), (1006, 13, 3.4);
GO

-- ============================================================================
-- STEP 5: CREATE VIEWS
-- ============================================================================

-- View for Course Details 
CREATE VIEW vw_CourseDetails AS
SELECT 
    c.CourseID, 
    c.Title, 
    d.Name AS Department, 
    cat.CategoryName, 
    c.Credits,
    CASE 
        WHEN oc.CourseID IS NOT NULL THEN 'Online'
        WHEN osc.CourseID IS NOT NULL THEN 'Onsite'
        ELSE 'Not Specified'
    END AS CourseType
FROM Course c
JOIN Department d ON c.DepartmentID = d.DepartmentID
LEFT JOIN Category cat ON c.CategoryID = cat.CategoryID
LEFT JOIN OnlineCourse oc ON c.CourseID = oc.CourseID
LEFT JOIN OnsiteCourse osc ON c.CourseID = osc.CourseID;
GO

-- View for Student Summary 
CREATE VIEW vw_StudentSummary AS
SELECT 
    p.PersonID, 
    p.FirstName, 
    p.LastName,
    COUNT(sg.EnrollmentID) AS TotalCourses,
    AVG(sg.Grade) AS GPA,
    SUM(c.Credits) AS TotalCredits
FROM Person p
LEFT JOIN StudentGrade sg ON p.PersonID = sg.StudentID
LEFT JOIN Course c ON sg.CourseID = c.CourseID
WHERE p.Discriminator = 'Student'
GROUP BY p.PersonID, p.FirstName, p.LastName;
GO

-- View for Instructor Workload
CREATE VIEW vw_InstructorWorkload AS
SELECT 
    p.PersonID,
    p.FirstName,
    p.LastName,
    COUNT(ci.CourseID) AS CoursesTeaching,
    SUM(c.Credits) AS TotalCredits,
    oa.Location AS OfficeLocation
FROM Person p
LEFT JOIN CourseInstructor ci ON p.PersonID = ci.PersonID
LEFT JOIN Course c ON ci.CourseID = c.CourseID
LEFT JOIN OfficeAssignment oa ON p.PersonID = oa.InstructorID
WHERE p.Discriminator = 'Instructor'
GROUP BY p.PersonID, p.FirstName, p.LastName, oa.Location;
GO

-- View for Department Statistics
CREATE VIEW vw_DepartmentStats AS
SELECT 
    d.DepartmentID,
    d.Name AS DepartmentName,
    d.Budget,
    COUNT(c.CourseID) AS TotalCourses,
    COUNT(DISTINCT ci.PersonID) AS TotalInstructors,
    AVG(sg.Grade) AS AvgGPA
FROM Department d
LEFT JOIN Course c ON d.DepartmentID = c.DepartmentID
LEFT JOIN CourseInstructor ci ON c.CourseID = ci.CourseID
LEFT JOIN StudentGrade sg ON c.CourseID = sg.CourseID
GROUP BY d.DepartmentID, d.Name, d.Budget;
GO

-- ============================================================================
-- STEP 6: ANALYTICAL QUERIES
-- ============================================================================

-- Query 1: Retrieve all courses with department and category information
SELECT * FROM vw_CourseDetails ORDER BY Department, Title;
GO

-- Query 2: Find top 5 students by GPA
SELECT TOP 5 PersonID, FirstName, LastName, GPA, TotalCourses 
FROM vw_StudentSummary 
WHERE GPA IS NOT NULL
ORDER BY GPA DESC;
GO

-- Query 3: Calculate average grade for each course
SELECT 
    c.CourseID, 
    c.Title, 
    AVG(sg.Grade) AS AverageGrade,
    COUNT(sg.StudentID) AS EnrolledStudents
FROM Course c
LEFT JOIN StudentGrade sg ON c.CourseID = sg.CourseID
GROUP BY c.CourseID, c.Title
ORDER BY AverageGrade DESC;
GO

-- Query 4: List instructors with their teaching load
SELECT * FROM vw_InstructorWorkload ORDER BY CoursesTeaching DESC;
GO

-- Query 5: Find courses with no enrolled students
SELECT c.CourseID, c.Title, d.Name AS Department
FROM Course c
JOIN Department d ON c.DepartmentID = d.DepartmentID
LEFT JOIN StudentGrade sg ON c.CourseID = sg.CourseID
WHERE sg.CourseID IS NULL;
GO

-- Query 6: Department budget utilization and performance
SELECT * FROM vw_DepartmentStats ORDER BY Budget DESC;
GO

-- Query 7: Students enrolled in multiple courses
SELECT 
    p.PersonID,
    p.FirstName,
    p.LastName,
    COUNT(sg.CourseID) AS CourseCount
FROM Person p
JOIN StudentGrade sg ON p.PersonID = sg.StudentID
WHERE p.Discriminator = 'Student'
GROUP BY p.PersonID, p.FirstName, p.LastName
HAVING COUNT(sg.CourseID) > 1
ORDER BY CourseCount DESC;
GO

-- Query 8: Find courses taught by multiple instructors
SELECT 
    c.CourseID,
    c.Title,
    COUNT(ci.PersonID) AS InstructorCount
FROM Course c
JOIN CourseInstructor ci ON c.CourseID = ci.CourseID
GROUP BY c.CourseID, c.Title
HAVING COUNT(ci.PersonID) > 1;
GO

-- ============================================================================
-- STEP 7: ROLE-BASED ACCESS CONTROL (RBAC) 
-- ============================================================================

-- Create logins with error handling
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'RegistrarUser')
    CREATE LOGIN RegistrarUser WITH PASSWORD = 'Registrar@2025';
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'InstructorUser')
    CREATE LOGIN InstructorUser WITH PASSWORD = 'Instructor@2025';
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'StudentUser')
    CREATE LOGIN StudentUser WITH PASSWORD = 'Student@2025';
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'AnalystUser')
    CREATE LOGIN AnalystUser WITH PASSWORD = 'Analyst@2025';
GO

-- Create users in the database
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'RegistrarUser')
    CREATE USER RegistrarUser FOR LOGIN RegistrarUser;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'InstructorUser')
    CREATE USER InstructorUser FOR LOGIN InstructorUser;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'StudentUser')
    CREATE USER StudentUser FOR LOGIN StudentUser;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'AnalystUser')
    CREATE USER AnalystUser FOR LOGIN AnalystUser;
GO

-- Create roles
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'RegistrarRole')
    CREATE ROLE RegistrarRole;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'InstructorRole')
    CREATE ROLE InstructorRole;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'StudentRole')
    CREATE ROLE StudentRole;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'AnalystRole')
    CREATE ROLE AnalystRole;
GO

-- Assign users to roles
EXEC sp_addrolemember 'RegistrarRole', 'RegistrarUser';
GO

EXEC sp_addrolemember 'InstructorRole', 'InstructorUser';
GO

EXEC sp_addrolemember 'StudentRole', 'StudentUser';
GO

EXEC sp_addrolemember 'AnalystRole', 'AnalystUser';
GO

-- Grant permissions to roles
GRANT SELECT, INSERT, UPDATE, DELETE ON Person TO RegistrarRole;
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON Course TO RegistrarRole;
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON StudentGrade TO RegistrarRole;
GO

GRANT SELECT ON Department TO RegistrarRole;
GO

GRANT SELECT ON vw_StudentSummary TO RegistrarRole;
GO

GRANT SELECT ON vw_CourseDetails TO RegistrarRole;
GO

GRANT SELECT ON Course TO InstructorRole;
GO

GRANT SELECT ON Person TO InstructorRole;
GO

GRANT SELECT, UPDATE ON StudentGrade TO InstructorRole;
GO

GRANT SELECT ON vw_CourseDetails TO InstructorRole;
GO

GRANT SELECT ON vw_InstructorWorkload TO InstructorRole;
GO

GRANT SELECT ON vw_CourseDetails TO StudentRole;
GO

GRANT SELECT ON vw_StudentSummary TO StudentRole;
GO

GRANT SELECT ON vw_CourseDetails TO AnalystRole;
GO

GRANT SELECT ON vw_StudentSummary TO AnalystRole;
GO

GRANT SELECT ON vw_InstructorWorkload TO AnalystRole;
GO

GRANT SELECT ON vw_DepartmentStats TO AnalystRole;
GO

-- ============================================================================
-- STEP 8: STORED PROCEDURES
-- ============================================================================

-- Procedure to enroll student in a course
CREATE PROCEDURE sp_EnrollStudent
    @StudentID INT,
    @CourseID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if student exists and is actually a student
    IF NOT EXISTS (SELECT 1 FROM Person WHERE PersonID = @StudentID AND Discriminator = 'Student')
    BEGIN
        RAISERROR('Invalid Student ID', 16, 1);
        RETURN;
    END
    
    -- Check if course exists
    IF NOT EXISTS (SELECT 1 FROM Course WHERE CourseID = @CourseID)
    BEGIN
        RAISERROR('Invalid Course ID', 16, 1);
        RETURN;
    END
    
    -- Check if student is already enrolled
    IF EXISTS (SELECT 1 FROM StudentGrade WHERE StudentID = @StudentID AND CourseID = @CourseID)
    BEGIN
        RAISERROR('Student is already enrolled in this course', 16, 1);
        RETURN;
    END
    
    -- Enroll the student
    INSERT INTO StudentGrade (CourseID, StudentID, Grade)
    VALUES (@CourseID, @StudentID, NULL);
    
    PRINT 'Student enrolled successfully';
END;
GO

-- Procedure to update student grade
CREATE PROCEDURE sp_UpdateGrade
    @StudentID INT,
    @CourseID INT,
    @Grade DECIMAL(3,2)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate grade range
    IF @Grade < 0 OR @Grade > 4.0
    BEGIN
        RAISERROR('Grade must be between 0 and 4.0', 16, 1);
        RETURN;
    END
    
    -- Update the grade
    UPDATE StudentGrade
    SET Grade = @Grade
    WHERE StudentID = @StudentID AND CourseID = @CourseID;
    
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No enrollment record found for this student and course', 16, 1);
        RETURN;
    END
    
    PRINT 'Grade updated successfully';
END;
GO

-- Procedure to get student transcript
CREATE PROCEDURE sp_GetStudentTranscript
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        p.FirstName + ' ' + p.LastName AS StudentName,
        c.CourseID,
        c.Title AS CourseTitle,
        c.Credits,
        sg.Grade,
        d.Name AS Department
    FROM Person p
    JOIN StudentGrade sg ON p.PersonID = sg.StudentID
    JOIN Course c ON sg.CourseID = c.CourseID
    JOIN Department d ON c.DepartmentID = d.DepartmentID
    WHERE p.PersonID = @StudentID AND p.Discriminator = 'Student'
    ORDER BY c.Title;
END;
GO

-- ============================================================================
-- STEP 9: INDEXES FOR PERFORMANCE
-- ============================================================================

-- Create indexes for frequently queried columns
CREATE INDEX IX_Person_Discriminator ON Person(Discriminator);
GO

CREATE INDEX IX_StudentGrade_StudentID ON StudentGrade(StudentID);
GO

CREATE INDEX IX_StudentGrade_CourseID ON StudentGrade(CourseID);
GO

CREATE INDEX IX_Course_DepartmentID ON Course(DepartmentID);
GO

CREATE INDEX IX_CourseInstructor_PersonID ON CourseInstructor(PersonID);
GO

-- ============================================================================
-- STEP 10: SAMPLE USAGE AND TESTING 
-- ============================================================================

-- Test stored procedures with valid data
EXEC sp_EnrollStudent @StudentID = 7, @CourseID = 1001;
GO

EXEC sp_UpdateGrade @StudentID = 7, @CourseID = 1001, @Grade = 3.5;
GO

EXEC sp_GetStudentTranscript @StudentID = 7;
GO

-- Test views
SELECT 'Course Details' AS QueryType;
SELECT TOP 5 * FROM vw_CourseDetails;
GO

SELECT 'Student Summary' AS QueryType;
SELECT TOP 5 * FROM vw_StudentSummary WHERE GPA IS NOT NULL ORDER BY GPA DESC;
GO

SELECT 'Instructor Workload' AS QueryType;
SELECT * FROM vw_InstructorWorkload ORDER BY CoursesTeaching DESC;
GO

SELECT 'Department Statistics' AS QueryType;
SELECT * FROM vw_DepartmentStats ORDER BY TotalCourses DESC;
GO

-- ============================================================================

