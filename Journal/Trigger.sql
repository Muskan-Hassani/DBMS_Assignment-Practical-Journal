delimiter $$
create trigger balanceupdater
after insert on transactiondetails
for each row
begin
  declare var_latesttransactionid int;
  declare var_accountid int;
  declare var_transactiontype varchar(10);
  declare var_transactionamount int;
  declare var_currentbalance int;

  select max(transactionid) into var_latesttransactionid from transactiondetails;
  
  select accountid, transactiontype, transactionamount
  into var_accountid, var_transactiontype, var_transactionamount
  from transactiondetails
  where transactionid = var_latesttransactionid;
  
  if var_transactiontype = 'credit'
  then
    update accountdetails
    set currentbalance = currentbalance + var_transactionamount
    where accountid = var_accountid;
  else
    
    if var_transactionamount <= var_currentbalance
    then
      update accountdetails
      set currentbalance = currentbalance - var_transactionamount
      where accountid = var_accountid;
    else
      update accountdetails
      set currentbalance = currentbalance
      where accountid = var_accountid;
    end if;
  end if;
end $$
delimiter ;

truncate table transactiondetails;

update accountdetails set currentbalance = 0;

insert into transactiondetails (accountid, transactiontype, transactionamount)
values (1, 'credit', 1000), (1, 'debit', 500);

select * from accountdetails;

delimiter $$
create trigger cascadingdelete
before delete on accountdetails
for each row
begin
  delete from transactiondetails
  where accountid = old.accountid;
end $$
delimiter ;

delete from accountdetails
where accountid = 1;

select * from accountdetails;

select * from transactiondetails;