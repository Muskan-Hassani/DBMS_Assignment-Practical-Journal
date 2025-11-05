create database library_management_system;
use library_management_system;
create table Book(
book_id int PRIMARY KEY,
Title varchar(30),
Author varchar(40),
Publisher varchar(30),
ISBN int,
Category varchar(20),
Copies_Available int
);
create table Member(
member_id int PRIMARY KEY,
Name_ varchar(30),
Department varchar(40),
Membership_Date datetime,
Contact int
);

create table transaction(
transaction_id int PRIMARY KEY,
book_id int,
member_id int,
issue_date datetime,
return_date datetime,
Fine int,
foreign key (book_id) references Book(book_id),
foreign key (member_id) references Member(member_id)
);
INSERT INTO Book(book_id, Title, Author, Publisher, ISBN, Category, Copies_Available)
VALUES(7238, "THE GIRL WHO DRANK THE MOON", "Lucas", "Penguin Random House", 978-3-16-148410-0, "Slice of life", 2929 ),
(64748, "Diary of a youn girl", "Anna Frank","Macmillan",0-19-853453-1, "Documentary", 7265),
(7838,"Harry Potter","J.K Rollowings","Harper Collins", 0-306-40615-7, "Fiction",67734),
(82737,"the Half Blood Prince", "J.k Rollowings", "Hachette",0-061-96436-0,"Fiction",837);

INSERT INTO Member(member_id, Name_, Department, Membership_Date, Contact)
VALUES(63737,"Liam", "FYJC",'2024-01-15 08:24:17',555-0101),
(244748, "Sophia", "BSC SY",'2024-03-09 17:42:53',555-24967),
(898,"Harry","MSC FY",'2023-09-18 03:48:29',555-7777),
(80007,"Lucas", "SYJC",'2025-02-27 14:37:45', 555-3456);

INSERT INTO transaction(transaction_id, book_id, member_id, issue_date, return_date, Fine)
VALUES(58493,7238, 63737, '2025-07-01', '2025-07-15', 0.00),
(23841,64748, 244748 ,'2025-07-05', '2025-07-21', 2.50),
(98402,82737, 80007, '2025-07-10', '2025-07-30', 5.00),
(76125,7838, 898, '2025-07-03', '2025-07-04', 0.00);

select * from book;
select * from Member;
select * from transaction;

select Fine,book_id, member_id, issue_date, return_date
from transaction
where Fine > 0;

select Name_
from Member;

select Title
from book;

select Fine
from transaction;

SELECT Member.Name_, Book.Title, Transaction.Fine 
FROM Transaction
JOIN Member ON Transaction.Member_ID = Member.Member_ID
JOIN Book ON Transaction.Book_ID = Book.Book_ID
WHERE Transaction.Fine > 0;