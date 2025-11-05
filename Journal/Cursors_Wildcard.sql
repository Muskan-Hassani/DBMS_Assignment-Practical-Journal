drop database if exists besantbank;
create database besantbank;
use besantbank;
drop procedure if exists sendmessage;
drop procedure if exists sendmessage_table;
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

delimiter $$
create procedure sendmessage()
begin
  declare var_name char(30);
  declare var_currentbalance int;
  declare var_finished int default 0;
  
  declare cursor_account cursor for
    select name, currentbalance from accountdetails;
    
  declare continue handler for not found set var_finished = 1;
  
  open cursor_account;
  
  loop_account: loop
    fetch cursor_account into var_name, var_currentbalance;
    if var_finished = 1 then
      leave loop_account;
    end if;
    select var_name, var_currentbalance;
  end loop;
  
  close cursor_account;
end$$
delimiter ;

delimiter $$
create procedure sendmessage_table()
begin
  declare var_name char(30);
  declare var_currentbalance int;
  declare var_finished int default 0;
  
  declare cursor_account cursor for
    select name, currentbalance from accountdetails;
    
  declare continue handler for not found set var_finished = 1;
  
  drop table if exists message_table;
  create table message_table (name char(30), currentbalance int);
  
  open cursor_account;
  
  loop_account: loop
    fetch cursor_account into var_name, var_currentbalance;
    if var_finished = 1 then
      leave loop_account;
    end if;
    insert into message_table values (var_name, var_currentbalance);
  end loop;
  
  close cursor_account;
  
  select * from message_table;
end$$
delimiter ;

call sendmessage();

call sendmessage_table();

select * from accountdetails
where name like 'r%';

select * from accountdetails
where name like '%r';

select * from accountdetails
where name like '%r%';