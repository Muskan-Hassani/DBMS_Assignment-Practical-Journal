create database  bsantbank;
use bsantbank;
drop table if exists transactiondetails;
drop table if exists accountdetails;

create table accountdetails(
  accountid int primary key,
  name char(30) not null,
  age tinyint check(age > 18),
  accounttype varchar(20),
  currentbalance int
);

create table transactiondetails(
  transactionid int primary key auto_increment,
  accountid int,
  transactiontype varchar(10) check (transactiontype ='credit' or transactiontype = 'debit'),
  transactionamount int,
  transactiontime datetime default (now()),
  foreign key (accountid) references accountdetails (accountid)
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

insert into transactiondetails (accountid, transactiontype, transactionamount)
values
(1, 'credit', 1000),
(1, 'debit', 500),
(7, 'credit', 1000);

create view accountsoftransactions as
select * from accountdetails
where accountid in (
  select distinct(accountid) from transactiondetails
);

select * from accountsoftransactions;

insert into transactiondetails (accountid, transactiontype, transactionamount)
values (2, 'credit', 500);

update accountsoftransactions
set name = 'ram prasad'
where accountid = 1;

select * from accountdetails;

create view balanceinbank as
select sum(currentbalance) from accountdetails;

select * from balanceinbank;

