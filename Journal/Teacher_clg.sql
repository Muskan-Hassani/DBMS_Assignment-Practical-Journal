create database college;
use college;
create table teacher(
ID INT PRIMARY KEY,
Name VARCHAR(25) NOT NULL,
Subject VARCHAR(25) NOT NULL,
Salary int
);

INSERT INTO teacher (ID, Name, Subject, Salary)
Values(333,"Sharda Saroda", "Introduction to Python", 40000),
(127,"Shika Shakar","Differential Calculus", 55000),
(111,"Kreethi Chakortaby","Art of Yoga",20000),
(673,"Manisha Deshmukh","Principle of Management",65000),
(121,"Saksham Ostwal","Linear Algebra", 50000);

Select Salary
from teacher
where Salary>=50000;

alter table teacher
change column Salary ctc INT;

select* from teacher;

set SQL_SAFE_UPDATES=0;

update teacher
set ctc= (ctc*(0.25))+ctc;

alter table teacher
add column city varchar(20) default "Mumbai";

alter table teacher
drop column ctc;