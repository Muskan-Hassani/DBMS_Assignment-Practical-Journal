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

update balanceinbank
set name = asfg
where accountid =asfg;