create database if not exists college;
use college;
create table student(
Roll_no INT PRIMARY KEY,
Name VARCHAR(25) NOT NULL,
City VARCHAR(20) NOT NULL,
Marks int
);

INSERT INTO student (Roll_no, Name, City, Marks)
Values(003,"Vrishti", "Aurangabad", 89),
(001,"Aarya","Mumbai",97),
(021,"Lucas","Bangalore",93),
(002,"Dev","Kolkata",65),
(006,"Kunal","Gwalior",77),
(023,"Laksh","Pune",71),
(012,"Rachel","Mumbai", 67);

select name, marks
from student
where Marks>75;

select city
from student
group by city;

select city, max(marks)
from student
group by city;

select avg(marks)
from student;

alter table student
add column grade varchar(5);

update student
set grade = "O"
where marks>=80;

update student
set grade = "A"
where marks >=70 and marks<80;

update student
set grade = "B"
where marks>=60 and marks<70;

update student
set grade = "C"
where marks>=50  and marks<60;

select * from student;