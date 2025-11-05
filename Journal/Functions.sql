drop database besantbank;
create database besantbank;
use besantbank;

create table accountdetails(
  accountid int primary key,
  name char(30) not null,
  age tinyint check(age > 18),
  accounttype varchar(20),
  currentbalance int
);

insert into accountdetails values
(1, 'ram', 21, 'saving', 2000),
(2, 'sana', 23, 'current', 500),
(3, 'john', 27, 'saving', 1000),
(4, 'peter', 25, 'saving', 1500),
(5, 'kiran', 27, 'current', 5200),
(6, 'priya', 21, 'saving', 5500),
(7, 'varun', 28, 'current', 500),
(8, 'sonu', 29, 'saving', 2500),
(9, 'kumar', 28, 'saving', 2000),
(10, 'jathin', 27, 'current', 5000),
(11, 'suma', 22, 'saving', 1500);

alter table accountdetails
add accountstatus char(8) default('active');

update accountdetails
set name = 'ram prasad'
where accountid = 1;

create table studentsmarks (
  name varchar(20), 
  subject varchar(20), 
  marks int
);

insert into studentsmarks values
('ram', 'maths', 99),
('john', 'maths', 99),
('peter', 'maths', 90),
('sana', 'maths', 85),
('ram', 'science', 95),
('john', 'science', 95),
('peter', 'science', 89),
('sana', 'science', 82),
('john', 'science', 95),
('sana', 'maths', 85),
('sana', 'maths', 85);

create table empsalary (
  name varchar(20), 
  year int, 
  salary int
);

insert into empsalary values
('john', 2020, 22000),
('john', 2021, 25000),
('john', 2022, 29000),
('john', 2023, 32000),
('ram', 2018, 15000),
('ram', 2019, 23000),
('ram', 2020, 25000),
('ram', 2021, 27000),
('ram', 2022, 30000),
('ram', 2023, 35000);

select sum(currentbalance) as totalbalance from accountdetails;
select max(currentbalance) as maxbalance from accountdetails;
select min(currentbalance) as minbalance from accountdetails;
select count(currentbalance) as totalrecords from accountdetails;
select count(*) as totalrecords from accountdetails;
select distinct(accounttype) as uniqueaccounttype from accountdetails;
select avg(currentbalance) as averagebalance from accountdetails;
select round(avg(currentbalance)) as averagebalance from accountdetails;

select concat(accountid, ' ', name, ' ', accountstatus) as customer_details from accountdetails;
select concat('muskan', ' ', 'oballa') as fullname;
select upper(name) as capitalcharacters from accountdetails;
select lower(name) as smallcharacters from accountdetails;
select trim(' mysql workbench ') as cleandata;
select ltrim(' mysql workbench ') as leftcleandata;
select rtrim(' mysql workbench ') as rightcleandata;
select length('mysql workbench') as text_length;
select name, instr(name, 'a') as position from accountdetails;

select now();
select timestampdiff(day, '2024-08-01', '2024-08-15') as dateoff;
select current_date;
select year('2024-08-12') as year;
select month('2024-08-12') as month;
select day('2024-08-12') as day;
select monthname('2024-08-12') as month_name;
select date_add('2024-08-12', interval 7 day) as newdate;
select dayofweek('2024-08-12') as weekno;

select name, subject, marks,
  rank() over(partition by subject order by marks desc) as stud_rank
from studentsmarks;

select name, subject, marks,
  dense_rank() over(partition by subject order by marks desc) as stud_rank
from studentsmarks;

select name, subject, marks,
  row_number() over(partition by name, subject, marks) as rowno
from studentsmarks;

select *,
  lag(salary) over(partition by name) as previousval
from empsalary;

set global log_bin_trust_function_creators = 1;

create function calculateage (dob date)
returns int
return timestampdiff(year, dob, now());

select calculateage('1990-01-01');

create function calculatebmi (weight_kg decimal(5,2), height_m decimal(3,2))
returns decimal(5,2)
return weight_kg / (height_m * height_m);

select calculatebmi(70, 1.75);