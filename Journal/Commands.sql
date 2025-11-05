create database prac2;
use prac2;
create table students(
  studentid int,
  name varchar(20),
  age int,
  gender varchar(10)
);

alter table students
add location varchar(20);

truncate table students;

insert into students (studentid, name, age, gender)
values
(01, 'ram', 20, 'male'),
(02, 'sham', 21, 'male'),
(03, 'peter', 21, 'male'),
(04, 'priya', 20, 'female');


update students
set location = "bangalore"
where studentid in (1,3);


update students
set location = "chennai"
where studentid = 2;

update students
set location = "hyderabad"
where studentid = 4;

delete from students
where studentid = 4;


select * from students;

select name, gender, location
from students;

select count(*) as np_pf_students
from students;


select studentid, name
from students
where location = "bangalore";

select distinct location
from students;

select name from students
limit 2;

set autocommit = 0;


start transaction;

select * from students;

delete from students
where studentid = 4;
commit;

rollback;

savepoint a;

savepoint b;

rollback to b;