drop database if exists besantbank;
create database besantbank;
use besantbank;

drop table if exists accountdetails;

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

update accountdetails
set name = 'ram prasad'
where accountid = 1;

with accountsummary as (
  select
    accounttype,
    sum(currentbalance) as totalbalance,
    avg(age) as averageage
  from accountdetails
  group by accounttype
)
select * from accountsummary;