create procedure errorhandler()
begin
  select * from accdetails; 
end

call besantbank.errorhandler();

create procedure errorhandler()
begin
  declare continue handler for 1146
  begin
    select 'check table name' as message;
  end;
  
  select * from accdetails; 
end

create procedure errorhandler()
begin
  declare continue handler for 1146
  begin
    select 'check table name' as message;
  end;
  
  select * from accdetails; 
  select * from transactiondetails; 
end

create procedure errorhandler()
begin
  declare exit handler for 1146
  begin
    select 'check table name' as message;
  end;
  
  select * from accdetails; 
  select * from transactiondetails; 
end

create procedure exceptionhandling()
begin
  declare continue handler for sqlexception
  begin
    select 'something went wrong - please try again!!' as message;
  end;
  
  select * from accdetails; 
  select * from transactiondetails; 
end

create procedure exceptionhandling()
begin
  declare exit handler for sqlexception
  begin
    select 'something went wrong - please try again!!' as message;
  end;
  
  select * from accdetails; 
  select * from transactiondetails; 
end