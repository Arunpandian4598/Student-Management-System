-- Create the database
CREATE DATABASE student_management_system;

-- Select the database
USE student_management_system;

-- Verify the selected database
SELECT DATABASE();

-- Display all databases
SHOW DATABASES;

SELECT DATABASE();
 
 -- create _tables 
 
 -- ============================================
-- 1. Department Table
-- ============================================

CREATE TABLE department (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL UNIQUE,
    hod_name VARCHAR(100) NOT NULL,
    building VARCHAR(100) NOT NULL
);

-- ============================================
-- 2. Course Table
-- ============================================

CREATE TABLE course (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL UNIQUE,
    duration VARCHAR(30) NOT NULL,
    total_fee DECIMAL(10,2) NOT NULL CHECK (total_fee >= 0)
);

-- ============================================
-- 3. Teacher Table
-- ============================================

CREATE TABLE teacher (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_name VARCHAR(100) NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    qualification VARCHAR(100) NOT NULL,
    phone VARCHAR(10) UNIQUE check(phone >=9),
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10,2) CHECK (salary >= 0),
    dept_id INT NOT NULL,

    FOREIGN KEY (dept_id)
    REFERENCES department(dept_id)
);

-- ============================================
-- 4. Student Table
-- ============================================

CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    roll_no VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    dob DATE NOT NULL,
    phone VARCHAR(10) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT,
    admission_date DATE DEFAULT (CURRENT_DATE),
    dept_id INT NOT NULL,
    course_id INT NOT NULL,
    
    

    FOREIGN KEY (dept_id)
    REFERENCES department(dept_id),

    FOREIGN KEY (course_id)
    REFERENCES course(course_id)
);
 
 -- ============================================
-- 5. Subject Table
-- ============================================

CREATE TABLE subject (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_code VARCHAR(20) UNIQUE NOT NULL,
    subject_name VARCHAR(100) NOT NULL,
    semester INT NOT NULL CHECK (semester BETWEEN 1 AND 8),
    credits INT DEFAULT 4,
    teacher_id INT NOT NULL,

    FOREIGN KEY (teacher_id)
    REFERENCES teacher(teacher_id)
);
 
 
-- ============================================
-- 6. Enrollment Table
-- ============================================

CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),

    FOREIGN KEY (student_id)
    REFERENCES student(student_id),

    FOREIGN KEY (subject_id)
    REFERENCES subject(subject_id)
);

-- ============================================
-- 7. Attendance Table
-- ============================================

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('Present','Absent') DEFAULT 'Present',

    FOREIGN KEY (student_id)
    REFERENCES student(student_id),

    FOREIGN KEY (subject_id)
    REFERENCES subject(subject_id)
);

-- ============================================
-- 8. Marks Table
-- ============================================

CREATE TABLE marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    exam_type ENUM('Internal','Model','Semester') NOT NULL,
    marks INT CHECK (marks BETWEEN 0 AND 100),

    FOREIGN KEY (student_id)
    REFERENCES student(student_id),

    FOREIGN KEY (subject_id)
    REFERENCES subject(subject_id)
);

-- ============================================
-- 9. Fees Table
-- ============================================

CREATE TABLE fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    total_fee DECIMAL(10,2) NOT NULL,
    paid_amount DECIMAL(10,2) DEFAULT 0,
    due_amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Paid','Pending','Partial') DEFAULT 'Pending',
    payment_date DATE,

    FOREIGN KEY (student_id)
    REFERENCES student(student_id)
);

-- ============================================
-- 10. Users Table
-- ============================================

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('Admin','Faculty','Student') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Verify Tables 
-- ============================================

USE student_management_system;

-- ============================================
-- INSERT INTO DEPARTMENT
-- ============================================

INSERT INTO department (dept_name, hod_name, building)
VALUES
('Computer Science', 'Dr. Rajesh Kumar', 'Block A'),
('Electronics', 'Dr. Priya Sharma', 'Block B'),
('Mechanical', 'Dr. Arun Prakash', 'Block C'),
('Civil', 'Dr. Karthik Raman', 'Block D'),
('Information Technology', 'Dr. Meena Devi', 'Block E');

SELECT * FROM department;

-- ============================================
-- INSERT INTO COURSE
-- ============================================

INSERT INTO course (course_name, duration, total_fee)
VALUES
('B.Tech Computer Science', '4 Years', 250000),
('B.Tech Electronics', '4 Years', 240000),
('B.Tech Mechanical', '4 Years', 230000),
('B.Tech Civil', '4 Years', 220000),
('B.Tech Information Technology', '4 Years', 245000);

SELECT * FROM course;

-- ============================================
-- INSERT INTO TEACHER
-- ============================================

INSERT INTO teacher
(teacher_name, gender, qualification, phone, email, salary, dept_id)
VALUES
('Dr. Suresh Kumar','Male','Ph.D','9876543201','suresh@college.com',85000,1),
('Dr. Kavitha','Female','Ph.D','9876543202','kavitha@college.com',82000,1),
('Dr. Manoj','Male','Ph.D','9876543203','manoj@college.com',78000,2),
('Dr. Divya','Female','Ph.D','9876543204','divya@college.com',81000,2),
('Dr. Vignesh','Male','M.E','9876543205','vignesh@college.com',70000,3),
('Dr. Ramesh','Male','Ph.D','9876543206','ramesh@college.com',83000,4),
('Dr. Anitha','Female','M.Tech','9876543207','anitha@college.com',72000,5),
('Dr. Balaji','Male','Ph.D','9876543208','balaji@college.com',86000,5);

SELECT * FROM teacher;

-- ============================================
-- INSERT INTO STUDENT
-- ============================================

INSERT INTO student
(roll_no, first_name, last_name, gender, dob, phone, email, address, admission_date, dept_id, course_id)
VALUES
('CSE001','Arun','Kumar','Male','2005-03-15','9876500001','arun1@gmail.com','Chennai','2024-06-10',1,1),

('CSE002','Priya','Sharma','Female','2005-07-22','9876500002','priya@gmail.com','Coimbatore','2024-06-10',1,1),

('ECE001','Rahul','Verma','Male','2004-12-18','9876500003','rahul@gmail.com','Madurai','2024-06-10',2,2),

('ECE002','Sneha','Patel','Female','2005-02-28','9876500004','sneha@gmail.com','Salem','2024-06-10',2,2),

('MECH001','Karthik','Raj','Male','2004-10-05','9876500005','karthik@gmail.com','Trichy','2024-06-10',3,3),

('MECH002','Divya','Rani','Female','2005-01-30','9876500006','divya@gmail.com','Erode','2024-06-10',3,3),

('CIV001','Ajay','Singh','Male','2004-08-14','9876500007','ajay@gmail.com','Vellore','2024-06-10',4,4),

('CIV002','Nisha','Gupta','Female','2005-05-09','9876500008','nisha@gmail.com','Tirunelveli','2024-06-10',4,4),

('IT001','Vikram','Rao','Male','2004-11-25','9876500009','vikram@gmail.com','Chennai','2024-06-10',5,5),

('IT002','Anjali','Das','Female','2005-04-18','9876500010','anjali@gmail.com','Puducherry','2024-06-10',5,5);

SELECT * FROM student;

/* SELECT
    s.student_id,
    s.roll_no,
    s.first_name,
    s.last_name,
    d.dept_name,
    c.course_name
FROM student s
JOIN department d
ON s.dept_id = d.dept_id
JOIN course c
ON s.course_id = c.course_id; */



-- ============================================
-- INSERT INTO SUBJECT
-- ============================================

INSERT INTO subject
(subject_code, subject_name, semester, credits, teacher_id)
VALUES

-- Computer Science
('CS101','Programming in C',1,4,1),
('CS102','Data Structures',2,4,2),

-- Electronics
('EC101','Digital Electronics',1,4,3),
('EC102','Electronic Circuits',2,4,4),

-- Mechanical
('ME101','Engineering Mechanics',1,4,5),
('ME102','Thermodynamics',2,4,5),

-- Civil
('CE101','Engineering Drawing',1,4,6),
('CE102','Surveying',2,4,6),

-- Information Technology
('IT101','Python Programming',1,4,7),
('IT102','Database Management System',2,4,8),

-- Common Subjects
('MA101','Engineering Mathematics',1,4,1),
('PH101','Engineering Physics',1,3,2),
('CH101','Engineering Chemistry',1,3,3),
('EN101','English Communication',1,2,4),
('EV101','Environmental Science',2,2,5);

select * from subject;

-- display subject with teachers

SELECT
    s.subject_code,
    s.subject_name,
    s.semester,
    s.credits,
    t.teacher_name
FROM subject s
JOIN teacher t
ON s.teacher_id = t.teacher_id;

--  ===============
-- ============================================
-- INSERT INTO ENROLLMENT
-- ============================================

INSERT INTO enrollment
(student_id, subject_id, enrollment_date)
VALUES

-- Student 1
(1,1,'2024-06-15'),
(1,2,'2024-06-15'),
(1,11,'2024-06-15'),

-- Student 2
(2,1,'2024-06-15'),
(2,2,'2024-06-15'),
(2,12,'2024-06-15'),

-- Student 3
(3,3,'2024-06-15'),
(3,4,'2024-06-15'),
(3,13,'2024-06-15'),

-- Student 4
(4,3,'2024-06-15'),
(4,4,'2024-06-15'),
(4,14,'2024-06-15'),

-- Student 5
(5,5,'2024-06-15'),
(5,6,'2024-06-15'),
(5,15,'2024-06-15'),

-- Student 6
(6,5,'2024-06-15'),
(6,6,'2024-06-15'),
(6,11,'2024-06-15'),

-- Student 7
(7,7,'2024-06-15'),
(7,8,'2024-06-15'),
(7,12,'2024-06-15'),

-- Student 8
(8,7,'2024-06-15'),
(8,8,'2024-06-15'),
(8,13,'2024-06-15'),

-- Student 9
(9,9,'2024-06-15'),
(9,10,'2024-06-15'),
(9,14,'2024-06-15'),

-- Student 10
(10,9,'2024-06-15'),
(10,10,'2024-06-15'),
(10,15,'2024-06-15');

SELECT * FROM enrollment;


-- ============================================
-- INSERT INTO ATTENDANCE
-- ============================================

INSERT INTO attendance
(student_id, subject_id, attendance_date, status)
VALUES

-- Student 1
(1,1,'2024-07-01','Present'),
(1,2,'2024-07-01','Present'),
(1,11,'2024-07-01','Absent'),

-- Student 2
(2,1,'2024-07-01','Present'),
(2,2,'2024-07-01','Absent'),
(2,12,'2024-07-01','Present'),

-- Student 3
(3,3,'2024-07-01','Present'),
(3,4,'2024-07-01','Present'),
(3,13,'2024-07-01','Present'),

-- Student 4
(4,3,'2024-07-01','Absent'),
(4,4,'2024-07-01','Present'),
(4,14,'2024-07-01','Present'),

-- Student 5
(5,5,'2024-07-01','Present'),
(5,6,'2024-07-01','Present'),
(5,15,'2024-07-01','Absent'),

-- Student 6
(6,5,'2024-07-01','Present'),
(6,6,'2024-07-01','Absent'),
(6,11,'2024-07-01','Present'),

-- Student 7
(7,7,'2024-07-01','Present'),
(7,8,'2024-07-01','Present'),
(7,12,'2024-07-01','Present'),

-- Student 8
(8,7,'2024-07-01','Absent'),
(8,8,'2024-07-01','Present'),
(8,13,'2024-07-01','Present'),

-- Student 9
(9,9,'2024-07-01','Present'),
(9,10,'2024-07-01','Present'),
(9,14,'2024-07-01','Absent'),

-- Student 10
(10,9,'2024-07-01','Present'),
(10,10,'2024-07-01','Present'),
(10,15,'2024-07-01','Present');

SELECT * FROM attendance;

-- Display Attendance Report

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    sub.subject_name,
    a.attendance_date,
    a.status
FROM attendance a
JOIN student s
ON a.student_id = s.student_id
JOIN subject sub
ON a.subject_id = sub.subject_id
ORDER BY s.student_id;

-- Count Present and Absent Students

-- total present 

SELECT COUNT(*) AS Total_Present 
FROM attendance
WHERE status = 'Present';

-- absent

SELECT COUNT(*) AS Total_Absent
FROM attendance
WHERE status = 'Absent';

-- Attendance Percentage of Each Student

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS Student_Name,
    ROUND(
        SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END)
        *100.0/COUNT(*),2
    ) AS Attendance_Percentage
FROM attendance a
JOIN student s
ON a.student_id=s.student_id
GROUP BY s.student_id;

-- Attendance Percentage of Each Student

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS Student_Name,
    ROUND(
        SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END)
        *100.0/COUNT(*),2
    ) AS Attendance_Percentage
FROM attendance a
JOIN student s
ON a.student_id=s.student_id
GROUP BY s.student_id;

-- Students with Less Than 75% Attendance

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS Student_Name,
    ROUND(
        SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END)
        *100.0/COUNT(*),2
    ) AS Attendance_Percentage
FROM attendance a
JOIN student s
ON a.student_id=s.student_id
GROUP BY s.student_id
HAVING Attendance_Percentage < 75;

-- ============================================
-- INSERT INTO MARKS
-- ============================================

INSERT INTO marks
(student_id, subject_id, exam_type, marks)
VALUES

-- Student 1
(1,1,'Internal',85),
(1,2,'Internal',90),
(1,11,'Internal',88),

-- Student 2
(2,1,'Internal',78),
(2,2,'Internal',82),
(2,12,'Internal',75),

-- Student 3
(3,3,'Internal',91),
(3,4,'Internal',87),
(3,13,'Internal',84),

-- Student 4
(4,3,'Internal',69),
(4,4,'Internal',73),
(4,14,'Internal',80),

-- Student 5
(5,5,'Internal',88),
(5,6,'Internal',92),
(5,15,'Internal',86),

-- Student 6
(6,5,'Internal',76),
(6,6,'Internal',81),
(6,11,'Internal',79),

-- Student 7
(7,7,'Internal',95),
(7,8,'Internal',89),
(7,12,'Internal',91),

-- Student 8
(8,7,'Internal',72),
(8,8,'Internal',84),
(8,13,'Internal',77),

-- Student 9
(9,9,'Internal',90),
(9,10,'Internal',94),
(9,14,'Internal',88),

-- Student 10
(10,9,'Internal',83),
(10,10,'Internal',86),
(10,15,'Internal',81);

SELECT * FROM marks;

SELECT S.ROLL_NO,S.STUDENT_ID, CONCAT(s.first_name,' ',s.last_name) AS student_name,
    sub.subject_name,
    m.exam_type,
    m.marks
    FROM marks m
JOIN student s
ON m.student_id = s.student_id
JOIN subject sub
ON m.subject_id = sub.subject_id
ORDER BY s.student_id;

-- -------------
-- ============================================
-- INSERT INTO FEES
-- ============================================

INSERT INTO fees
(student_id, total_fee, paid_amount, due_amount, payment_status, payment_date)
VALUES

(1,250000,250000,0,'Paid','2024-07-10'),
(2,250000,200000,50000,'Partial','2024-07-10'),
(3,240000,240000,0,'Paid','2024-07-11'),
(4,240000,150000,90000,'Partial','2024-07-11'),
(5,230000,230000,0,'Paid','2024-07-12'),
(6,230000,100000,130000,'Pending','2024-07-12'),
(7,220000,220000,0,'Paid','2024-07-13'),
(8,220000,150000,70000,'Partial','2024-07-13'),
(9,245000,245000,0,'Paid','2024-07-14'),
(10,245000,120000,125000,'Pending','2024-07-14');

SELECT * FROM fees;

-- ---------------

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    f.total_fee,
    f.paid_amount,
    f.due_amount,
    f.payment_status
FROM fees f
JOIN student s
ON f.student_id = s.student_id;

-- --------------------------

-- ============================================
-- INSERT INTO USERS
-- ============================================

INSERT INTO users
(username, password, role)
VALUES

-- Admin
('admin','admin123','Admin'),

-- Faculty
('suresh','suresh123','Faculty'),
('kavitha','kavitha123','Faculty'),
('manoj','manoj123','Faculty'),
('divya','divya123','Faculty'),
('vignesh','vignesh123','Faculty'),

-- Students
('CSE001','cse001123','Student'),
('CSE002','cse002123','Student'),
('ECE001','ece001123','Student'),
('ECE002','ece002123','Student'),
('MECH001','mech001123','Student'),
('MECH002','mech002123','Student'),
('CIV001','civ001123','Student'),
('CIV002','civ002123','Student'),
('IT001','it001123','Student'),
('IT002','it002123','Student');

SELECT * FROM department;
SELECT * FROM course;
SELECT * FROM teacher;
SELECT * FROM student;
SELECT * FROM subject;
SELECT * FROM enrollment;
SELECT * FROM attendance;
SELECT * FROM marks;
SELECT * FROM fees;
SELECT * FROM users;



-- ----------------------------------------------------
-- CRUD OPERATION 


-- INSEERT NEW STUDENT 

INSERT INTO student
(roll_no, first_name, last_name, gender, dob, phone, email, address, admission_date, dept_id, course_id)
VALUES
(
'CSE011',
'Rohit',
'Sharma',
'Male',
'2005-06-20',
'9876500011',
'rohit@gmail.com',
'Chennai',
'2024-06-10',
1,
1
);

SELECT *
FROM student
WHERE FIRST_NAME='ROHIT';

-- READ (SELECT)

SELECT *
FROM student;

-- SPECIFIC COLUMNS

SELECT
student_id,
roll_no,
first_name,
last_name
FROM student;

-- Display Student Full Name

SELECT
CONCAT(first_name,' ',last_name) AS Student_Name
FROM student;

-- Display Students from CSE Department

SELECT *
FROM student
WHERE dept_id=1;

-- Display Female Students

SELECT *
FROM student
WHERE gender='Female';

-- Display Students Born After 2005

SELECT *
FROM student
WHERE dob>'2005-01-01';

-- -------------------------

-- UPDATE 

SELECT * FROM student WHERE student_id=1;

-- email change 

UPDATE student
SET EMAIL='arunkumar@gmail.com'
where student_id=1;

-- -----------
-- update adress 

UPDATE student
SET address='Bangalore'
WHERE student_id=2;


SELECT * FROM student WHERE student_id=2;
-- -----------------
UPDATE student
SET dept_id=5
WHERE student_id=3;

SELECT * FROM student WHERE student_id=3;

-- --------------------------------------
SELECT * FROM student WHEre phone is null;

-- Combined Query
-- Female students from CSE with marks above 80
SELECT
s.student_id,
s.first_name,
s.last_name,
m.marks
FROM student s
JOIN marks m
ON s.student_id = m.student_id
WHERE s.gender='Female'
AND s.dept_id=1
AND m.marks>80
ORDER BY m.marks DESC;

-- INNER JOIN -----------------------
-- Display Student with Department

SELECT
    s.student_id,
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    d.dept_name
FROM student s
INNER JOIN department d
ON s.dept_id = d.dept_id;
-- ---------------------------------
-- Student + Course

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    c.course_name
FROM student s
INNER JOIN course c
ON s.course_id = c.course_id;

-- Student + Department + Course
SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    d.dept_name,
    c.course_name
FROM student s
JOIN department d
ON s.dept_id=d.dept_id
JOIN course c
ON s.course_id=c.course_id;

-- Student + Subject (Enrollment)
SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    sub.subject_name
FROM enrollment e
JOIN student s
ON e.student_id=s.student_id
JOIN subject sub
ON e.subject_id=sub.subject_id;

-- Student + Fees
SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    f.total_fee,
    f.paid_amount,
    f.due_amount,
    f.payment_status
FROM fees f
JOIN student s
ON f.student_id=s.student_id;

-- Teacher + Subject
SELECT
    t.teacher_name,
    sub.subject_name,
    sub.semester
FROM teacher t
JOIN subject sub
ON t.teacher_id=sub.teacher_id;

-- LEFT JOIN
-- Display all students, even if they don't have fee records.

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    f.payment_status
FROM student s
LEFT JOIN fees f
ON s.student_id=f.student_id;

-- RIGHT JOIN
-- Display all departments, even if no students belong to them.

SELECT
    s.roll_no,
    d.dept_name
FROM student s
RIGHT JOIN department d
ON s.dept_id=d.dept_id;

-- Multiple JOIN (Full Student Report)

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    d.dept_name,
    c.course_name,
    sub.subject_name,
    m.marks
FROM student s
JOIN department d
ON s.dept_id=d.dept_id
JOIN course c
ON s.course_id=c.course_id
JOIN marks m
ON s.student_id=m.student_id
JOIN subject sub
ON m.subject_id=sub.subject_id;

-- Attendance Report

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    COUNT(a.attendance_id) AS total_classes,
    SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END) AS present_days
FROM student s
JOIN attendance a
ON s.student_id=a.student_id
GROUP BY s.student_id;

-- Fee Report

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    f.paid_amount,
    f.due_amount
FROM student s
JOIN fees f
ON s.student_id=f.student_id;

-- Aggregate Functions, GROUP BY & HAVING

SELECT
    d.dept_name,
    COUNT(s.student_id) AS total_students,
    SUM(f.paid_amount) AS total_fee_collected,
    AVG(m.marks) AS average_marks,
    MIN(m.marks) AS minimum_marks,
    MAX(m.marks) AS maximum_marks
FROM department d
JOIN student s
ON d.dept_id = s.dept_id
JOIN fees f
ON s.student_id = f.student_id
JOIN marks m
ON s.student_id = m.student_id
GROUP BY d.dept_name
HAVING AVG(m.marks) > 80;

-- ------------------------------------------------
-- Students Who Have Paid the Highest Fee

SELECT
    s.roll_no,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    f.paid_amount
FROM student s
JOIN fees f
ON s.student_id = f.student_id
WHERE f.paid_amount = (
    SELECT MAX(paid_amount)
    FROM fees
);

-- Create a View

CREATE VIEW student_details AS
SELECT
    s.roll_no,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.dept_name,
    c.course_name,
    f.payment_status
FROM student s
JOIN department d
ON s.dept_id = d.dept_id
JOIN course c
ON s.course_id = c.course_id
JOIN fees f
ON s.student_id = f.student_id;

-- view the data

SELECT * FROM student_details;

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';

-- indexes -------------------

-- create an index

CREATE INDEX idx_roll_no
ON student(roll_no);

-- view the indexes

SHOW INDEX FROM student;

-- use the indexes column

SELECT *
FROM student
WHERE roll_no = 'CSE001';

-- ========================================
-- Stored Procedures

DELIMITER //

CREATE PROCEDURE GetStudentDetails()
BEGIN
    SELECT
        s.roll_no,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
        d.dept_name,
        c.course_name
    FROM student s
    JOIN department d
        ON s.dept_id = d.dept_id
    JOIN course c
        ON s.course_id = c.course_id;
END //

DELIMITER ;

CALL GetStudentDetails();

SHOW PROCEDURE STATUS
WHERE Db = 'student_management_system';

-- ========================================

-- function 

DELIMITER //

CREATE FUNCTION GetTotalStudents()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM student;

    RETURN total;
END //

DELIMITER ;

SELECT GetTotalStudents() AS Total_Students;

SHOW FUNCTION STATUS
WHERE Db = 'student_management_system';

-- triggers =================
INSERT INTO student(roll_no, first_name, last_name, gender, dob, phone, email, address, admission_date, dept_id, course_id)
VALUES
('TEST001','Test','Student','Male','2005-01-01',
'9999999999','test@gmail.com','Chennai','2024-06-10',1,1);


SELECT * FROM student
WHERE roll_no='TEST001';

-- create a log table 

CREATE TABLE student_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    student_name VARCHAR(100),
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- create trigger

DELIMITER //

CREATE TRIGGER trg_before_student_delete
BEFORE DELETE
ON student
FOR EACH ROW
BEGIN
    INSERT INTO student_log(student_id, student_name)
    VALUES(
        OLD.student_id,
        CONCAT(OLD.first_name,' ',OLD.last_name)
    );
END //

DELIMITER ;

-- test the trigger
DELETE FROM student
WHERE student_id = 11;

DELETE FROM student
WHERE student_id = 13;

SELECT * FROM student_log;

-- transaction ====================

SELECT *
FROM fees
WHERE student_id = 2;
-- ===========================
START TRANSACTION;

UPDATE fees
SET
    paid_amount = 250000,
    due_amount = 0,
    payment_status = 'Paid'
WHERE student_id = 2;

COMMIT;

-- transaction & rollback ===============================

START TRANSACTION;

UPDATE fees
SET
    paid_amount = 0,
    payment_status = 'Pending'
WHERE student_id = 3;

ROLLBACK;

SELECT *
FROM fees
WHERE student_id = 3;

-- SAVEPOINT =====================
START TRANSACTION;

UPDATE fees
SET paid_amount = 240000
WHERE student_id = 3;

SAVEPOINT fee_update;

UPDATE fees
SET due_amount = 0
WHERE student_id = 3;

UPDATE fees
SET payment_status = 'paid'
WHERE student_id = 3;

ROLLBACK TO fee_update;

COMMIT;

ROLLBACK;
-- -------
SELECT *
FROM fees
WHERE student_id = 3;
-- =============================
-- REPORT
-- Student Details Report

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS Student_Name,
    d.dept_name,
    c.course_name
FROM student s
JOIN department d
ON s.dept_id=d.dept_id
JOIN course c
ON s.course_id=c.course_id;

-- Department-wise Student Count

SELECT
    d.dept_name,
    COUNT(s.student_id) AS Total_Students
FROM department d
LEFT JOIN student s
ON d.dept_id=s.dept_id
GROUP BY d.dept_name;

-- Top 5 Students by Average Marks

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS Student_Name,
    ROUND(AVG(m.marks),2) AS Average_Marks
FROM student s
JOIN marks m
ON s.student_id=m.student_id
GROUP BY s.student_id
ORDER BY Average_Marks DESC
LIMIT 5;

-- Student Attendance Report

SELECT
	S.STUDENT_ID,
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS Student_Name,
    ROUND(
        SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END)*100/COUNT(*),
        2
    ) AS Attendance_Percentage
FROM student s
JOIN attendance a
ON s.student_id=a.student_id
GROUP BY s.student_id;

-- Student Fee Report

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS Student_Name,
    f.total_fee,
    f.paid_amount,
    f.due_amount,
    f.payment_status
FROM student s
JOIN fees f
ON s.student_id=f.student_id;

-- Subject-wise Highest Marks

SELECT
    sub.subject_name,
    MAX(m.marks) AS Highest_Marks
FROM subject sub
JOIN marks m
ON sub.subject_id=m.subject_id
GROUP BY sub.subject_name;

-- Students with Pending Fees

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS Student_Name,
    f.due_amount
FROM student s
JOIN fees f
ON s.student_id=f.student_id
WHERE f.payment_status IN ('Pending','Partial');

-- Department-wise Total Pending Fee

SELECT
    d.dept_name AS Department,
    COUNT(s.student_id) AS Total_Students,
    SUM(f.due_amount) AS Total_Pending_Fee
FROM department d
JOIN student s
    ON d.dept_id = s.dept_id
JOIN fees f
    ON s.student_id = f.student_id
GROUP BY d.dept_name;

-- Students with Attendance Below 75%

SELECT
    s.roll_no,
    CONCAT(s.first_name,' ',s.last_name) AS Student_Name,
    ROUND(
        SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END)*100/COUNT(*),
        2
    ) AS Attendance_Percentage
FROM student s
JOIN attendance a
ON s.student_id=a.student_id
GROUP BY s.student_id
HAVING Attendance_Percentage < 75;

-- Teacher-wise Subject Report

SELECT
    t.teacher_name,
    COUNT(sub.subject_id) AS Total_Subjects
FROM teacher t
LEFT JOIN subject sub
ON t.teacher_id=sub.teacher_id
GROUP BY t.teacher_name;

-- College Dashboard Report

SELECT
    (SELECT COUNT(*) FROM student) AS Total_Students,
    (SELECT COUNT(*) FROM teacher) AS Total_Teachers,
    (SELECT COUNT(*) FROM department) AS Total_Departments,
    (SELECT SUM(paid_amount) FROM fees) AS Total_Fees_Collected,
    (SELECT SUM(due_amount) FROM fees) AS total_fees_pending,
    (SELECT ROUND(AVG(marks),2) FROM marks) AS Average_Marks;
    
    
-- ==============================================================================    