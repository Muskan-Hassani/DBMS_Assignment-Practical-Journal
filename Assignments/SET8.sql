create database food_delivery;
use food_delivery;

create table restaurants(
    restaurantid int primary key,
    name varchar(50),
    city varchar(50),
    rating decimal(2,1)
);

create table menu(
    itemid int primary key,
    restaurantid int,
    itemname varchar(50),
    category varchar(30),
    price decimal(10,2),
    foreign key(restaurantid) references restaurants(restaurantid)
);

create table customers(
    customerid int primary key,
    name varchar(50),
    phone varchar(15),
    address varchar(100)
);

create table orders(
    orderid int primary key,
    customerid int,
    restaurantid int,
    orderdate date,
    status varchar(20),
    foreign key(customerid) references customers(customerid),
    foreign key(restaurantid) references restaurants(restaurantid)
);

create table order_items(
    orderitemid int primary key,
    orderid int,
    itemid int,
    quantity int,
    foreign key(orderid) references orders(orderid),
    foreign key(itemid) references menu(itemid)
);

insert into restaurants values
(1,'spice villa','delhi',4.2),
(2,'ocean bites','mumbai',4.5),
(3,'curry house','kolkata',3.9),
(4,'green leaf','chennai',4.3),
(5,'royal taste','bangalore',4.1);

insert into menu values
(101,1,'paneer tikka','starter',250.00),
(102,1,'butter naan','main',50.00),
(103,2,'fish curry','main',350.00),
(104,3,'biryani','main',200.00),
(105,4,'salad bowl','starter',180.00),
(106,5,'chicken curry','main',300.00);

insert into customers values
(201,'amit shah','9876543210','delhi'),
(202,'priya nair','9988776655','mumbai'),
(203,'rohan gupta','9123456789','bangalore'),
(204,'sneha das','8877665544','kolkata'),
(205,'vikram singh','7766554433','chennai');

insert into orders values
(301,201,1,'2025-07-10','delivered'),
(302,202,2,'2025-07-11','delivered'),
(303,203,5,'2025-07-12','pending'),
(304,204,3,'2025-07-13','cancelled'),
(305,205,4,'2025-07-14','delivered');

insert into order_items values
(401,301,101,2),
(402,301,102,4),
(403,302,103,1),
(404,303,106,3),
(405,304,104,2),
(406,305,105,1);

select * from restaurants where city='delhi';
select * from menu where category='main';
select * from orders where status='delivered';
select * from menu order by price desc limit 3;
select * from customers where address like '%mumbai%';
select * from orders where restaurantid=1;
select restaurantid,count(*) from orders group by restaurantid;
select customerid,count(*) from orders group by customerid having count(*)>2;
select * from orders where orderdate>=date_sub(curdate(),interval 30 day);
select itemid,sum(quantity) from order_items group by itemid;
select restaurantid,avg(rating) from restaurants group by restaurantid;
select orderid,sum(quantity) from order_items group by orderid;
select * from restaurants where restaurantid not in(select distinct restaurantid from orders);
select o.orderid,c.name,r.name from orders o join customers c on o.customerid=c.customerid join restaurants r on o.restaurantid=r.restaurantid;
select oi.orderid,m.itemname,oi.quantity from order_items oi join menu m on oi.itemid=m.itemid;
select customerid,count(*) from orders where status='cancelled' group by customerid;
select r.restaurantid,sum(m.price*oi.quantity) as revenue from order_items oi join menu m on oi.itemid=m.itemid join orders o on oi.orderid=o.orderid join restaurants r on o.restaurantid=r.restaurantid group by r.restaurantid;
select distinct category from menu;
select c.customerid,sum(m.price*oi.quantity) as total_spent from customers c join orders o on c.customerid=o.customerid join order_items oi on o.orderid=oi.orderid join menu m on oi.itemid=m.itemid group by c.customerid order by total_spent desc limit 1;
select * from orders where status='pending';
select customerid,count(*) from orders group by customerid order by count(*) desc limit 3;
select restaurantid,count(distinct customerid) from orders group by restaurantid;
select m.itemid,count(*) as ordered_times from order_items oi join menu m on oi.itemid=m.itemid group by m.itemid order by ordered_times desc limit 1;
select * from customers where customerid not in(select distinct customerid from orders);
select year(orderdate),month(orderdate),count(*) from orders group by year(orderdate),month(orderdate);
