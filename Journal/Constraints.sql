create database prac3;
use prac3;
create table coursedetails (
  courseid tinyint primary key,
  coursename varchar(20) not null,
  amount smallint
);


insert into coursedetails
values (01, 'sql', 15000), (02, 'power-bi', 12000);

select * from coursedetails;
create table studentsdetails (
  sid int primary key,
  sname char(30) not null,
  age tinyint check (age > 18),
  gender varchar(20) check(gender="male" or gender="female"),
  courseid tinyint,
  foreign key (courseid) references coursedetails (courseid)
);

insert into studentsdetails
values
(01, 'ram', 20, 'male', 01),
(02, 'sham', 21, 'male', 01),
(03, 'sana', 21, 'female', 02),
(04, 'priya', 22, 'female', 01),
(05, 'john', 23, 'male', 02);

-- select data
select * from studentsdetails;