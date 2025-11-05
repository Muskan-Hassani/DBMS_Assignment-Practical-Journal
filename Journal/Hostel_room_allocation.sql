create database Hostel_room_allocation;
use car_rental_system;
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender ENUM('Male', 'Female', 'Other'),
    Course VARCHAR(100),
    Year INT
);

CREATE TABLE Room (
    Room_ID INT PRIMARY KEY,
    Room_Type VARCHAR(50),
    Capacity INT,
    Occupancy_Status ENUM('Vacant', 'Occupied') DEFAULT 'Vacant'
);

CREATE TABLE Allocation (
    Allocation_ID INT PRIMARY KEY,
    Student_ID INT,
    Room_ID INT,
    CheckIn_Date DATE,
    CheckOut_Date DATE,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

INSERT INTO Student (Student_ID, Name, Gender, Course, Year) 
VALUES(1001, 'Abhishek Sahani', 'Male', 'B.Tech', 2),
(1002, 'Neha Pawar', 'Female', 'B.Sc AMC', 3),
(1003, 'Nafsiha Shiekh', 'Female', 'B.Sc DS', 1),
(1004, 'Sneha Patil', 'Female', 'M.Sc AMC', 1),
(1005, 'Krishna Vyas', 'Male', 'B.Tech', 4),
(1006, 'Dev Das', 'Female', 'B.Sc Chemistry', 1),
(1007, 'Atharva Mehta', 'Male', 'BFA', 2),
(1008, 'Sanea Lakhotia', 'Female', 'BBA', 3),
(1009, 'Karan Joshi', 'Male', 'B.Sc Math', 1);

INSERT INTO Room (Room_ID, Room_Type, Capacity, Occupancy_Status)
VALUES(201, 'Single', 1, 'Occupied'),
(202, 'Double', 2, 'Occupied'),
(203, 'Triple', 3, 'Occupied'),
(204, 'Double', 2, 'Occupied'),
(205, 'Single', 1, 'Vacant'),
(206, 'Triple', 3, 'Occupied'),
(207, 'Single', 1, 'Vacant'),
(208, 'Triple', 2, 'Occupied'),
(209, 'Double', 2, 'Vacant');

INSERT INTO Allocation (Allocation_ID, Student_ID, Room_ID, CheckIn_Date, CheckOut_Date)
VALUES(301, 1001, 201, '2025-07-01', NULL),       
(302, 1002, 202, '2025-06-20', '2025-07-10'),       
(303, 1003, 202, '2023-06-20', '2024-09-21'),       
(304, 1004, 204, '2022-07-10','2025-07-10'),      
(305, 1005, 206, '2022-03-01', '2023-07-10'),
(306, 1006, 206, '2025-01-01', NULL),      
(307, 1007, 206, '2025-01-01', '2025-03-17'),       
(308, 1008, 208, '2025-04-05', NULL),    
(309, 1009, 208, '2024-09-05', '2024-12-29');       

SELECT student.Name, room.Room_ID, room.Room_Type
FROM Allocation 
JOIN Student ON allocation.Student_ID = student.Student_ID
JOIN Room ON allocation.Room_ID = room.Room_ID
WHERE allocation.CheckOut_Date IS NULL;

