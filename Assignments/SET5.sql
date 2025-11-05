create database hotel_mgmt;

use hotel_mgmt;

create table hotels (
    hotelid int primary key,
    hotelname varchar(50),
    location varchar(50),
    rating decimal(2,1)
);

create table rooms (
    roomid int primary key,
    hotelid int,
    roomtype varchar(30),
    pricepernight decimal(10,2),
    availability varchar(20),
    foreign key (hotelid) references hotels(hotelid)
);

create table guests (
    guestid int primary key,
    name varchar(50),
    phone varchar(15),
    email varchar(100),
    address varchar(100)
);

create table reservations (
    reservationid int primary key,
    roomid int,
    guestid int,
    checkindate date,
    checkoutdate date,
    status varchar(30),
    foreign key (roomid) references rooms(roomid),
    foreign key (guestid) references guests(guestid)
);

create table payments (
    paymentid int primary key,
    reservationid int,
    amount decimal(10,2),
    paymentdate date,
    method varchar(20),
    foreign key (reservationid) references reservations(reservationid)
);

insert into hotels values
(1,'blue orchid','mumbai',4.3),
(2,'regal stay','delhi',4.1),
(3,'hilltop view','manali',3.8),
(4,'golden horizon','goa',4.6),
(5,'palm residency','chennai',4.0);

insert into rooms values
(101,1,'deluxe',3600.00,'available'),
(102,2,'suite',7200.00,'booked'),
(103,3,'standard',2600.00,'available'),
(104,4,'suite',8500.00,'booked'),
(105,5,'deluxe',4800.00,'available');

insert into guests values
(201,'nikhil sharma','9876543210','nikhilsh@gmail.com','mumbai'),
(202,'ayesha khan','9988776655','ayeshak@yahoo.com','delhi'),
(203,'rohan patel','9123456789','rohanp@gmail.com','ahmedabad'),
(204,'priya das','8899776654','priyad@hotmail.com','kolkata'),
(205,'arun nair','7766554433','arun.nair@gmail.com','goa');

insert into reservations values
(301,101,201,'2025-08-11','2025-08-15','checked-in'),
(302,102,202,'2025-08-20','2025-08-25','pending'),
(303,103,203,'2025-08-08','2025-08-10','checked-out'),
(304,104,204,'2025-08-05','2025-08-07','cancelled'),
(305,105,205,'2025-08-21','2025-08-27','pending');

insert into payments values
(401,301,14400.00,'2025-08-11','card'),
(402,302,36000.00,'2025-08-20','cash'),
(403,303,5200.00,'2025-08-08','upi'),
(404,304,25500.00,'2025-08-05','card'),
(405,305,28800.00,'2025-08-21','netbanking');

select *
from hotels
where location = 'mumbai';

select *
from rooms
where pricepernight > 3000;

select *
from rooms
where hotelid = 1
and availability = 'available';

select g.*
from guests g
join reservations r on g.guestid = r.guestid
where r.roomid in (
    select roomid
    from rooms
    where hotelid = 2
);

select *
from reservations
where status = 'checked-in';

select hotelid,roomtype,count(*)
from rooms
group by hotelid,roomtype;

select guestid,datediff(checkoutdate,checkindate) as nights
from reservations
having nights > 5;

select *
from rooms
order by pricepernight desc
limit 3;

select *
from reservations
where checkindate >= date_sub(curdate(),interval 30 day);

select guestid,count(*)
from reservations
group by guestid
having count(*) > 2;

select hotelid,avg(pricepernight)
from rooms
group by hotelid
having avg(pricepernight) > 4000;

select *
from guests
where address = 'delhi';

select *
from hotels h
where not exists (
    select 1
    from rooms rm
    join reservations r on r.roomid = rm.roomid
    where rm.hotelid = h.hotelid
);

select r.reservationid,g.name,h.hotelname,rm.roomtype
from reservations r
join guests g on r.guestid = g.guestid
join rooms rm on r.roomid = rm.roomid
join hotels h on rm.hotelid = h.hotelid;

select rm.hotelid,sum(p.amount)
from payments p
join reservations r on p.reservationid = r.reservationid
join rooms rm on r.roomid = rm.roomid
group by rm.hotelid;

select *
from reservations
where checkoutdate < checkindate;

select distinct method
from payments;

select *
from guests
where guestid not in (
    select distinct r.guestid
    from reservations r
    join payments p on r.reservationid = p.reservationid
);

select *
from reservations
order by checkindate;

select *
from hotels
where rating > 4;

select g.*
from guests g
join reservations r on g.guestid = r.guestid
join rooms rm on r.roomid = rm.roomid
where rm.roomtype = 'suite';

select *
from rooms
where availability = 'available'
and hotelid = (
    select hotelid
    from hotels
    where location = 'delhi'
);

select guestid,sum(datediff(checkoutdate,checkindate)) as totalnights
from reservations
group by guestid;

select *
from reservations r1
where exists (
    select 1
    from reservations r2
    where r1.roomid = r2.roomid
    and r1.reservationid <> r2.reservationid
    and r1.checkindate < r2.checkoutdate
    and r2.checkindate < r1.checkoutdate
);

select distinct location
from hotels;
