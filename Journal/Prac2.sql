create database online_bookstore_ms;
use online_bookstore_ms;

create table authors (
  authorid int primary key,
  name varchar(100) not null,
  country varchar(50),
  dob date
);

create table categories (
  categoryid int primary key,
  categoryname varchar(100) unique
);

create table books (
  bookid int primary key,
  title varchar(200) unique,
  authorid int,
  categoryid int,
  price decimal(10,2),
  stock int,
  publishedyear year default (year(curdate())),
  constraint chk_price check (price > 0),
  constraint chk_stock check (stock >= 0),
  foreign key (authorid) references authors(authorid),
  foreign key (categoryid) references categories(categoryid)
);

create table customers (
  customerid int primary key,
  name varchar(100) not null,
  email varchar(100) unique,
  phone varchar(10),
  address varchar(255)
);

alter table customers add constraint chk_phone check (phone regexp '^[789]');
alter table customers modify phone varchar(10) not null;
alter table customers add dateofbirth date;

create table orders (
  orderid int primary key,
  customerid int,
  orderdate date,
  status varchar(50) default 'pending',
  foreign key (customerid) references customers(customerid)
);

create table orderdetails (
  orderid int,
  bookid int,
  quantity int,
  price decimal(10,2),
  primary key (orderid, bookid),
  constraint chk_quantity check (quantity > 0),
  constraint chk_order_price check (price > 0.01),
  foreign key (orderid) references orders(orderid),
  foreign key (bookid) references books(bookid)
);

create table payments (
  paymentid int primary key,
  orderid int,
  amount decimal(10,2),
  paymentdate date,
  method varchar(50) default 'cash',
  foreign key (orderid) references orders(orderid)
);

alter table books add isbn varchar(20);
alter table books add constraint uc_isbn unique (isbn);
alter table books modify stock tinyint;
alter table books rename column publishedyear to yearpublished;
alter table customers drop column dateofbirth;

create table deliveryagents (
  agentid int primary key,
  name varchar(100),
  phone varchar(10) unique,
  region varchar(10) default 'north',
  constraint chk_region check (region in ('north', 'south', 'east', 'west'))
  
);
alter table orders add deliveryagentid int;
alter table orders add constraint fk_delivery foreign key (deliveryagentid) references deliveryagents(agentid);
alter table orders drop foreign key fk_delivery;
alter table orderdetails add discount decimal(5,2) default 0;
alter table orderdetails alter discount drop default;
alter table books drop index uc_isbn;
alter table books drop check chk_price;



alter table deliveryagents add email varchar(100) unique;
alter table deliveryagents modify phone varchar(10);
alter table deliveryagents drop column email;
rename table deliveryagents to deliveryteam;
alter table deliveryteam drop check chk_region;

alter table deliveryteam rename column region to assignedregion;
truncate table deliveryteam;
truncate table payments;
truncate table orderdetails;
drop table payments;
drop table deliveryteam;

rename table books to bookinventory;
rename table customers to clients;
alter table clients rename column name to fullname;
alter table bookinventory rename column title to booktitle;
rename table bookinventory to books;
alter table orderdetails drop foreign key orderdetails_ibfk_1;
alter table orderdetails drop foreign key orderdetails_ibfk_2;

create view topsellingbooks as
select b.bookid, b.booktitle, sum(od.quantity) as totalsold
from books b
join orderdetails od on b.bookid = od.bookid
group by b.bookid, b.booktitle
order by totalsold desc;

alter table payments alter column method set default 'card';

create table ordernotes (
  noteid int primary key,
  note text not null
);

create table returnrequests (
  returnid int primary key,
  orderid int,
  reason varchar(255),
  status varchar(50) default 'pending',
  foreign key (orderid) references orders(orderid)
);

alter table returnrequests add returndate date;
alter table returnrequests drop column returndate;
alter table returnrequests add constraint fk_return_order foreign key (orderid) references orders(orderid);
alter table returnrequests drop foreign key fk_return_order;

drop table books;
create table books (
  bookid int primary key,
  title varchar(200) unique,
  authorid int,
  categoryid int,
  price decimal(10,2),
  stock int,
  publishedyear year default (year(curdate())),
  constraint chk_price2 check (price > 0),
  constraint chk_stock2 check (stock >= 0),
  foreign key (authorid) references authors(authorid),
  foreign key (categoryid) references categories(categoryid)
);

create table wishlists (
  customerid int,
  bookid int,
  primary key (customerid, bookid),
  foreign key (customerid) references customers(customerid),
  foreign key (bookid) references books(bookid)
);

alter table wishlists add dateadded date;
alter table wishlists drop column dateadded;
rename table wishlists to customerwishlists;
rename table customerwishlists to wishlists;



alter table books add edition varchar(20) default 'first';
alter table books modify edition varchar(50);
alter table books drop column edition;

create table deliveryagents (
  agentid int primary key,
  name varchar(100),
  phone varchar(10) unique,
  region varchar(10) default 'north',
  constraint chk_region check (region in ('north', 'south', 'east', 'west'))
  
);

create table deliverylogs (
  logid int primary key,
  deliveryagentid int,
  date date,
  status varchar(20),
  foreign key (deliveryagentid) references deliveryagents(agentid)
);

alter table deliverylogs add comments text;
alter table deliverylogs drop column comments;
alter table deliverylogs add constraint chk_status check (status in ('delivered','pending','failed'));
alter table deliverylogs drop check chk_status;

alter table books add rating decimal(2,1),
  add constraint chk_rating check (rating between 1 and 5);
alter table books modify rating decimal(3,1);
alter table books drop column rating;

create table bookreviews (
  reviewid int primary key,
  bookid int,
  customerid int,
  reviewtext text,
  foreign key (bookid) references books(bookid),
  foreign key (customerid) references customers(customerid)
);

alter table bookreviews add stars int,
  add constraint chk_stars check (stars between 1 and 5);
alter table bookreviews modify stars int null;
drop table bookreviews;

create table bookreviews (
  reviewid int primary key,
  bookid int,
  customerid int,
  reviewtext text,
  foreign key (bookid) references books(bookid),
  foreign key (customerid) references customers(customerid)
);

alter table bookreviews add constraint fk_book foreign key (bookid) references books(bookid);
alter table bookreviews add constraint fk_customer foreign key (customerid) references customers(customerid);
alter table bookreviews drop foreign key fk_book;
alter table bookreviews drop foreign key fk_customer;
drop table bookreviews;

create table coupons (
  couponid int primary key,
  code varchar(50) unique,
  discount int,
  expirydate date
);

alter table coupons add status varchar(20) default 'active';
alter table coupons add constraint chk_discount check (discount between 1 and 50);
alter table coupons drop check chk_discount;
alter table coupons drop column status;
