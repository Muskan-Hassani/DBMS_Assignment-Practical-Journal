create database library_mgmt;
use library_mgmt;

create table authors(
    authorid int primary key,
    name varchar(50),
    nationality varchar(50)
);

create table books(
    bookid int primary key,
    title varchar(100),
    authorid int,
    category varchar(50),
    price decimal(10,2),
    stock int,
    foreign key(authorid) references authors(authorid)
);

create table members(
    memberid int primary key,
    name varchar(50),
    email varchar(100),
    phone varchar(15),
    address varchar(100)
);

create table loans(
    loanid int primary key,
    bookid int,
    memberid int,
    issuedate date,
    returndate date,
    status varchar(20),
    foreign key(bookid) references books(bookid),
    foreign key(memberid) references members(memberid)
);

create table fines(
    fineid int primary key,
    loanid int,
    amount decimal(10,2),
    paymentstatus varchar(20),
    foreign key(loanid) references loans(loanid)
);

insert into authors values
(1,'rakesh kumar','india'),
(2,'emily stone','uk'),
(3,'john miller','usa'),
(4,'anita desai','india'),
(5,'carlos diaz','spain');

insert into books values
(101,'space odyssey',1,'science fiction',450.00,6),
(102,'the lost city',2,'adventure',600.00,4),
(103,'love beyond',3,'romance',320.00,10),
(104,'indian history',4,'history',550.00,3),
(105,'world of math',5,'education',250.00,8);

insert into members values
(201,'amit shah','amit@gmail.com','9876543210','delhi'),
(202,'priya nair','priya@yahoo.com','9988776655','mumbai'),
(203,'rohan gupta','rohan@hotmail.com','9123456789','bangalore'),
(204,'sneha das','sneha@gmail.com','8877665544','kolkata'),
(205,'vikram singh','vikram@gmail.com','7766554433','chennai');

insert into loans values
(301,101,201,'2025-07-01','2025-07-10','returned'),
(302,102,202,'2025-07-05','2025-07-20','overdue'),
(303,103,203,'2025-07-08','2025-07-18','returned'),
(304,104,204,'2025-07-12','2025-07-25','pending'),
(305,105,205,'2025-07-15','2025-07-30','returned');

insert into fines values
(401,302,200.00,'unpaid'),
(402,304,150.00,'paid'),
(403,305,100.00,'unpaid'),
(404,301,50.00,'paid'),
(405,303,0.00,'paid');

select * from books where category='science fiction';
select * from books where stock<5;
select * from loans where status='overdue';
select * from books order by price desc limit 3;
select * from authors where nationality='india';
select * from books where authorid=(select authorid from authors where name='emily stone');
select category,count(*) from books group by category;
select memberid,count(*) from loans group by memberid having count(*)>5;
select * from loans where status='returned';
select * from members where memberid not in(select distinct memberid from loans);
select * from fines where paymentstatus='unpaid';

select l.memberid,sum(f.amount) as total_fines
from fines f
join loans l on f.loanid=l.loanid
group by l.memberid;

select * from loans where issuedate>=date_sub(curdate(),interval 30 day);
select distinct m.name from members m join loans l on m.memberid=l.memberid join books b on l.bookid=b.bookid where b.category='romance';
select authorid,count(*) from books group by authorid having count(*)>3;
select * from books where price between 200 and 500;
select avg(amount) from fines;
select * from members where phone like '9%';
select l.loanid,b.title,m.name from loans l join books b on l.bookid=b.bookid join members m on l.memberid=m.memberid;
select * from books where title like '%history%';
select l.memberid,count(*) from fines f join loans l on f.loanid=l.loanid where f.paymentstatus='unpaid' group by l.memberid having count(*)>1;
select * from books where bookid not in(select distinct bookid from loans);
select bookid,count(*) from loans group by bookid order by count(*) desc limit 1;
select memberid,count(*) from loans group by memberid order by count(*) desc limit 5;
select distinct category from books;
