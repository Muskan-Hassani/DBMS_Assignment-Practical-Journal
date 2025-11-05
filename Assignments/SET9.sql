create database cinema_booking;
use cinema_booking;

create table cinemas(
    cinemaid int primary key,
    name varchar(50),
    city varchar(50)
);

create table movies(
    movieid int primary key,
    title varchar(100),
    genre varchar(30),
    duration int
);

create table shows(
    showid int primary key,
    cinemaid int,
    movieid int,
    showdate date,
    showtime time,
    price decimal(10,2),
    foreign key(cinemaid) references cinemas(cinemaid),
    foreign key(movieid) references movies(movieid)
);

create table customers(
    customerid int primary key,
    name varchar(50),
    phone varchar(15),
    email varchar(100)
);

create table bookings(
    bookingid int primary key,
    showid int,
    customerid int,
    seats int,
    bookingdate date,
    status varchar(20),
    foreign key(showid) references shows(showid),
    foreign key(customerid) references customers(customerid)
);

create table payments(
    paymentid int primary key,
    bookingid int,
    amount decimal(10,2),
    method varchar(20),
    paymentdate date,
    foreign key(bookingid) references bookings(bookingid)
);

insert into cinemas values
(1,'inox','delhi'),
(2,'pvr','mumbai'),
(3,'carnival','kolkata'),
(4,'cinepolis','chennai'),
(5,'wave','lucknow');

insert into movies values
(101,'inception','sci-fi',148),
(102,'dangal','sports',161),
(103,'avengers','action',180),
(104,'pathaan','thriller',150),
(105,'3 idiots','comedy',170);

insert into shows values
(201,1,101,'2025-07-10','18:00',300.00),
(202,2,102,'2025-07-11','20:00',250.00),
(203,3,103,'2025-07-12','17:00',350.00),
(204,4,104,'2025-07-13','21:00',280.00),
(205,5,105,'2025-07-14','19:00',220.00);

insert into customers values
(301,'amit shah','9876543210','amit@gmail.com'),
(302,'priya nair','9988776655','priya@yahoo.com'),
(303,'rohan gupta','9123456789','rohan@hotmail.com'),
(304,'sneha das','8877665544','sneha@gmail.com'),
(305,'vikram singh','7766554433','vikram@gmail.com');

insert into bookings values
(401,201,301,2,'2025-07-05','confirmed'),
(402,202,302,4,'2025-07-06','pending'),
(403,203,303,3,'2025-07-07','cancelled'),
(404,204,304,5,'2025-07-08','confirmed'),
(405,205,305,2,'2025-07-09','confirmed');

insert into payments values
(501,401,600.00,'card','2025-07-05'),
(502,402,1000.00,'cash','2025-07-06'),
(503,403,1050.00,'upi','2025-07-07'),
(504,404,1400.00,'netbanking','2025-07-08'),
(505,405,440.00,'card','2025-07-09');

select * from movies where genre='action';
select * from shows where price>250;
select * from bookings where status='confirmed';
select * from cinemas where city='delhi';
select * from movies order by duration desc limit 3;
select customerid,count(*) from bookings group by customerid;
select cinemaid,count(*) from shows group by cinemaid;
select movieid,count(*) from shows group by movieid having count(*)>1;
select * from customers where customerid not in(select distinct customerid from bookings);
select * from payments where method='card';
select cinemaid,avg(price) from shows group by cinemaid;
select * from bookings where bookingdate>=date_sub(curdate(),interval 30 day);
select b.bookingid,c.name,m.title from bookings b join customers c on b.customerid=c.customerid join shows s on b.showid=s.showid join movies m on s.movieid=m.movieid;
select b.bookingid,p.amount from bookings b join payments p on b.bookingid=p.bookingid;
select * from shows where showdate='2025-07-12';
select s.showid,sum(p.amount) as revenue from payments p join bookings b on p.bookingid=b.bookingid join shows s on b.showid=s.showid group by s.showid;
select * from cinemas where cinemaid not in(select distinct cinemaid from shows);
select method,count(*) from payments group by method;
select customerid,sum(amount) from payments join bookings using(bookingid) group by customerid;
select * from bookings where status='pending';
select customerid,count(*) from bookings group by customerid order by count(*) desc limit 3;
select distinct genre from movies;
select distinct city from cinemas;
select year(showdate),month(showdate),count(*) from shows group by year(showdate),month(showdate);
select movieid,count(*) from bookings join shows using(showid) group by movieid order by count(*) desc limit 1;
