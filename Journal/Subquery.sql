create database besantbank;
use besantbank;

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
(1, 'ram', 21, 'saving', 2000);

insert into transactiondetails (accountid, transactiontype, transactionamount)
values
(1, 'credit', 1000),
(1, 'debit', 500);

insert into accountdetails values
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
(7, 'credit', 1000);

select distinct (accountid) from transactiondetails;

select * from accountdetails where accountid in (1,7);

select * from accountdetails
where accountid in (
  select distinct(accountid) from transactiondetails
);

select currentbalance from accountdetails
order by currentbalance desc
limit 5;

select min(currentbalance) from accountdetails
where currentbalance in (
  select currentbalance from accountdetails
  order by currentbalance desc
  limit 5
);

select min(currentbalance) from (
  select currentbalance from accountdetails
  order by currentbalance desc
  limit 5
) as topbalance;

select min(currentbalance) from (
  select currentbalance from accountdetails
  order by currentbalance desc
  limit 2
) as topbalance;