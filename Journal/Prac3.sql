create database BesantBank;
use BesantBank;
create table Accountdetails(
AccountID int primary key,
Name char(30) not null,
Age tinyint check(age>18),
Accountype varchar(20),
Currentbalance int
);

insert into Accountdetails(AccountID ,Name,Age,Accountype ,Currentbalance)
values(1,'Ram',21,'Saving',2000),
(3,'Lavi',29,'Saving',3300),
(4,'Lucas',25,'Saving',19200);

create table Transactiondetails(
TransactionID int primary key auto_increment,
AccountID int,
Transactiontype varchar(30) check(Transactiontype='Credit' or Transactiontype='Debit'),
Transactionamount int,
Transactiontime datetime default(now()),
foreign key(AccountID) references Accountdetails(AccountID)
);

select * from transactiondetails;

insert into transactiondetails(AccountID, Transactiontype ,Transactionamount)
values(1,'Credit',2000),
(1,'Debit',3300);


create table employee(
EmpID int primary key,
EmpName varchar(20),
DeptID int,
foreign key (DeptID) references dept(DeptID)
);

create table dept(
DeptID int primary key,
DeptName varchar(20)
);

insert into employee(EmpID,EmpName,DeptID)
values(1,'Ram',101),
(2,'Sham',102),
(3,'Peter',103),
(4,'John',104);

insert into dept(DeptID ,DeptName)
values(101,'IT'),
(102,'HR'),
(103,'Sales'),
(104,'Marketing');

select e.EmpID, e.EmpName, d.DeptName
from employee as e
inner join dept as d
on e.DeptID=d.DeptID;

select *
from employee as e
inner join dept as d
on e.DeptID=d.DeptID;


select e.EmpID, e.EmpName, d.DeptID
from employee as e
left join dept as d
on e.DeptID=d.DeptID;

select e.EmpID, e.EmpName, d.DeptName, d.DeptID
from employee as e
right join dept as d
on e.DeptID=d.DeptID;

select e.EmpID, e.EmpName, d.DeptName, d.DeptID
from employee as e
left join dept as d
on e.DeptID=d.DeptID
union
select e.EmpID, e.EmpName, d.DeptName, d.DeptID
from employee as e
right join dept as d
on e.DeptID=d.DeptID;


select e.EmpID, e.EmpName, d.DeptName, d.DeptID
from employee as e
cross join dept as d;

create table company(
EmpID int primary key,
EmpName varchar(20),
ManagerID int
);

insert into company(EmpID,EmpName,ManagerID)
values(1,'John',0),
(2,'alice',1),
(3,'bob',2),
(4,'mary',3);


select  c.EmpName as employeename,
		m.EmpName as managername
from company c
left join company m
on c.managerid=m.empid;

SELECT *
FROM Accountdetails
WHERE AccountID IN (
    SELECT AccountID
    FROM Transactiondetails
);

INSERT INTO Accountdetails (AccountID, Name, Currentbalance)
VALUES (2, 'John', 2000),
       (5, 'Sana', 5000),
       (13, 'Peter', 7000),
       (15, 'Riya', 3000),
       (6, 'Neha', 4000),
       (7, 'Raj', 8000),
       (8, 'Amit', 1200),
       (9, 'Simran', 2500),
       (10, 'Karan', 6000),
       (11, 'Meena', 9000);

INSERT INTO Transactiondetails (TransactionID, AccountID,Transactionamount, Transactiontype)
VALUES (3, 2, 2000, 'Credit');

SELECT DISTINCT AccountID
FROM Transactiondetails;

SELECT *
FROM Accountdetails
WHERE AccountID IN (1, 2, 3);

SELECT *
FROM Accountdetails
WHERE AccountID IN (
    SELECT DISTINCT AccountID
    FROM Transactiondetails
);

SELECT Currentbalance AS Balance
FROM Accountdetails
ORDER BY Balance DESC
LIMIT 5;

SELECT Currentbalance
FROM (
   SELECT Currentbalance
   FROM Accountdetails
   ORDER BY Currentbalance DESC
   LIMIT 5
) AS TopBalance
ORDER BY Currentbalance ASC
LIMIT 1;

SELECT Currentbalance
FROM (
   SELECT Currentbalance
   FROM Accountdetails
   ORDER BY Currentbalance DESC
   LIMIT 2
) AS SecondHighest
ORDER BY Currentbalance ASC
LIMIT 1;

CREATE VIEW ActiveAccounts AS
SELECT a.*
FROM Accountdetails a
JOIN Transactiondetails t ON a.AccountID = t.AccountID;

SELECT * FROM ActiveAccounts;

INSERT INTO Transactiondetails (TransactionID, AccountID, Transactionamount, Transactiontype)
VALUES (4, 2, 1000, 'Debit');

UPDATE ActiveAccounts
SET Name = 'Ram Prasad'
WHERE AccountID = 1;

CREATE VIEW AccountSummary AS
SELECT AccountID, SUM(Amount) AS TotalAmount
FROM Transactiondetails
GROUP BY AccountID;

ALTER TABLE Accountdetails
ADD Accountstatus CHAR(28) DEFAULT('Active');

SELECT * FROM Accountdetails;
SET SQL_SAFE_UPDATES = 0;

