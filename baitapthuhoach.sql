CREATE DATABASE TrainingCenter;
USE TrainingCenter;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    age INT
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    tuition_fee DECIMAL(10,2)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    score DECIMAL(4,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students VALUES
(1,'Nguyen Van A','Nam',20),
(2,'Tran Thi B','Nu',21),
(3,'Le Van C','Nam',19),
(4,'Pham Thi D','Nu',22),
(5,'Hoang Van E','Nam',20),
(6,'Vo Thi F','Nu',21),
(7,'Dang Van G','Nam',23),
(8,'Bui Thi H','Nu',20),
(9,'Nguyen Van I','Nam',22),
(10,'Tran Thi K','Nu',19);

INSERT INTO courses VALUES
(1,'Java',3500000),
(2,'Python',3000000),
(3,'MySQL',2500000),
(4,'ReactJS',4000000),
(5,'Testing',2000000);

INSERT INTO enrollments VALUES
(1,1,1,'2026-01-10',8.5),
(2,1,2,'2026-01-12',9.0),
(3,2,1,'2026-01-15',7.5),
(4,2,3,'2026-01-18',8.0),
(5,3,2,'2026-01-20',9.5),
(6,4,4,'2026-01-22',8.8),
(7,5,5,'2026-01-25',6.5),
(8,6,1,'2026-02-01',7.0),
(9,7,2,'2026-02-03',8.7),
(10,8,3,'2026-02-05',9.2),
(11,9,4,'2026-02-08',8.1),
(12,10,5,'2026-02-10',7.8),
(13,3,4,'2026-02-12',9.0),
(14,5,2,'2026-02-15',8.3),
(15,7,3,'2026-02-18',7.9);

SELECT * FROM students;

SELECT
    full_name AS 'Tên sinh viên',
    age AS 'Tuổi'
FROM students;

UPDATE students
SET age = 25
WHERE student_id = 1;

DELETE FROM enrollments
WHERE enrollment_id = 15;

SELECT COUNT(*) AS total_students
FROM students;

SELECT
    MAX(score) AS highest_score,
    MIN(score) AS lowest_score,
    AVG(score) AS average_score
FROM enrollments;

SELECT SUM(tuition_fee) AS total_tuition
FROM courses;

SELECT
    c.course_name,
    COUNT(e.student_id) AS total_student
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT
    c.course_name,
    AVG(e.score) AS avg_score
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT
    c.course_name,
    COUNT(e.student_id) AS total_student
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING COUNT(e.student_id) > 2;

SELECT s.*
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.score = (SELECT MAX(score) FROM enrollments);

SELECT s.*
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.score = (SELECT MIN(score) FROM enrollments);

SELECT s.*
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.score > (SELECT AVG(score) FROM enrollments);

SELECT *
FROM courses
WHERE tuition_fee = (SELECT MAX(tuition_fee) FROM courses);

SELECT
    s.full_name,
    c.course_name,
    e.score
FROM enrollments e
JOIN students s
ON e.student_id = s.student_id
JOIN courses c
ON e.course_id = c.course_id;

SELECT
    s.full_name,
    c.course_name,
    e.enroll_date
FROM enrollments e
JOIN students s
ON e.student_id = s.student_id
JOIN courses c
ON e.course_id = c.course_id;

SELECT
    c.course_name,
    COUNT(e.student_id) AS total_student
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT
    c.course_name,
    AVG(e.score) AS average_score
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT
    c.course_name,
    COUNT(e.student_id) AS total_student
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY total_student DESC
LIMIT 1;

SELECT
    s.full_name,
    COUNT(e.course_id) AS total_course
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
ORDER BY total_course DESC
LIMIT 1;

SELECT
    s.full_name,
    c.course_name,
    e.score
FROM enrollments e
JOIN students s
ON e.student_id = s.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE e.score >
(
    SELECT AVG(score)
    FROM enrollments e2
    WHERE e2.course_id = e.course_id
);