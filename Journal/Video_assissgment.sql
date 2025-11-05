create database college;
create database abc_company;

drop database abc_company;

use college;

create table user (
    id int,
    uname varchar(20),
    age int,
    followers int
);

insert into user values
(1, 'adam', 13, 120),
(2, 'anna', 14, 150),
(3, 'john', 16, 200),
(4, 'sara', 18, 300),
(5, 'mike', 20, 250);

create table user_information1 (
    info_id int,
    user_id int,
    email varchar(50),
    phone varchar(15)
);

insert into user_information1 values
(101, 1, 'adam@email.com', '1111111111'),
(102, 2, 'anna@email.com', '2222222222'),
(103, 3, 'john@email.com', '3333333333'),
(104, 4, 'sara@email.com', '4444444444'),
(105, 5, 'mike@email.com', '5555555555');

select * from user;
select * from user_information1;

create database if not exists college;
create database if not exists instagram;

drop database if exists abc_company;

show databases;

select * from user order by age;
select * from user order by age desc;
select max(age) as max_age from user;
select min(age) as min_age from user;
select count(age) as count_age_16_plus from user where age >= 16;
select avg(followers) as avg_followers from user;
select sum(followers) as total_followers from user;
select age, count(id) as user_count from user group by age;
select age, max(followers) as max_followers from user group by age;
select uname, age, max(followers) as max_followers from user group by age;
