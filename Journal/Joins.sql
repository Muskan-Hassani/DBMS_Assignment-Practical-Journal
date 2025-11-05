create database prac_company;
use prac_company;
create table department (
  departmentid int primary key,
  deptname varchar(20)
);

create table employee (
  empid int primary key,
  empname varchar(20),
  departmentid int
);

create table company (
  emp_id int primary key,
  emp_name varchar(20),
  manager_id int
);

insert into department (departmentid, deptname) 
values(101, 'it'),
(102, 'hr'),
(103, 'sales'),
(104, 'marketing');

insert into employee (empid, empname, departmentid) 
values(1, 'ram', 101),
(2, 'sham', 102),
(3, 'peter', 101),
(4, 'john', 103);

insert into company (emp_id, emp_name, manager_id)
values(1, 'john', 0),
(2, 'alice', 1),
(3, 'bob', 1),
(4, 'mary', 2);

select * from employee;
select * from department;

-- query 3: inner join
select e.empid, e.empname, d.deptname
from employee as e
inner join department as d
  on e.departmentid = d.departmentid;

-- query 4: inner join (all columns)
select *
from employee as e
inner join department as d
  on e.departmentid = d.departmentid;

-- query 5: left join
select e.empid, e.empname, d.departmentid, d.deptname
from employee as e
left join department as d
  on e.departmentid = d.departmentid;

-- query 6: right join
select e.empid, e.empname, d.departmentid, d.deptname
from employee as e
right join department as d
  on e.departmentid = d.departmentid;

-- query 7: full outer join (simulated with union)
select e.empid, e.empname, d.departmentid, d.deptname
from employee as e
left join department as d
  on e.departmentid = d.departmentid
union
select e.empid, e.empname, d.departmentid, d.deptname
from employee as e
right join department as d
  on e.departmentid = d.departmentid;

-- query 8: cross join
select e.empid, e.empname, d.departmentid, d.deptname
from employee as e
cross join department as d;

-- query 9: self join (left)
select c.emp_name as employee_name,
  m.emp_name as manager_name
from company c
left join company m
  on c.manager_id = m.emp_id;

-- query 10: self join (inner)
select c.emp_name as employee_name,
  m.emp_name as manager_name
from company c
join company m
  on c.manager_id = m.emp_id;