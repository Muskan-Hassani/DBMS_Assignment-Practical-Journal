create database inventory_mgmt;
use inventory_mgmt;

create table suppliers(
    supplierid int primary key,
    suppliername varchar(50),
    contact varchar(20),
    city varchar(50)
);

create table categories(
    categoryid int primary key,
    categoryname varchar(50)
);

create table products(
    productid int primary key,
    productname varchar(50),
    categoryid int,
    supplierid int,
    price decimal(10,2),
    stock int,
    foreign key(categoryid) references categories(categoryid),
    foreign key(supplierid) references suppliers(supplierid)
);

create table purchases(
    purchaseid int primary key,
    productid int,
    quantity int,
    purchasedate date,
    supplierid int,
    foreign key(productid) references products(productid),
    foreign key(supplierid) references suppliers(supplierid)
);

create table sales(
    saleid int primary key,
    productid int,
    quantity int,
    saledate date,
    customername varchar(50),
    foreign key(productid) references products(productid)
);

insert into suppliers values
(1,'alpha traders','9876543210','delhi'),
(2,'bright supplies','9988776655','mumbai'),
(3,'city mart','8877665544','kolkata'),
(4,'global exports','7766554433','delhi'),
(5,'royal deals','6655443322','chennai');

insert into categories values
(1,'electronics'),
(2,'furniture'),
(3,'stationery'),
(4,'clothing'),
(5,'groceries');

insert into products values
(101,'laptop',1,1,45000.00,12),
(102,'sofa',2,2,18000.00,4),
(103,'notebook pack',3,3,120.00,40),
(104,'t-shirt',4,4,600.00,20),
(105,'rice bag',5,5,1200.00,8);

insert into purchases values
(201,101,5,'2025-07-01',1),
(202,102,3,'2025-07-03',2),
(203,103,25,'2025-07-05',3),
(204,104,10,'2025-07-07',4),
(205,105,6,'2025-07-08',5);

insert into sales values
(301,101,2,'2025-07-10','amit shah'),
(302,103,5,'2025-07-11','priya nair'),
(303,104,3,'2025-07-12','rohan gupta'),
(304,105,4,'2025-07-15','sneha das'),
(305,101,1,'2025-07-16','vikram singh');

select * from products where stock<10;
select * from products order by price desc limit 5;
select * from suppliers where city='delhi';
select * from products where supplierid=(select supplierid from suppliers where suppliername='bright supplies');
select categoryid,count(*) from products group by categoryid;
select sum(quantity) from purchases where productid=101;
select * from products where productid not in(select distinct productid from sales);
select * from sales where saledate>=date_sub(curdate(),interval 7 day);
select productid,sum(quantity) from sales group by productid having sum(quantity)>50;
select supplierid,count(distinct productid) from products group by supplierid having count(distinct productid)>5;
select categoryid,avg(price) from products group by categoryid;
select productid,sum(quantity) as total_sold from sales group by productid order by total_sold desc limit 1;
select * from categories where categoryid not in(select distinct categoryid from products);
select s.saleid,p.productname from sales s join products p on s.productid=p.productid;
select pu.purchaseid,su.suppliername from purchases pu join suppliers su on pu.supplierid=su.supplierid;
select * from suppliers where supplierid not in(select distinct supplierid from purchases);
select productid,max(purchasedate) from purchases group by productid;
select customername,count(distinct productid) from sales group by customername having count(distinct productid)>3;
select sum(price*stock) from products;
select * from products order by stock desc limit 1;
select customername,count(*) from sales group by customername;
select customername,sum(p.price*s.quantity) as total_value from sales s join products p on s.productid=p.productid group by customername order by total_value desc limit 3;
select year(saledate),month(saledate),sum(quantity) from sales group by year(saledate),month(saledate);
select * from products where productid in(select productid from purchases) and productid not in(select productid from sales);
select supplierid,count(distinct categoryid) from products group by supplierid having count(distinct categoryid)>1;
