drop database College;
CREATE database College;
use College;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    marks INT,
    class VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    dept_id INT,
    fee DECIMAL(10,2),
    instructor_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);


INSERT INTO students VALUES
(201, 'Rohan', 'Verma', 85, 'FYBSc', 'rohan@gmail.com'),
(202, 'Priya', 'Iyer', 92, 'FYBSc', 'priya@yahoo.com'),
(203, 'Kabir', 'Singh', 76, 'SYBSc', 'kabir@gmail.com'),
(204, 'Anita', 'Rao', 60, 'SYBSc', 'anita@hotmail.com'),
(205, 'Deepak', 'Nair', 45, 'TYBSc', 'deepak@gmail.com');


INSERT INTO departments VALUES
(1, 'IT', 'Mumbai'),
(2, 'HR', 'Delhi'),
(3, 'Finance', 'Bangalore'),
(4, 'Sales', 'Pune');

INSERT INTO instructors VALUES
(301, 'Dr. Ramesh', 'ramesh@college.edu'),
(302, 'Prof. Meena', 'meena@college.edu'),
(303, 'Dr. Kiran', 'kiran@college.edu');

-- Courses
INSERT INTO courses VALUES
(401, 'Database Systems', 1, 15000, 301),
(402, 'Human Resource Mgmt', 2, 12000, 302),
(403, 'Financial Accounting', 3, 20000, 303),
(404, 'Marketing Basics', 4, 18000, 302);


-- 1 
select *
from students
where marks>=75;

-- 2
select Count(*) as class_strength, class
from students
group by class;


-- 3
select first_name, last_name
from students
where email regexp '[^gmail.com_]';

-- 8
select Count(*) as number_of_students
from students
where first_name regexp '^A';

-- 9
select *
from students
order by marks DESC
limit 5;
