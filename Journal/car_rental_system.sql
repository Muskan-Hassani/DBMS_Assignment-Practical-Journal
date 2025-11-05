create database car_rental_system;
use car_rental_system;
create table Customer(
Customer_ID INT PRIMARY KEY, 
Name varchar(30), 
License_Number Varchar(10) UNIQUE, 
Contact varchar(12)
);
CREATE TABLE Car (
    Car_ID INT PRIMARY KEY,
    Model VARCHAR(100),
    Category VARCHAR(50),
    Manufacturer VARCHAR(100),
    Availability_Status ENUM('Available', 'Rented') DEFAULT 'Available'
);

CREATE TABLE Rental (
    Rental_ID INT PRIMARY KEY,
    Customer_ID INT,
    Car_ID INT,
    Rental_Date DATE,
    Return_Date DATE,
    Total_Amount DECIMAL(10,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Car_ID) REFERENCES Car(Car_ID)
);


CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50),
    Contact VARCHAR(20)
);

INSERT INTO Customer (Customer_ID, Name, License_Number, Contact) VALUES
(201, 'Amit Roy', 'DL12345', '9876543210'),
(202, 'Sara Khan', 'DL54321', '9123456789'),
(203, 'Neha Mehra', 'DL67890', '9988776655'),
(204, 'Rajiv Sinha', 'DL11122', '8765432109'),
(205, 'Ananya Das', 'DL33445', '9898989898'),
(206, 'Vikram Singh', 'DL55667', '9001122334'),
(207, 'Pooja Nair', 'DL77889', '9112233445');

INSERT INTO Car (Car_ID, Model, Category, Manufacturer, Availability_Status) VALUES
(301, 'Honda Civic', 'Sedan', 'Honda', 'Rented'),
(302, 'Hyundai Creta', 'SUV', 'Hyundai', 'Available'),
(303, 'Toyota Fortuner', 'SUV', 'Toyota', 'Rented'),
(304, 'Maruti Swift', 'Hatchback', 'Maruti', 'Available'),
(305, 'Mahindra XUV700', 'SUV', 'Mahindra', 'Available'),
(306, 'Kia Seltos', 'SUV', 'Kia', 'Rented'),
(307, 'Skoda Slavia', 'Sedan', 'Skoda', 'Available');

INSERT INTO Rental (Rental_ID, Customer_ID, Car_ID, Rental_Date, Return_Date, Total_Amount) VALUES
(401, 201, 301, '2025-07-15', NULL, 5000.00),       
(402, 202, 303, '2025-07-10', NULL, 8000.00),       
(403, 203, 302, '2025-06-01', '2025-06-05', 4000.00),
(404, 204, 304, '2025-06-10', '2025-06-15', 3500.00),
(405, 205, 305, '2025-07-01', NULL, 7500.00),       
(406, 206, 306, '2025-07-05', NULL, 6200.00),       
(407, 207, 307, '2025-06-20', '2025-06-25', 3900.00);

INSERT INTO Staff (Staff_ID, Name, Role, Contact) VALUES
(501, 'Ravi Kumar', 'Manager', '9871001000'),
(502, 'Priya Mehta', 'Receptionist', '9812345678'),
(503, 'Karan Kapoor', 'Driver', '9890001100'),
(504, 'Swati Desai', 'Cleaner', '9777777777'),
(505, 'Anil Verma', 'Technician', '9765432100'),
(506, 'Divya Sharma', 'Receptionist', '9123456123'),
(507, 'Harish Rao', 'Driver', '9009988776');

SELECT Car.Model, rental.Rental_Date, rental.Return_Date
FROM Rental 
JOIN Car ON rental.Car_ID = car.Car_ID
WHERE rental.Return_Date IS NULL;

