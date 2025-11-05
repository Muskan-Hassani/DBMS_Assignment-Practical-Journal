create database besantbnk;
use besantbnk;
drop view if exists bankstatement;
drop view if exists accountsoftransactions;
drop view if exists balanceinbank;
drop procedure if exists bankstatement;
drop procedure if exists ministatement;
drop procedure if exists accountstatusupdater;
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
(7, 'credit', 1000),
(2, 'credit', 500);

update accountdetails
set name = 'ram prasad'
where accountid = 1;

create view bankstatement as
select * from transactiondetails
where accountid = 1;

select * from bankstatement;

delimiter $$
create procedure bankstatement (par_accountid int)
begin
  select * from transactiondetails
  where accountid = par_accountid;
end$$
delimiter ;

delimiter $$
create procedure ministatement(par_accountid int)
begin
  declare var_name varchar(50);
  declare var_currentbalance int;

  select now() as today_datetime;

  if exists(select * from accountdetails where accountid = par_accountid)
  then
    select par_accountid as accountid;
    
    select name, currentbalance into var_name, var_currentbalance
    from accountdetails where accountid = par_accountid;
    
    select var_name as customername;
    
    select * from transactiondetails
    where accountid = par_accountid and timestampdiff(month, transactiontime, now()) <= 6;
    
    select var_currentbalance as currentbalance;
  else
    select 'invalid accountid' as message;
  end if;
end$$
delimiter ;

call besantbank.ministatement(1);

call besantbank.ministatement(15);

alter table accountdetails
add accountstatus char(8) default('active');

delimiter $$
create procedure accountstatusupdater()
begin
  update accountdetails
  set accountstatus = 'active'
  where accountid in (
    select distinct accountid from transactiondetails
    where timestampdiff(month, transactiontime, now()) <= 6
  );
  
  update accountdetails
  set accountstatus = 'inactive'
  where accountid not in (
    select distinct accountid from transactiondetails
    where timestampdiff(month, transactiontime, now()) <= 6
  );
end$$
delimiter ;

call accountstatusupdater();

select * from accountdetails;