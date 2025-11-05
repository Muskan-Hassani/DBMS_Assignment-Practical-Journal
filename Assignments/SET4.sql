create database airline_reservation;

use airline_reservation;

create table airlines (
    airlineid int primary key,
    airlinename varchar(50),
    country varchar(50)
);

create table flights (
    flightid int primary key,
    airlineid int,
    source varchar(50),
    destination varchar(50),
    departuretime datetime,
    arrivaltime datetime,
    price decimal(10,2),
    foreign key (airlineid) references airlines(airlineid)
);

create table passengers (
    passengerid int primary key,
    name varchar(50),
    passportno varchar(20),
    nationality varchar(50),
    dob date
);

create table bookings (
    bookingid int primary key,
    flightid int,
    passengerid int,
    bookingdate date,
    seatno varchar(10),
    status varchar(20),
    foreign key (flightid) references flights(flightid),
    foreign key (passengerid) references passengers(passengerid)
);

create table payments (
    paymentid int primary key,
    bookingid int,
    amount decimal(10,2),
    paymentdate date,
    method varchar(20),
    foreign key (bookingid) references bookings(bookingid)
);

insert into airlines values
(1,'skyfly','india'),
(2,'cloudair','india'),
(3,'starwings','uae'),
(4,'nexus airlines','usa'),
(5,'orbit air','qatar');

insert into flights values
(101,1,'delhi','mumbai','2025-09-02 19:15:00','2025-09-02 21:15:00',5500.00),
(102,2,'delhi','chennai','2025-09-03 06:30:00','2025-09-03 09:15:00',7200.00),
(103,3,'dubai','london','2025-09-05 14:00:00','2025-09-05 18:30:00',25000.00),
(104,4,'new york','los angeles','2025-09-06 10:00:00','2025-09-06 13:45:00',15000.00),
(105,5,'doha','sydney','2025-09-08 21:00:00','2025-09-09 07:45:00',32000.00);

insert into passengers values
(201,'ava singh','zp12345','india','2002-05-17'),
(202,'ishaan mehta','zp22345','india','1999-10-23'),
(203,'liam carter','zp32345','usa','2001-03-08'),
(204,'camila reyes','zp42345','spain','1998-11-02'),
(205,'noah ali','zp52345','uae','1996-07-15');

insert into bookings values
(301,101,201,'2025-08-28','12a','confirmed'),
(302,102,202,'2025-08-29','14b','pending'),
(303,103,203,'2025-08-28','9c','confirmed'),
(304,104,204,'2025-08-25','22d','cancelled'),
(305,105,205,'2025-08-27','7f','confirmed');

insert into payments values
(401,301,5500.00,'2025-08-28','card'),
(402,302,7200.00,'2025-08-29','upi'),
(403,303,25000.00,'2025-08-28','netbanking'),
(404,304,15000.00,'2025-08-25','card'),
(405,305,32000.00,'2025-08-27','cash');

select *
from flights
where source = 'delhi'
and destination = 'mumbai';

select *
from flights
where time(departuretime) > '18:00:00';

select *
from passengers
where nationality = 'india';

select *
from bookings
where status = 'confirmed';

select *
from bookings
where passengerid = (
    select passengerid
    from passengers
    where name = 'ava singh'
);

select airlineid,count(*)
from flights
group by airlineid;

select passengerid,count(*)
from bookings
group by passengerid
having count(*) > 3;

select *
from flights
order by price desc
limit 1;

select *
from airlines
where country = 'usa';

select *
from bookings
where bookingdate >= date_sub(curdate(),interval 7 day);

select airlineid,avg(price)
from flights
group by airlineid;

select *
from passengers
where passengerid not in (
    select distinct passengerid
    from bookings
);

select *
from flights
where flightid not in (
    select distinct flightid
    from bookings
);

select *
from passengers
where passportno like 'm%';

select b.bookingid,p.name,f.source,f.destination
from bookings b
join passengers p on b.passengerid = p.passengerid
join flights f on b.flightid = f.flightid;

select *
from payments
order by amount desc
limit 5;

select flightid,count(*)
from bookings
group by flightid;

select *
from flights
where time(arrivaltime) < '10:00:00';

select f.flightid,f.source,f.destination,a.airlinename
from flights f
join airlines a on f.airlineid = a.airlineid;

select passengerid,count(*)
from bookings
group by passengerid,bookingdate
having count(*) > 1;

select method,sum(amount)
from payments
group by method;

select *
from bookings
where bookingdate >= date_sub(curdate(),interval 30 day);

select *
from flights
where price between 5000 and 10000;

select *
from passengers
where dob > '2000-01-01';

select *
from airlines
where airlineid not in (
    select distinct airlineid
    from flights
);
