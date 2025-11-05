create database online_bookstore;
use online_bookstore;

create table authors(
    authorid int primary key,
    name varchar(50),
    country varchar(50),
    dob date
);

create table categories(
    categoryid int primary key,
    categoryname varchar(50)
);

create table books(
    bookid int primary key,
    title varchar(100),
    authorid int,
    categoryid int,
    price decimal(10,2),
    stock int,
    publishedyear year,
    foreign key(authorid) references authors(authorid),
    foreign key(categoryid) references categories(categoryid)
);

create table customers(
    customerid int primary key,
    name varchar(50),
    email varchar(100) unique,
    phone varchar(15),
    address varchar(100)
);

create table orders(
    orderid int primary key,
    customerid int,
    orderdate date,
    status varchar(50),
    foreign key(customerid) references customers(customerid)
);

create table order_details(
    orderid int,
    bookid int,
    quantity int,
    primary key(orderid, bookid),
    foreign key(orderid) references orders(orderid),
    foreign key(bookid) references books(bookid)
);

insert into authors values
(1,'Ravi Kumar','India','1978-04-11'),
(2,'John Smith','USA','1982-12-22'),
(3,'Meera Joshi','India','1990-05-07'),
(4,'Alex Brown','UK','1985-07-17'),
(5,'Sana Patel','India','1975-09-03');

insert into categories values
(1,'Horror'),
(2,'Comedy'),
(3,'Romance'),
(4,'Science Fiction'),
(5,'Biography');

insert into books values
(101,'Whispers in the Dark',1,1,450.00,12,2012),
(102,'Laugh Out Loud',2,2,620.50,4,2019),
(103,'Love in Paris',3,3,299.99,9,2016),
(104,'Stars Beyond Earth',4,4,780.00,15,2018),
(105,'Life of a Legend',5,5,1200.00,3,2020);

insert into customers values
(201,'Amit Shah','amit123@gmail.com','9998877661','Mumbai, Maharashtra'),
(202,'Rohini Nair','rohini.nair@gmail.com','9922334455','Pune, Maharashtra'),
(203,'Karan Mehta','karan.mehta@gmail.com','9876543210','Delhi, Delhi'),
(204,'Sophia Dsouza','sophia_d@gmail.com','8899776655','Goa, Goa'),
(205,'Vikram Rao','vikramrao@gmail.com','7788996655','Chennai, Tamil Nadu');

insert into orders values
(301,201,'2025-07-10','SENT'),
(302,202,'2025-07-15','PENDING'),
(303,203,'2025-07-20','NOT SENT'),
(304,204,'2025-07-22','SENT'),
(305,205,'2025-07-25','PENDING');

insert into order_details values
(301,101,1),
(301,102,2),
(302,103,1),
(303,104,3),
(305,105,2);

select * 
from books 
where price > 500;

select * 
from books 
where publishedyear > 2015;

select *
from customers 
where address like '%mumbai%';

select title 
from books 
where authorid = (select authorid from authors where name='Ravi Kumar');

select * 
from books 
order by price desc 
limit 3;

select c.categoryname, count(b.bookid) 
from categories c 
left join books b on c.categoryid=b.categoryid 
group by c.categoryname;

select * 
from orders 
where orderdate >= date_sub(curdate(),interval 30 day);

select c.name, count(o.orderid) 
from customers c 
left join orders o on c.customerid=o.customerid 
group by c.name;

select * 
from books 
where stock < 10;

select a.name 
from authors a 
join books b on a.authorid=b.authorid 
group by a.authorid,a.name 
having count(b.bookid)>5;

select b.title,c.categoryname 
from books b 
join categories c on b.categoryid=c.categoryid;

select od.orderid,sum(b.price*od.quantity) 
from order_details od 
join books b on od.bookid=b.bookid 
where od.orderid=301 
group by od.orderid;

select * 
from orders 
where status='PENDING';

select * 
from authors 
where country='India';

select * 
from customers 
where customerid not in(select customerid from orders);

select c.categoryname,avg(b.price) 
from categories c 
join books b on c.categoryid=b.categoryid 
group by c.categoryname;


select * 
from books 
order by publishedyear desc;

select o.* 
from orders o 
join (select customerid,max(orderdate) as recent from orders group by customerid) t on o.customerid=t.customerid and o.orderdate=t.recent;

select c.categoryname 
from categories c 
left join books b on c.categoryid=b.categoryid 
where b.bookid is null;

select distinct substring_index(address,',',1) as city 
from customers;

select count(*) from customers;

select o.orderid,c.name,o.orderdate 
from orders o 
join customers c on o.customerid=c.customerid;

select c.categoryname,min(b.price) 
from categories c 
join books b on c.categoryid=b.categoryid 
group by c.categoryname;

select distinct cu.name 
from customers cu 
join orders o on cu.customerid=o.customerid 
join order_details od on o.orderid=od.orderid 
join books b on od.bookid=b.bookid 
join authors a on b.authorid=a.authorid 
where a.name='Meera Joshi';



select * 
from books 
where title like '%guide%';
