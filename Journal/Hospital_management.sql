create database Hospital_management_system;
use Hospital_management_system;
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Contact VARCHAR(15),
    Address VARCHAR(255)
);


CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    Contact VARCHAR(15)
);

CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Date DATE,
    Time TIME,
    Status ENUM('Pending', 'Completed', 'Cancelled'),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);


INSERT INTO Patient (Patient_ID, Name, DOB, Gender, Contact, Address) 
VALUES(101, 'Aarav Mehta', '2000-05-12', 'Male', '9876543210', 'Mumbai'),
(102, 'Isha Roy', '1998-11-23', 'Female', '9123456789', 'Delhi'),
(103, 'Rohan Gupta', '1995-03-15', 'Male', '9988776655', 'Chennai'),
(104, 'Priya Nair', '2001-07-09', 'Female', '9765432101', 'Kochi'),
(105, 'Aditya Verma', '1990-12-31', 'Male', '9001122334', 'Lucknow'),
(106, 'Simran Kaur', '1999-08-17', 'Female', '9112233445', 'Amritsar'),
(107, 'Kabir Singh', '1987-04-25', 'Male', '9871001000', 'Hyderabad'),
(108, 'Anjali Desai', '1996-06-30', 'Female', '9812345678', 'Pune'),
(109, 'Yash Patel', '1992-02-11', 'Male', '9890001100', 'Ahmedabad');

INSERT INTO Doctor (Doctor_ID, Name, Specialization, Contact) 
VALUES(101, 'Dr. Rakesh Sharma', 'Cardiologist', '8888888888'),
(99, 'Dr. Neeta Rao', 'Dermatologist', '8777777777'),
(35, 'Dr. Arjun Sen', 'Neurologist', '8666666666'),
(204, 'Dr. Kavita Joshi', 'Gynecologist', '8555555555'),
(189, 'Dr. Manish Patel', 'Orthopedic', '8444444444'),
(11, 'Dr. Shreya Mehta', 'Pediatrician', '8333333333'),
(78, 'Dr. Vikram Reddy', 'ENT', '8222222222'),
(94, 'Dr. Sonal Mishra', 'Psychiatrist', '8111111111'),
(69, 'Dr. Ankit Shah', 'General Physician', '8000000000');


INSERT INTO Appointment (Appointment_ID, Patient_ID, Doctor_ID, Date, Time, Status) VALUES
(901, 101, 101, '2025-07-10', '10:00:00', 'Completed'),
(13, 102, 69, '2025-07-26', '11:30:00', 'Pending'),
(303, 103, 94, '2025-07-11', '09:15:00', 'Cancelled'),
(784, 104, 78, '2025-07-24', '14:00:00', 'Pending'),
(305, 105, 11, '2025-07-15', '12:45:00', 'Completed'),
(336, 106, 189, '2025-07-22', '13:30:00', 'Pending'),
(127, 107, 99, '2025-06-26', '15:00:00', 'Completed'),
(18, 108, 35, '2025-07-27', '11:00:00', 'Cancelled'),
(309, 109, 204, '2025-07-28', '10:15:00', 'Pending');
      

SELECT patient.Name AS Patient, Appointment.Date, Appointment.Time
FROM Appointment 
JOIN Patient ON Appointment.Patient_ID = Patient.Patient_ID
WHERE Appointment.Doctor_ID = 101 AND Appointment.Date >= CURRENT_DATE;




