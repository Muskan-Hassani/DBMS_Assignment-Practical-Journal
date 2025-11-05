create database elearning;
use elearning;

create table instructors(
    instructorid int primary key,
    name varchar(50),
    email varchar(100),
    expertise varchar(50)
);

create table courses(
    courseid int primary key,
    title varchar(100),
    category varchar(50),
    instructorid int,
    price decimal(10,2),
    foreign key(instructorid) references instructors(instructorid)
);

create table students(
    studentid int primary key,
    name varchar(50),
    email varchar(100),
    city varchar(50)
);

create table enrollments(
    enrollmentid int primary key,
    courseid int,
    studentid int,
    enrolldate date,
    status varchar(20),
    foreign key(courseid) references courses(courseid),
    foreign key(studentid) references students(studentid)
);

create table payments(
    paymentid int primary key,
    enrollmentid int,
    amount decimal(10,2),
    method varchar(20),
    paymentdate date,
    foreign key(enrollmentid) references enrollments(enrollmentid)
);

insert into instructors values
(1,'rakesh kumar','rakesh@edu.com','data science'),
(2,'emily stone','emily@edu.com','literature'),
(3,'john miller','john@edu.com','programming'),
(4,'anita desai','anita@edu.com','history'),
(5,'carlos diaz','carlos@edu.com','mathematics');

insert into courses values
(101,'python basics','programming',3,2000.00),
(102,'modern poetry','literature',2,1500.00),
(103,'data analysis','data science',1,3000.00),
(104,'world history','history',4,1800.00),
(105,'algebra fundamentals','mathematics',5,1200.00);

insert into students values
(201,'amit shah','amit@gmail.com','delhi'),
(202,'priya nair','priya@yahoo.com','mumbai'),
(203,'rohan gupta','rohan@hotmail.com','bangalore'),
(204,'sneha das','sneha@gmail.com','kolkata'),
(205,'vikram singh','vikram@gmail.com','chennai');

insert into enrollments values
(301,101,201,'2025-07-01','completed'),
(302,102,202,'2025-07-02','active'),
(303,103,203,'2025-07-03','completed'),
(304,104,204,'2025-07-04','dropped'),
(305,105,205,'2025-07-05','active');

insert into payments values
(401,301,2000.00,'card','2025-07-01'),
(402,302,1500.00,'upi','2025-07-02'),
(403,303,3000.00,'netbanking','2025-07-03'),
(404,304,1800.00,'cash','2025-07-04'),
(405,305,1200.00,'card','2025-07-05');

select * from courses where category='programming';
select * from courses order by price desc limit 3;
select * from instructors where expertise='history';
select * from students where city='delhi';
select * from enrollments where status='completed';
select courseid,count(*) from enrollments group by courseid;
select instructorid,count(*) from courses group by instructorid;
select studentid,count(*) from enrollments group by studentid having count(*)>1;
select * from students where studentid not in(select distinct studentid from enrollments);
select * from payments where method='card';
select courseid,avg(amount) from payments join enrollments using(enrollmentid) group by courseid;
select * from enrollments where enrolldate>=date_sub(curdate(),interval 30 day);
select e.enrollmentid,s.name,c.title from enrollments e join students s on e.studentid=s.studentid join courses c on e.courseid=c.courseid;
select e.enrollmentid,p.amount from enrollments e join payments p on e.enrollmentid=p.enrollmentid;
select * from courses where price between 1000 and 2500;
select c.courseid,sum(p.amount) as revenue from payments p join enrollments e on p.enrollmentid=e.enrollmentid join courses c on e.courseid=c.courseid group by c.courseid;
select * from instructors where instructorid not in(select distinct instructorid from courses);
select method,count(*) from payments group by method;
select studentid,sum(amount) from payments join enrollments using(enrollmentid) group by studentid;
select * from enrollments where status='active';
select studentid,count(*) from enrollments group by studentid order by count(*) desc limit 3;
select distinct category from courses;
select distinct city from students;
select year(enrolldate),month(enrolldate),count(*) from enrollments group by year(enrolldate),month(enrolldate);
select courseid,count(*) from enrollments group by courseid order by count(*) desc limit 1;
