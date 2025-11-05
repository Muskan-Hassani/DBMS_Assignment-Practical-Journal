create database university_mgmt;
use university_mgmt;

create table departments(
    deptid int primary key,
    deptname varchar(50),
    hod varchar(50)
);

create table students(
    studentid int primary key,
    name varchar(50),
    dob date,
    gender varchar(10),
    deptid int,
    email varchar(100) unique,
    foreign key(deptid) references departments(deptid)
);

create table courses(
    courseid int primary key,
    coursename varchar(50),
    deptid int,
    credits int,
    foreign key(deptid) references departments(deptid)
);

create table faculty(
    facultyid int primary key,
    name varchar(50),
    deptid int,
    email varchar(100) unique,
    dob date,
    foreign key(deptid) references departments(deptid)
);

create table enrollments(
    enrollmentid int primary key,
    studentid int,
    courseid int,
    semester varchar(20),
    grade varchar(2),
    foreign key(studentid) references students(studentid),
    foreign key(courseid) references courses(courseid)
);

insert into departments values
(1,'Computer Science','Dr. Anjali'),
(2,'Physics','Dr. Ramesh'),
(3,'Mathematics','Prof. Shalini'),
(4,'Chemistry','Dr. Kabir'),
(5,'Biology','Dr. Neeta');

insert into students values
(101,'Aman Verma','2001-07-15','Male',1,'amanv@gmail.com'),
(102,'Sneha Kapoor','1999-11-03','Female',2,'snehak@yahoo.com'),
(103,'Ravi Iyer','2002-04-20','Male',1,'raviiyer@outlook.com'),
(104,'Pooja Shah','1998-09-12','Female',3,'poojashah@gmail.com'),
(105,'Kunal Singh','2003-01-28','Male',null,'kunals@rediff.com');

insert into courses values
(201,'Data Structures',1,4),
(202,'Quantum Mechanics',2,3),
(203,'Linear Algebra',3,4),
(204,'Organic Chemistry',4,2),
(205,'Genetics',5,3);

insert into faculty values
(301,'Megha Rao',1,'megha.rao@gmail.com','1980-06-21'),
(302,'Arun Das',2,'arundas@yahoo.com','1975-12-05'),
(303,'Simran Kaur',3,'simran.kaur@hotmail.com','1988-04-18'),
(304,'Rahul Jain',4,'rahuljain@gmail.com','1972-08-10'),
(305,'Neelima Sen',5,'neelima_sen@gmail.com','1990-10-02');

insert into enrollments values
(401,101,201,'Sem 1','A'),
(402,102,202,'Sem 2','C'),
(403,103,201,'Sem 1','B'),
(404,104,203,'Sem 3','A'),
(405,101,202,'Sem 2','F'),
(406,103,204,'Sem 2','B'),
(407,105,205,'Sem 1','D');

select * 
from students
where deptid=(select deptid from departments where deptname='Computer Science');
 
select * 
from courses 
where credits>3;

select * 
from students
 where dob>'2000-01-01';
 
select courseid,avg(case grade when 'A' then 10 when 'B' then 8 when 'C' then 6 when 'D' then 4 when 'F' then 0 end) as avggrade 
from enrollments 
group by courseid;

select * 
from faculty 
where deptid=(select deptid from departments where deptname='Physics');

select deptid,count(*) 
from students
group by deptid;

select * 
from courses 
where deptid=(select deptid from faculty where facultyid=301);

select * 
from students 
where studentid not in(select distinct studentid from enrollments);

select studentid,grade 
from enrollments 
where courseid=203 
order by grade asc 
limit 3;

select studentid,count(courseid) 
from enrollments 
group by studentid 
having count(courseid)>4;

select * 
from courses 
where courseid not in(select distinct courseid from enrollments);

select deptid,count(*) 
from faculty 
group by deptid;

select courseid 
from enrollments 
where studentid=103;

select * 
from students 
where name like 's%';

select * 
from students 
order by dob desc 
limit 1;

select studentid,avg(case grade when 'A' then 10 when 'B' then 8 when 'C' then 6 when 'D' then 4 when 'F' then 0 end) as avgmarks 
from enrollments 
group by studentid;

select * 
from departments 
where deptid not in(select distinct deptid from students);

select name,email 
from faculty;

select * 
from students 
where studentid in(select studentid from enrollments where courseid=(select courseid from courses where coursename='Linear Algebra'));

select studentid,sum(credits) 
from enrollments e join courses c on e.courseid=c.courseid 
group by studentid;

select distinct studentid 
from enrollments 
where grade='F';

select courseid,count(studentid) as total 
from enrollments 
group by courseid 
order by total desc 
limit 1;

select courseid,grade,count(*) 
from enrollments 
group by courseid,grade 
order by courseid,grade;

select s.name,d.deptname 
from students s 
left join departments d on s.deptid=d.deptid;

select * 
from faculty
order by dob asc 
limit 1;
