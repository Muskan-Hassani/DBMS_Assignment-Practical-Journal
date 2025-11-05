
create database practice;
use practice;
create table student(
  studentid int,
  name varchar(20),
  age int,
  gender varchar(10)
);


select * from student;

insert into student (studentid, name, age, gender)
values
(01, 'ram', 20, 'male'),
(02, 'sana', 21, 'female'),
(03, 'john', 21, 'male'),
(04, 'peter', 20, 'male');

select studentid, name, age
from student;

SET SQL_SAFE_UPDATES = 0;


update student
set age = 30
where studentid = 4;

delete from student
where studentid = 4;


truncate table student;
drop table student;