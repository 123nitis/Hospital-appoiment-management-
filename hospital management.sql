MySQL Shell 8.0.35

Copyright (c) 2016, 2023, Oracle and/or its affiliates.
Oracle is a registered trademark of Oracle Corporation and/or its affiliates.
Other names may be trademarks of their respective owners.

Type '\help' or '\?' for help; '\quit' to exit.
 MySQL  JS > \sql
Switching to SQL mode... Commands end with ;
 MySQL  SQL > \connect root@localhost:3306
Creating a session to 'root@localhost:3306'
Fetching global names for auto-completion... Press ^C to stop.
Your MySQL connection id is 20
Server version: 8.0.35 MySQL Community Server - GPL
No default schema selected; type \use <schema> to set one.
 MySQL  localhost:3306 ssl  SQL > CREATE DATABASE IF NOT EXISTS hospital_management_system;
Query OK, 1 row affected (0.0079 sec)
 MySQL  localhost:3306 ssl  SQL > USE hospital_management_system;
Default schema set to `hospital_management_system`.
Fetching global names, object names from `hospital_management_system` for auto-completion... Press ^C to stop.
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- For a completely fresh setup, run this section only
Query OK, 0 rows affected (0.0006 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- if you want to reset this project database:
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- DROP DATABASE IF EXISTS hospital_management_system;
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- CREATE DATABASE hospital_management_system;
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- USE hospital_management_system;
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 1. CREATE DEPARTMENTS
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE TABLE departments (
                                                           ->     department_id INT AUTO_INCREMENT PRIMARY KEY,
                                                           ->     department_name VARCHAR(100) NOT NULL UNIQUE,
                                                           ->     floor_number INT NOT NULL,
                                                           ->     contact_number VARCHAR(15) UNIQUE,
                                                           ->     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                                           ->     CHECK (floor_number BETWEEN 0 AND 20)
                                                           -> );
Query OK, 0 rows affected (0.0726 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 2. CREATE PATIENTS
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE TABLE patients (
                                                           ->     patient_id INT AUTO_INCREMENT PRIMARY KEY,
                                                           ->     patient_name VARCHAR(100) NOT NULL,
                                                           ->     gender ENUM('MALE','FEMALE','OTHER') NOT NULL,
                                                           ->     date_of_birth DATE NOT NULL,
                                                           ->     phone VARCHAR(15) NOT NULL UNIQUE,
                                                           ->     email VARCHAR(100) UNIQUE,
                                                           ->     address VARCHAR(255) NOT NULL,
                                                           ->     blood_group VARCHAR(10) DEFAULT 'UNKNOWN',
                                                           ->     registration_date DATE DEFAULT (CURRENT_DATE)
                                                           -> );
Query OK, 0 rows affected (0.0628 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 3. CREATE DOCTORS
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE TABLE doctors (
                                                           ->     doctor_id INT AUTO_INCREMENT PRIMARY KEY,
                                                           ->     department_id INT NOT NULL,
                                                           ->     doctor_name VARCHAR(100) NOT NULL,
                                                           ->     specialization VARCHAR(100) NOT NULL,
                                                           ->     email VARCHAR(100) NOT NULL UNIQUE,
                                                           ->     phone VARCHAR(15) NOT NULL UNIQUE,
                                                           ->     consultation_fee DECIMAL(10,2) NOT NULL,
                                                           ->     experience_years INT DEFAULT 0,
                                                           ->     availability_status ENUM('AVAILABLE','UNAVAILABLE')
                                                           ->         DEFAULT 'AVAILABLE',
                                                           ->
                                                           ->     CHECK (consultation_fee >= 0),
                                                           ->     CHECK (experience_years >= 0),
                                                           ->
                                                           ->     FOREIGN KEY (department_id)
                                                           ->         REFERENCES departments(department_id)
                                                           -> );
Query OK, 0 rows affected (0.0752 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 4. CREATE DOCTOR SCHEDULE
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE TABLE doctor_schedule (
                                                           ->     schedule_id INT AUTO_INCREMENT PRIMARY KEY,
                                                           ->     doctor_id INT NOT NULL,
                                                           ->     working_day ENUM(
                                                           ->         'MONDAY','TUESDAY','WEDNESDAY',
                                                           ->         'THURSDAY','FRIDAY','SATURDAY','SUNDAY'
                                                           ->     ) NOT NULL,
                                                           ->     start_time TIME NOT NULL,
                                                           ->     end_time TIME NOT NULL,
                                                           ->     slot_duration INT DEFAULT 30,
                                                           ->
                                                           ->     UNIQUE (doctor_id, working_day),
                                                           ->     CHECK (end_time > start_time),
                                                           ->     CHECK (slot_duration > 0),
                                                           ->
                                                           ->     FOREIGN KEY (doctor_id)
                                                           ->         REFERENCES doctors(doctor_id)
                                                           -> );
Query OK, 0 rows affected (0.0436 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 5. CREATE APPOINTMENTS
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE TABLE appointments (
                                                           ->     appointment_id INT AUTO_INCREMENT PRIMARY KEY,
                                                           ->     patient_id INT NOT NULL,
                                                           ->     doctor_id INT NOT NULL,
                                                           ->     appointment_date DATE NOT NULL,
                                                           ->     appointment_time TIME NOT NULL,
                                                           ->
                                                           ->     appointment_status ENUM(
                                                           ->         'BOOKED','CONFIRMED','COMPLETED','CANCELLED'
                                                           ->     ) DEFAULT 'BOOKED',
                                                           ->
                                                           ->     symptoms VARCHAR(500),
                                                           ->     notes VARCHAR(500),
                                                           ->     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                                           ->
                                                           ->     FOREIGN KEY (patient_id)
                                                           ->         REFERENCES patients(patient_id),
                                                           ->
                                                           ->     FOREIGN KEY (doctor_id)
                                                           ->         REFERENCES doctors(doctor_id)
                                                           -> );
Query OK, 0 rows affected (0.0581 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 6. CREATE BILLS
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE TABLE bills (
                                                           ->     bill_id INT AUTO_INCREMENT PRIMARY KEY,
                                                           ->     appointment_id INT NOT NULL UNIQUE,
                                                           ->     total_amount DECIMAL(10,2) NOT NULL,
                                                           ->     amount_paid DECIMAL(10,2) DEFAULT 0,
                                                           ->
                                                           ->     payment_status ENUM('PENDING','PARTIAL','PAID')
                                                           ->         DEFAULT 'PENDING',
                                                           ->
                                                           ->     payment_method ENUM('CASH','CARD','UPI','INSURANCE')
                                                           ->         DEFAULT 'CASH',
                                                           ->
                                                           ->     bill_date DATE DEFAULT (CURRENT_DATE),
                                                           ->
                                                           ->     CHECK (total_amount >= 0),
                                                           ->     CHECK (amount_paid >= 0 AND amount_paid <= total_amount),
                                                           ->
                                                           ->     FOREIGN KEY (appointment_id)
                                                           ->         REFERENCES appointments(appointment_id)
                                                           -> );
Query OK, 0 rows affected (0.0687 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 7. CREATE APPOINTMENT LOGS
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE TABLE appointment_logs (
                                                           ->     log_id INT AUTO_INCREMENT PRIMARY KEY,
                                                           ->     appointment_id INT NOT NULL,
                                                           ->     action_type VARCHAR(30) NOT NULL,
                                                           ->     old_status VARCHAR(20),
                                                           ->     new_status VARCHAR(20),
                                                           ->     description VARCHAR(255),
                                                           ->     log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                                           ->
                                                           ->     FOREIGN KEY (appointment_id)
                                                           ->         REFERENCES appointments(appointment_id)
                                                           ->         ON DELETE CASCADE
                                                           -> );
Query OK, 0 rows affected (0.0572 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 8. INSERT DEPARTMENTS
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > INSERT INTO departments
                                                           -> (department_name, floor_number, contact_number)
                                                           -> VALUES
                                                           -> ('Cardiology',2,'9000000001'),
                                                           -> ('Neurology',3,'9000000002'),
                                                           -> ('Orthopedics',1,'9000000003'),
                                                           -> ('Pediatrics',2,'9000000004'),
                                                           -> ('Dermatology',4,'9000000005'),
                                                           -> ('ENT',1,'9000000006'),
                                                           -> ('General Medicine',0,'9000000007'),
                                                           -> ('Ophthalmology',3,'9000000008');
Query OK, 8 rows affected (0.0063 sec)

Records: 8  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 9. INSERT PATIENTS
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > INSERT INTO patients
                                                           -> (patient_name, gender, date_of_birth, phone, email, address, blood_group)
                                                           -> VALUES
                                                           -> ('Aarav Sharma','MALE','1995-04-12','9100000001','aarav@gmail.com','Kolkata','B+'),
                                                           -> ('Priya Das','FEMALE','1998-08-21','9100000002','priya@gmail.com','Howrah','O+'),
                                                           -> ('Rahul Roy','MALE','1989-02-10','9100000003','rahul@gmail.com','Salt Lake','A+'),
                                                           -> ('Sneha Sen','FEMALE','2001-11-05','9100000004','sneha@gmail.com','New Town','AB+'),
                                                           -> ('Aditya Ghosh','MALE','1978-06-17','9100000005','aditya@gmail.com','Dumdum','O-'),
                                                           -> ('Riya Banerjee','FEMALE','1992-09-30','9100000006','riya@gmail.com','Behala','B-'),
                                                           -> ('Karan Mehta','MALE','2003-01-15','9100000007','karan@gmail.com','Rajarhat','A-'),
                                                           -> ('Ananya Bose','FEMALE','1985-12-25','9100000008','ananya@gmail.com','Barasat','AB-');
Query OK, 8 rows affected (0.0054 sec)

Records: 8  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 10. INSERT DOCTORS
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > INSERT INTO doctors
                                                           -> (department_id, doctor_name, specialization, email, phone,
                                                           ->  consultation_fee, experience_years)
                                                           -> VALUES
                                                           -> (1,'Dr. Amit Sen','Heart Specialist','amit@hospital.com','9200000001',900,12),
                                                           -> (2,'Dr. Neha Roy','Neurologist','neha@hospital.com','9200000002',1100,10),
                                                           -> (3,'Dr. Suman Das','Orthopedic','suman@hospital.com','9200000003',800,8),
                                                           -> (4,'Dr. Pooja Paul','Child Specialist','pooja@hospital.com','9200000004',700,7),
                                                           -> (5,'Dr. Arjun Dey','Skin Specialist','arjun@hospital.com','9200000005',650,6),
                                                           -> (6,'Dr. Moumita Ghosh','ENT Specialist','moumita@hospital.com','9200000006',600,9),
                                                           -> (7,'Dr. Rajiv Nair','General Physician','rajiv@hospital.com','9200000007',500,15),
                                                           -> (8,'Dr. Ishita Roy','Eye Specialist','ishita@hospital.com','9200000008',750,5);
Query OK, 8 rows affected (0.0061 sec)

Records: 8  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 11. INSERT DOCTOR SCHEDULES
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > INSERT INTO doctor_schedule
                                                           -> (doctor_id, working_day, start_time, end_time, slot_duration)
                                                           -> VALUES
                                                           -> (1,'MONDAY','09:00:00','13:00:00',30),
                                                           -> (2,'TUESDAY','10:00:00','14:00:00',30),
                                                           -> (3,'WEDNESDAY','09:00:00','13:00:00',30),
                                                           -> (4,'THURSDAY','10:00:00','14:00:00',30),
                                                           -> (5,'FRIDAY','09:00:00','12:00:00',30),
                                                           -> (6,'SATURDAY','10:00:00','13:00:00',30),
                                                           -> (7,'MONDAY','14:00:00','18:00:00',30),
                                                           -> (8,'TUESDAY','14:00:00','18:00:00',30);
Query OK, 8 rows affected (0.0068 sec)

Records: 8  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 12. CREATE TRIGGERS
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- IMPORTANT: DELIMITER WITHOUT BACKSLASH
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0006 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > DELIMITER $$
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- BEFORE INSERT: Prevent duplicate active bookings
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE TRIGGER trg_prevent_duplicate_appointment
                                                           -> BEFORE INSERT ON appointments
                                                           -> FOR EACH ROW
                                                           -> BEGIN
                                                           ->     DECLARE slot_count INT DEFAULT 0;
                                                           ->
                                                           ->     SELECT COUNT(*)
                                                           ->     INTO slot_count
                                                           ->     FROM appointments
                                                           ->     WHERE doctor_id = NEW.doctor_id
                                                           ->       AND appointment_date = NEW.appointment_date
                                                           ->       AND appointment_time = NEW.appointment_time
                                                           ->       AND appointment_status <> 'CANCELLED';
                                                           ->
                                                           ->     IF slot_count > 0 THEN
                                                           ->         SIGNAL SQLSTATE '45000'
                                                           ->         SET MESSAGE_TEXT = 'Doctor already has an appointment in this slot';
                                                           ->     END IF;
                                                           -> END$$
Query OK, 0 rows affected (0.0126 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- AFTER INSERT: Record new appointment
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE TRIGGER trg_log_new_appointment
                                                           -> AFTER INSERT ON appointments
                                                           -> FOR EACH ROW
                                                           -> BEGIN
                                                           ->     INSERT INTO appointment_logs
                                                           ->     (appointment_id, action_type, new_status, description)
                                                           ->     VALUES
                                                           ->     (NEW.appointment_id, 'INSERT', NEW.appointment_status,
                                                           ->      'New appointment created');
                                                           -> END$$
Query OK, 0 rows affected (0.0108 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- AFTER UPDATE: Record appointment status changes
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE TRIGGER trg_log_status_update
                                                           -> AFTER UPDATE ON appointments
                                                           -> FOR EACH ROW
                                                           -> BEGIN
                                                           ->     IF OLD.appointment_status <> NEW.appointment_status THEN
                                                           ->         INSERT INTO appointment_logs
                                                           ->         (appointment_id, action_type, old_status, new_status, description)
                                                           ->         VALUES
                                                           ->         (NEW.appointment_id, 'STATUS_UPDATE',
                                                           ->          OLD.appointment_status, NEW.appointment_status,
                                                           ->          'Appointment status changed');
                                                           ->     END IF;
                                                           -> END$$
Query OK, 0 rows affected (0.0107 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > DELIMITER ;
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 13. INSERT APPOINTMENTS
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > INSERT INTO appointments
                                                           -> (patient_id, doctor_id, appointment_date, appointment_time,
                                                           ->  appointment_status, symptoms, notes)
                                                           -> VALUES
                                                           -> (1,1,'2026-11-24','09:00:00','CONFIRMED','Chest pain','First visit'),
                                                           -> (2,2,'2026-11-24','10:00:00','BOOKED','Headache','Consultation'),
                                                           -> (3,3,'2026-11-25','09:00:00','CONFIRMED','Knee pain','X-ray advised'),
                                                           -> (4,4,'2026-11-25','10:00:00','BOOKED','Fever','Check-up'),
                                                           -> (5,5,'2026-11-26','09:00:00','COMPLETED','Skin irritation','Follow-up'),
                                                           -> (6,6,'2026-11-26','10:00:00','CONFIRMED','Ear pain','ENT check-up'),
                                                           -> (7,7,'2026-11-27','14:00:00','BOOKED','Weakness','Routine visit'),
                                                           -> (8,8,'2026-11-27','14:00:00','COMPLETED','Blurred vision','Eye check-up');
Query OK, 8 rows affected (0.0139 sec)

Records: 8  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0006 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 14. INSERT BILLS
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > INSERT INTO bills
                                                           -> (appointment_id, total_amount, amount_paid, payment_status, payment_method)
                                                           -> VALUES
                                                           -> (1,900,900,'PAID','UPI'),
                                                           -> (2,1100,0,'PENDING','CASH'),
                                                           -> (3,800,400,'PARTIAL','CARD'),
                                                           -> (4,700,0,'PENDING','CASH'),
                                                           -> (5,650,650,'PAID','UPI'),
                                                           -> (6,600,300,'PARTIAL','CARD'),
                                                           -> (7,500,0,'PENDING','CASH'),
                                                           -> (8,750,750,'PAID','INSURANCE');
Query OK, 8 rows affected (0.0056 sec)

Records: 8  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 15. BASIC SELECT QUERIES
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0006 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 1. Display all patients
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM patients;
+------------+---------------+--------+---------------+------------+------------------+-----------+-------------+-------------------+
| patient_id | patient_name  | gender | date_of_birth | phone      | email            | address   | blood_group | registration_date |
+------------+---------------+--------+---------------+------------+------------------+-----------+-------------+-------------------+
|          1 | Aarav Sharma  | MALE   | 1995-04-12    | 9100000001 | aarav@gmail.com  | Kolkata   | B+          | 2026-11-23        |
|          2 | Priya Das     | FEMALE | 1998-08-21    | 9100000002 | priya@gmail.com  | Howrah    | O+          | 2026-11-23        |
|          3 | Rahul Roy     | MALE   | 1989-02-10    | 9100000003 | rahul@gmail.com  | Salt Lake | A+          | 2026-11-23        |
|          4 | Sneha Sen     | FEMALE | 2001-11-05    | 9100000004 | sneha@gmail.com  | New Town  | AB+         | 2026-11-23        |
|          5 | Aditya Ghosh  | MALE   | 1978-06-17    | 9100000005 | aditya@gmail.com | Dumdum    | O-          | 2026-11-23        |
|          6 | Riya Banerjee | FEMALE | 1992-09-30    | 9100000006 | riya@gmail.com   | Behala    | B-          | 2026-11-23        |
|          7 | Karan Mehta   | MALE   | 2003-01-15    | 9100000007 | karan@gmail.com  | Rajarhat  | A-          | 2026-11-23        |
|          8 | Ananya Bose   | FEMALE | 1985-12-25    | 9100000008 | ananya@gmail.com | Barasat   | AB-         | 2026-11-23        |
+------------+---------------+--------+---------------+------------+------------------+-----------+-------------+-------------------+
8 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 2. Display all doctors
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM doctors;
+-----------+---------------+-------------------+-------------------+----------------------+------------+------------------+------------------+---------------------+
| doctor_id | department_id | doctor_name       | specialization    | email                | phone      | consultation_fee | experience_years | availability_status |
+-----------+---------------+-------------------+-------------------+----------------------+------------+------------------+------------------+---------------------+
|         1 |             1 | Dr. Amit Sen      | Heart Specialist  | amit@hospital.com    | 9200000001 |           900.00 |               12 | AVAILABLE           |
|         2 |             2 | Dr. Neha Roy      | Neurologist       | neha@hospital.com    | 9200000002 |          1100.00 |               10 | AVAILABLE           |
|         3 |             3 | Dr. Suman Das     | Orthopedic        | suman@hospital.com   | 9200000003 |           800.00 |                8 | AVAILABLE           |
|         4 |             4 | Dr. Pooja Paul    | Child Specialist  | pooja@hospital.com   | 9200000004 |           700.00 |                7 | AVAILABLE           |
|         5 |             5 | Dr. Arjun Dey     | Skin Specialist   | arjun@hospital.com   | 9200000005 |           650.00 |                6 | AVAILABLE           |
|         6 |             6 | Dr. Moumita Ghosh | ENT Specialist    | moumita@hospital.com | 9200000006 |           600.00 |                9 | AVAILABLE           |
|         7 |             7 | Dr. Rajiv Nair    | General Physician | rajiv@hospital.com   | 9200000007 |           500.00 |               15 | AVAILABLE           |
|         8 |             8 | Dr. Ishita Roy    | Eye Specialist    | ishita@hospital.com  | 9200000008 |           750.00 |                5 | AVAILABLE           |
+-----------+---------------+-------------------+-------------------+----------------------+------------+------------------+------------------+---------------------+
8 rows in set (0.0006 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 3. Display all departments
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM departments;
+---------------+------------------+--------------+----------------+---------------------+
| department_id | department_name  | floor_number | contact_number | created_at          |
+---------------+------------------+--------------+----------------+---------------------+
|             1 | Cardiology       |            2 | 9000000001     | 2026-11-23 20:07:15 |
|             2 | Neurology        |            3 | 9000000002     | 2026-11-23 20:07:15 |
|             3 | Orthopedics      |            1 | 9000000003     | 2026-11-23 20:07:15 |
|             4 | Pediatrics       |            2 | 9000000004     | 2026-11-23 20:07:15 |
|             5 | Dermatology      |            4 | 9000000005     | 2026-11-23 20:07:15 |
|             6 | ENT              |            1 | 9000000006     | 2026-11-23 20:07:15 |
|             7 | General Medicine |            0 | 9000000007     | 2026-11-23 20:07:15 |
|             8 | Ophthalmology    |            3 | 9000000008     | 2026-11-23 20:07:15 |
+---------------+------------------+--------------+----------------+---------------------+
8 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 4. Display all appointments
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM appointments;
+----------------+------------+-----------+------------------+------------------+--------------------+-----------------+---------------+---------------------+
| appointment_id | patient_id | doctor_id | appointment_date | appointment_time | appointment_status | symptoms        | notes         | created_at          |
+----------------+------------+-----------+------------------+------------------+--------------------+-----------------+---------------+---------------------+
|              1 |          1 |         1 | 2026-11-24       | 09:00:00         | CONFIRMED          | Chest pain      | First visit   | 2026-11-23 20:07:16 |
|              2 |          2 |         2 | 2026-11-24       | 10:00:00         | BOOKED             | Headache        | Consultation  | 2026-11-23 20:07:16 |
|              3 |          3 |         3 | 2026-11-25       | 09:00:00         | CONFIRMED          | Knee pain       | X-ray advised | 2026-11-23 20:07:16 |
|              4 |          4 |         4 | 2026-11-25       | 10:00:00         | BOOKED             | Fever           | Check-up      | 2026-11-23 20:07:16 |
|              5 |          5 |         5 | 2026-11-26       | 09:00:00         | COMPLETED          | Skin irritation | Follow-up     | 2026-11-23 20:07:16 |
|              6 |          6 |         6 | 2026-11-26       | 10:00:00         | CONFIRMED          | Ear pain        | ENT check-up  | 2026-11-23 20:07:16 |
|              7 |          7 |         7 | 2026-11-27       | 14:00:00         | BOOKED             | Weakness        | Routine visit | 2026-11-23 20:07:16 |
|              8 |          8 |         8 | 2026-11-27       | 14:00:00         | COMPLETED          | Blurred vision  | Eye check-up  | 2026-11-23 20:07:16 |
+----------------+------------+-----------+------------------+------------------+--------------------+-----------------+---------------+---------------------+
8 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 5. Search patients whose names start with A
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM patients
                                                           -> WHERE patient_name LIKE 'A%';
+------------+--------------+--------+---------------+------------+------------------+---------+-------------+-------------------+
| patient_id | patient_name | gender | date_of_birth | phone      | email            | address | blood_group | registration_date |
+------------+--------------+--------+---------------+------------+------------------+---------+-------------+-------------------+
|          1 | Aarav Sharma | MALE   | 1995-04-12    | 9100000001 | aarav@gmail.com  | Kolkata | B+          | 2026-11-23        |
|          5 | Aditya Ghosh | MALE   | 1978-06-17    | 9100000005 | aditya@gmail.com | Dumdum  | O-          | 2026-11-23        |
|          8 | Ananya Bose  | FEMALE | 1985-12-25    | 9100000008 | ananya@gmail.com | Barasat | AB-         | 2026-11-23        |
+------------+--------------+--------+---------------+------------+------------------+---------+-------------+-------------------+
3 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 6. Doctors whose fees are between 600 and 900
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM doctors
                                                           -> WHERE consultation_fee BETWEEN 600 AND 900;
+-----------+---------------+-------------------+------------------+----------------------+------------+------------------+------------------+---------------------+
| doctor_id | department_id | doctor_name       | specialization   | email                | phone      | consultation_fee | experience_years | availability_status |
+-----------+---------------+-------------------+------------------+----------------------+------------+------------------+------------------+---------------------+
|         1 |             1 | Dr. Amit Sen      | Heart Specialist | amit@hospital.com    | 9200000001 |           900.00 |               12 | AVAILABLE           |
|         3 |             3 | Dr. Suman Das     | Orthopedic       | suman@hospital.com   | 9200000003 |           800.00 |                8 | AVAILABLE           |
|         4 |             4 | Dr. Pooja Paul    | Child Specialist | pooja@hospital.com   | 9200000004 |           700.00 |                7 | AVAILABLE           |
|         5 |             5 | Dr. Arjun Dey     | Skin Specialist  | arjun@hospital.com   | 9200000005 |           650.00 |                6 | AVAILABLE           |
|         6 |             6 | Dr. Moumita Ghosh | ENT Specialist   | moumita@hospital.com | 9200000006 |           600.00 |                9 | AVAILABLE           |
|         8 |             8 | Dr. Ishita Roy    | Eye Specialist   | ishita@hospital.com  | 9200000008 |           750.00 |                5 | AVAILABLE           |
+-----------+---------------+-------------------+------------------+----------------------+------------+------------------+------------------+---------------------+
6 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 7. Appointments with selected statuses
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM appointments
                                                           -> WHERE appointment_status IN ('BOOKED','CONFIRMED');
+----------------+------------+-----------+------------------+------------------+--------------------+------------+---------------+---------------------+
| appointment_id | patient_id | doctor_id | appointment_date | appointment_time | appointment_status | symptoms   | notes         | created_at          |
+----------------+------------+-----------+------------------+------------------+--------------------+------------+---------------+---------------------+
|              1 |          1 |         1 | 2026-11-24       | 09:00:00         | CONFIRMED          | Chest pain | First visit   | 2026-11-23 20:07:16 |
|              2 |          2 |         2 | 2026-11-24       | 10:00:00         | BOOKED             | Headache   | Consultation  | 2026-11-23 20:07:16 |
|              3 |          3 |         3 | 2026-11-25       | 09:00:00         | CONFIRMED          | Knee pain  | X-ray advised | 2026-11-23 20:07:16 |
|              4 |          4 |         4 | 2026-11-25       | 10:00:00         | BOOKED             | Fever      | Check-up      | 2026-11-23 20:07:16 |
|              6 |          6 |         6 | 2026-11-26       | 10:00:00         | CONFIRMED          | Ear pain   | ENT check-up  | 2026-11-23 20:07:16 |
|              7 |          7 |         7 | 2026-11-27       | 14:00:00         | BOOKED             | Weakness   | Routine visit | 2026-11-23 20:07:16 |
+----------------+------------+-----------+------------------+------------------+--------------------+------------+---------------+---------------------+
6 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 8. Latest five appointments
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM appointments
                                                           -> ORDER BY appointment_date DESC
                                                           -> LIMIT 5;
+----------------+------------+-----------+------------------+------------------+--------------------+-----------------+---------------+---------------------+
| appointment_id | patient_id | doctor_id | appointment_date | appointment_time | appointment_status | symptoms        | notes         | created_at          |
+----------------+------------+-----------+------------------+------------------+--------------------+-----------------+---------------+---------------------+
|              7 |          7 |         7 | 2026-11-27       | 14:00:00         | BOOKED             | Weakness        | Routine visit | 2026-11-23 20:07:16 |
|              8 |          8 |         8 | 2026-11-27       | 14:00:00         | COMPLETED          | Blurred vision  | Eye check-up  | 2026-11-23 20:07:16 |
|              5 |          5 |         5 | 2026-11-26       | 09:00:00         | COMPLETED          | Skin irritation | Follow-up     | 2026-11-23 20:07:16 |
|              6 |          6 |         6 | 2026-11-26       | 10:00:00         | CONFIRMED          | Ear pain        | ENT check-up  | 2026-11-23 20:07:16 |
|              3 |          3 |         3 | 2026-11-25       | 09:00:00         | CONFIRMED          | Knee pain       | X-ray advised | 2026-11-23 20:07:16 |
+----------------+------------+-----------+------------------+------------------+--------------------+-----------------+---------------+---------------------+
5 rows in set (0.0008 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 16. JOIN QUERIES
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 9. Patient appointment details
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT
                                                           ->     p.patient_name,
                                                           ->     a.appointment_date,
                                                           ->     a.appointment_time,
                                                           ->     a.appointment_status
                                                           -> FROM patients p
                                                           -> INNER JOIN appointments a
                                                           -> ON p.patient_id = a.patient_id;
+---------------+------------------+------------------+--------------------+
| patient_name  | appointment_date | appointment_time | appointment_status |
+---------------+------------------+------------------+--------------------+
| Aarav Sharma  | 2026-11-24       | 09:00:00         | CONFIRMED          |
| Priya Das     | 2026-11-24       | 10:00:00         | BOOKED             |
| Rahul Roy     | 2026-11-25       | 09:00:00         | CONFIRMED          |
| Sneha Sen     | 2026-11-25       | 10:00:00         | BOOKED             |
| Aditya Ghosh  | 2026-11-26       | 09:00:00         | COMPLETED          |
| Riya Banerjee | 2026-11-26       | 10:00:00         | CONFIRMED          |
| Karan Mehta   | 2026-11-27       | 14:00:00         | BOOKED             |
| Ananya Bose   | 2026-11-27       | 14:00:00         | COMPLETED          |
+---------------+------------------+------------------+--------------------+
8 rows in set (0.0008 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 10. All doctors including doctors without appointments
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT
                                                           ->     d.doctor_name,
                                                           ->     a.appointment_id,
                                                           ->     a.appointment_date
                                                           -> FROM doctors d
                                                           -> LEFT JOIN appointments a
                                                           -> ON d.doctor_id = a.doctor_id;
+-------------------+----------------+------------------+
| doctor_name       | appointment_id | appointment_date |
+-------------------+----------------+------------------+
| Dr. Amit Sen      |              1 | 2026-11-24       |
| Dr. Neha Roy      |              2 | 2026-11-24       |
| Dr. Suman Das     |              3 | 2026-11-25       |
| Dr. Pooja Paul    |              4 | 2026-11-25       |
| Dr. Arjun Dey     |              5 | 2026-11-26       |
| Dr. Moumita Ghosh |              6 | 2026-11-26       |
| Dr. Rajiv Nair    |              7 | 2026-11-27       |
| Dr. Ishita Roy    |              8 | 2026-11-27       |
+-------------------+----------------+------------------+
8 rows in set (0.0008 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 11. Doctors and their departments
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT
                                                           ->     d.doctor_name,
                                                           ->     dep.department_name
                                                           -> FROM doctors d
                                                           -> INNER JOIN departments dep
                                                           -> ON d.department_id = dep.department_id;
+-------------------+------------------+
| doctor_name       | department_name  |
+-------------------+------------------+
| Dr. Amit Sen      | Cardiology       |
| Dr. Neha Roy      | Neurology        |
| Dr. Suman Das     | Orthopedics      |
| Dr. Pooja Paul    | Pediatrics       |
| Dr. Arjun Dey     | Dermatology      |
| Dr. Moumita Ghosh | ENT              |
| Dr. Rajiv Nair    | General Medicine |
| Dr. Ishita Roy    | Ophthalmology    |
+-------------------+------------------+
8 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 12. Complete appointment report
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT
                                                           ->     p.patient_name,
                                                           ->     d.doctor_name,
                                                           ->     dep.department_name,
                                                           ->     a.appointment_date,
                                                           ->     a.appointment_time,
                                                           ->     a.appointment_status
                                                           -> FROM appointments a
                                                           -> JOIN patients p ON a.patient_id = p.patient_id
                                                           -> JOIN doctors d ON a.doctor_id = d.doctor_id
                                                           -> JOIN departments dep ON d.department_id = dep.department_id;
+---------------+-------------------+------------------+------------------+------------------+--------------------+
| patient_name  | doctor_name       | department_name  | appointment_date | appointment_time | appointment_status |
+---------------+-------------------+------------------+------------------+------------------+--------------------+
| Aarav Sharma  | Dr. Amit Sen      | Cardiology       | 2026-11-24       | 09:00:00         | CONFIRMED          |
| Priya Das     | Dr. Neha Roy      | Neurology        | 2026-11-24       | 10:00:00         | BOOKED             |
| Rahul Roy     | Dr. Suman Das     | Orthopedics      | 2026-11-25       | 09:00:00         | CONFIRMED          |
| Sneha Sen     | Dr. Pooja Paul    | Pediatrics       | 2026-11-25       | 10:00:00         | BOOKED             |
| Aditya Ghosh  | Dr. Arjun Dey     | Dermatology      | 2026-11-26       | 09:00:00         | COMPLETED          |
| Riya Banerjee | Dr. Moumita Ghosh | ENT              | 2026-11-26       | 10:00:00         | CONFIRMED          |
| Karan Mehta   | Dr. Rajiv Nair    | General Medicine | 2026-11-27       | 14:00:00         | BOOKED             |
| Ananya Bose   | Dr. Ishita Roy    | Ophthalmology    | 2026-11-27       | 14:00:00         | COMPLETED          |
+---------------+-------------------+------------------+------------------+------------------+--------------------+
8 rows in set (0.0009 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 17. GROUP BY AND HAVING QUERIES
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 13. Total appointments per doctor
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT
                                                           ->     d.doctor_name,
                                                           ->     COUNT(a.appointment_id) AS total_appointments
                                                           -> FROM doctors d
                                                           -> LEFT JOIN appointments a
                                                           -> ON d.doctor_id = a.doctor_id
                                                           -> GROUP BY d.doctor_id, d.doctor_name;
+-------------------+--------------------+
| doctor_name       | total_appointments |
+-------------------+--------------------+
| Dr. Amit Sen      |                  1 |
| Dr. Neha Roy      |                  1 |
| Dr. Suman Das     |                  1 |
| Dr. Pooja Paul    |                  1 |
| Dr. Arjun Dey     |                  1 |
| Dr. Moumita Ghosh |                  1 |
| Dr. Rajiv Nair    |                  1 |
| Dr. Ishita Roy    |                  1 |
+-------------------+--------------------+
8 rows in set (0.0011 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 14. Doctors having more than zero appointments
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT
                                                           ->     d.doctor_name,
                                                           ->     COUNT(a.appointment_id) AS total_appointments
                                                           -> FROM doctors d
                                                           -> JOIN appointments a
                                                           -> ON d.doctor_id = a.doctor_id
                                                           -> GROUP BY d.doctor_id, d.doctor_name
                                                           -> HAVING COUNT(a.appointment_id) > 0;
+-------------------+--------------------+
| doctor_name       | total_appointments |
+-------------------+--------------------+
| Dr. Amit Sen      |                  1 |
| Dr. Neha Roy      |                  1 |
| Dr. Suman Das     |                  1 |
| Dr. Pooja Paul    |                  1 |
| Dr. Arjun Dey     |                  1 |
| Dr. Moumita Ghosh |                  1 |
| Dr. Rajiv Nair    |                  1 |
| Dr. Ishita Roy    |                  1 |
+-------------------+--------------------+
8 rows in set (0.0009 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 15. Total billing by payment status
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT
                                                           ->     payment_status,
                                                           ->     SUM(total_amount) AS total_amount
                                                           -> FROM bills
                                                           -> GROUP BY payment_status;
+----------------+--------------+
| payment_status | total_amount |
+----------------+--------------+
| PAID           |      2300.00 |
| PENDING        |      2300.00 |
| PARTIAL        |      1400.00 |
+----------------+--------------+
3 rows in set (0.0008 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 16. Patients per department
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT
                                                           ->     dep.department_name,
                                                           ->     COUNT(a.patient_id) AS patient_count
                                                           -> FROM departments dep
                                                           -> JOIN doctors d ON dep.department_id = d.department_id
                                                           -> JOIN appointments a ON d.doctor_id = a.doctor_id
                                                           -> GROUP BY dep.department_name;
+------------------+---------------+
| department_name  | patient_count |
+------------------+---------------+
| Cardiology       |             1 |
| Dermatology      |             1 |
| ENT              |             1 |
| General Medicine |             1 |
| Neurology        |             1 |
| Ophthalmology    |             1 |
| Orthopedics      |             1 |
| Pediatrics       |             1 |
+------------------+---------------+
8 rows in set (0.0009 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 17. Revenue per department
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT
                                                           ->     dep.department_name,
                                                           ->     SUM(b.amount_paid) AS revenue
                                                           -> FROM departments dep
                                                           -> JOIN doctors d ON dep.department_id = d.department_id
                                                           -> JOIN appointments a ON d.doctor_id = a.doctor_id
                                                           -> JOIN bills b ON a.appointment_id = b.appointment_id
                                                           -> GROUP BY dep.department_name;
+------------------+---------+
| department_name  | revenue |
+------------------+---------+
| Cardiology       |  900.00 |
| Dermatology      |  650.00 |
| ENT              |  300.00 |
| General Medicine |    0.00 |
| Neurology        |    0.00 |
| Ophthalmology    |  750.00 |
| Orthopedics      |  400.00 |
| Pediatrics       |    0.00 |
+------------------+---------+
8 rows in set (0.0031 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 18. Pending balances
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT
                                                           ->     bill_id,
                                                           ->     total_amount,
                                                           ->     amount_paid,
                                                           ->     total_amount - amount_paid AS due_amount
                                                           -> FROM bills
                                                           -> WHERE amount_paid < total_amount;
+---------+--------------+-------------+------------+
| bill_id | total_amount | amount_paid | due_amount |
+---------+--------------+-------------+------------+
|       2 |      1100.00 |        0.00 |    1100.00 |
|       3 |       800.00 |      400.00 |     400.00 |
|       4 |       700.00 |        0.00 |     700.00 |
|       6 |       600.00 |      300.00 |     300.00 |
|       7 |       500.00 |        0.00 |     500.00 |
+---------+--------------+-------------+------------+
5 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 19. Patient appointment history
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT
                                                           ->     p.patient_name,
                                                           ->     d.doctor_name,
                                                           ->     a.appointment_date,
                                                           ->     a.appointment_status
                                                           -> FROM patients p
                                                           -> JOIN appointments a ON p.patient_id = a.patient_id
                                                           -> JOIN doctors d ON a.doctor_id = d.doctor_id;
+---------------+-------------------+------------------+--------------------+
| patient_name  | doctor_name       | appointment_date | appointment_status |
+---------------+-------------------+------------------+--------------------+
| Aarav Sharma  | Dr. Amit Sen      | 2026-11-24       | CONFIRMED          |
| Priya Das     | Dr. Neha Roy      | 2026-11-24       | BOOKED             |
| Rahul Roy     | Dr. Suman Das     | 2026-11-25       | CONFIRMED          |
| Sneha Sen     | Dr. Pooja Paul    | 2026-11-25       | BOOKED             |
| Aditya Ghosh  | Dr. Arjun Dey     | 2026-11-26       | COMPLETED          |
| Riya Banerjee | Dr. Moumita Ghosh | 2026-11-26       | CONFIRMED          |
| Karan Mehta   | Dr. Rajiv Nair    | 2026-11-27       | BOOKED             |
| Ananya Bose   | Dr. Ishita Roy    | 2026-11-27       | COMPLETED          |
+---------------+-------------------+------------------+--------------------+
8 rows in set (0.0009 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 18. CREATE VIEWS
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE VIEW v_appointment_details AS
                                                           -> SELECT
                                                           ->     a.appointment_id,
                                                           ->     p.patient_name,
                                                           ->     d.doctor_name,
                                                           ->     dep.department_name,
                                                           ->     a.appointment_date,
                                                           ->     a.appointment_time,
                                                           ->     a.appointment_status
                                                           -> FROM appointments a
                                                           -> JOIN patients p ON a.patient_id = p.patient_id
                                                           -> JOIN doctors d ON a.doctor_id = d.doctor_id
                                                           -> JOIN departments dep ON d.department_id = dep.department_id;
Query OK, 0 rows affected (0.0108 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE VIEW v_doctor_workload AS
                                                           -> SELECT
                                                           ->     d.doctor_name,
                                                           ->     COUNT(a.appointment_id) AS total_appointments
                                                           -> FROM doctors d
                                                           -> LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
                                                           -> GROUP BY d.doctor_id, d.doctor_name;
Query OK, 0 rows affected (0.0051 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > CREATE VIEW v_billing_summary AS
                                                           -> SELECT
                                                           ->     p.patient_name,
                                                           ->     d.doctor_name,
                                                           ->     b.total_amount,
                                                           ->     b.amount_paid,
                                                           ->     b.payment_status
                                                           -> FROM bills b
                                                           -> JOIN appointments a ON b.appointment_id = a.appointment_id
                                                           -> JOIN patients p ON a.patient_id = p.patient_id
                                                           -> JOIN doctors d ON a.doctor_id = d.doctor_id;
Query OK, 0 rows affected (0.0065 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- Display views
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM v_appointment_details;
+----------------+---------------+-------------------+------------------+------------------+------------------+--------------------+
| appointment_id | patient_name  | doctor_name       | department_name  | appointment_date | appointment_time | appointment_status |
+----------------+---------------+-------------------+------------------+------------------+------------------+--------------------+
|              1 | Aarav Sharma  | Dr. Amit Sen      | Cardiology       | 2026-11-24       | 09:00:00         | CONFIRMED          |
|              2 | Priya Das     | Dr. Neha Roy      | Neurology        | 2026-11-24       | 10:00:00         | BOOKED             |
|              3 | Rahul Roy     | Dr. Suman Das     | Orthopedics      | 2026-11-25       | 09:00:00         | CONFIRMED          |
|              4 | Sneha Sen     | Dr. Pooja Paul    | Pediatrics       | 2026-11-25       | 10:00:00         | BOOKED             |
|              5 | Aditya Ghosh  | Dr. Arjun Dey     | Dermatology      | 2026-11-26       | 09:00:00         | COMPLETED          |
|              6 | Riya Banerjee | Dr. Moumita Ghosh | ENT              | 2026-11-26       | 10:00:00         | CONFIRMED          |
|              7 | Karan Mehta   | Dr. Rajiv Nair    | General Medicine | 2026-11-27       | 14:00:00         | BOOKED             |
|              8 | Ananya Bose   | Dr. Ishita Roy    | Ophthalmology    | 2026-11-27       | 14:00:00         | COMPLETED          |
+----------------+---------------+-------------------+------------------+------------------+------------------+--------------------+
8 rows in set (0.0017 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM v_doctor_workload;
+-------------------+--------------------+
| doctor_name       | total_appointments |
+-------------------+--------------------+
| Dr. Amit Sen      |                  1 |
| Dr. Neha Roy      |                  1 |
| Dr. Suman Das     |                  1 |
| Dr. Pooja Paul    |                  1 |
| Dr. Arjun Dey     |                  1 |
| Dr. Moumita Ghosh |                  1 |
| Dr. Rajiv Nair    |                  1 |
| Dr. Ishita Roy    |                  1 |
+-------------------+--------------------+
8 rows in set (0.0015 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM v_billing_summary;
+---------------+-------------------+--------------+-------------+----------------+
| patient_name  | doctor_name       | total_amount | amount_paid | payment_status |
+---------------+-------------------+--------------+-------------+----------------+
| Aarav Sharma  | Dr. Amit Sen      |       900.00 |      900.00 | PAID           |
| Priya Das     | Dr. Neha Roy      |      1100.00 |        0.00 | PENDING        |
| Rahul Roy     | Dr. Suman Das     |       800.00 |      400.00 | PARTIAL        |
| Sneha Sen     | Dr. Pooja Paul    |       700.00 |        0.00 | PENDING        |
| Aditya Ghosh  | Dr. Arjun Dey     |       650.00 |      650.00 | PAID           |
| Riya Banerjee | Dr. Moumita Ghosh |       600.00 |      300.00 | PARTIAL        |
| Karan Mehta   | Dr. Rajiv Nair    |       500.00 |        0.00 | PENDING        |
| Ananya Bose   | Dr. Ishita Roy    |       750.00 |      750.00 | PAID           |
+---------------+-------------------+--------------+-------------+----------------+
8 rows in set (0.0016 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 19. UPDATE QUERIES
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- Update patient address
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > UPDATE patients
                                                           -> SET address = 'New Town, Kolkata'
                                                           -> WHERE patient_id = 1;
Query OK, 1 row affected (0.0031 sec)

Rows matched: 1  Changed: 1  Warnings: 0
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- Update doctor consultation fee
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > UPDATE doctors
                                                           -> SET consultation_fee = 1200
                                                           -> WHERE doctor_id = 2;
Query OK, 1 row affected (0.0028 sec)

Rows matched: 1  Changed: 1  Warnings: 0
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- Update appointment status
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > UPDATE appointments
                                                           -> SET appointment_status = 'CONFIRMED'
                                                           -> WHERE appointment_id = 2;
Query OK, 1 row affected (0.0046 sec)

Rows matched: 1  Changed: 1  Warnings: 0
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 20. DELETE QUERIES
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- Run separately only when practising
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- DELETE FROM patients
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- WHERE patient_id = 8
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- AND NOT EXISTS (
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > --     SELECT 1 FROM appointments WHERE patient_id = 8
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- );
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- DELETE FROM doctor_schedule
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- WHERE schedule_id = 8;
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 21. TRANSACTION WITH COMMIT
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- Create an appointment and its bill together
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > START TRANSACTION;
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL > INSERT INTO appointments
                                                              -> (patient_id, doctor_id, appointment_date, appointment_time,
                                                              ->  appointment_status, symptoms)
                                                              -> VALUES
                                                              -> (1,1,'2026-12-10','11:00:00','CONFIRMED','Routine check-up');
Query OK, 1 row affected (0.0012 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL > SET @new_appointment_id = LAST_INSERT_ID();
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL > INSERT INTO bills
                                                              -> (appointment_id, total_amount, amount_paid, payment_status)
                                                              -> VALUES
                                                              -> (@new_appointment_id, 900, 0, 'PENDING');
Query OK, 1 row affected (0.0008 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL > COMMIT;
Query OK, 0 rows affected (0.0021 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- Verify committed records
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM appointments
                                                           -> WHERE appointment_id = @new_appointment_id;
+----------------+------------+-----------+------------------+------------------+--------------------+------------------+-------+---------------------+
| appointment_id | patient_id | doctor_id | appointment_date | appointment_time | appointment_status | symptoms         | notes | created_at          |
+----------------+------------+-----------+------------------+------------------+--------------------+------------------+-------+---------------------+
|              9 |          1 |         1 | 2026-12-10       | 11:00:00         | CONFIRMED          | Routine check-up | NULL  | 2026-11-23 20:07:18 |
+----------------+------------+-----------+------------------+------------------+--------------------+------------------+-------+---------------------+
1 row in set (0.0008 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM bills
                                                           -> WHERE appointment_id = @new_appointment_id;
+---------+----------------+--------------+-------------+----------------+----------------+------------+
| bill_id | appointment_id | total_amount | amount_paid | payment_status | payment_method | bill_date  |
+---------+----------------+--------------+-------------+----------------+----------------+------------+
|       9 |              9 |       900.00 |        0.00 | PENDING        | CASH           | 2026-11-23 |
+---------+----------------+--------------+-------------+----------------+----------------+------------+
1 row in set (0.0009 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 22. TRANSACTION WITH ROLLBACK
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > START TRANSACTION;
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL > INSERT INTO appointments
                                                              -> (patient_id, doctor_id, appointment_date, appointment_time,
                                                              ->  appointment_status, symptoms)
                                                              -> VALUES
                                                              -> (2,2,'2026-12-11','11:30:00','BOOKED','Rollback test');
Query OK, 1 row affected (0.0012 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL > SET @rollback_appointment_id = LAST_INSERT_ID();
Query OK, 0 rows affected (0.0006 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL > SAVEPOINT before_bill;
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL > INSERT INTO bills
                                                              -> (appointment_id, total_amount, amount_paid, payment_status)
                                                              -> VALUES
                                                              -> (@rollback_appointment_id, 1100, 0, 'PENDING');
Query OK, 1 row affected (0.0008 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL > ROLLBACK TO SAVEPOINT before_bill;
Query OK, 0 rows affected (0.0014 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  ★  SQL > ROLLBACK;
Query OK, 0 rows affected (0.0016 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- This query should return no rows
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM appointments
                                                           -> WHERE appointment_id = @rollback_appointment_id;
Empty set (0.0012 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0006 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 23. VERIFY TRIGGERS AND LOGS
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SHOW TRIGGERS;
+-----------------------------------+--------+--------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| Trigger                           | Event  | Table        | Statement                                                                                       | Timing | Created                | sql_mode                                 | Definer        | character_set_client | collation_connection | Database Collation |
+-----------------------------------+--------+--------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| trg_prevent_duplicate_appointment | INSERT | appointments | BEGIN
    DECLARE slot_count INT DEFAULT 0;

    SELECT COUNT(*)
    INTO slot_count
    FROM appointments
    WHERE doctor_id = NEW.doctor_id
      AND appointment_date = NEW.appointment_date
      AND appointment_time = NEW.appointment_time
      AND appointment_status <> 'CANCELLED';

    IF slot_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Doctor already has an appointment in this slot';
    END IF;
END | BEFORE | 2026-11-23 20:07:16.51 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| trg_log_new_appointment           | INSERT | appointments | BEGIN
    INSERT INTO appointment_logs
    (appointment_id, action_type, new_status, description)
    VALUES
    (NEW.appointment_id, 'INSERT', NEW.appointment_status,
     'New appointment created');
END                                | AFTER  | 2026-11-23 20:07:16.58 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| trg_log_status_update             | UPDATE | appointments | BEGIN
    IF OLD.appointment_status <> NEW.appointment_status THEN
        INSERT INTO appointment_logs
        (appointment_id, action_type, old_status, new_status, description)
        VALUES
        (NEW.appointment_id, 'STATUS_UPDATE',
         OLD.appointment_status, NEW.appointment_status,
         'Appointment status changed');
    END IF;
END                                                                                         | AFTER  | 2026-11-23 20:07:16.67 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+-----------------------------------+--------+--------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
3 rows in set (0.0034 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT * FROM appointment_logs;
+--------+----------------+---------------+------------+------------+----------------------------+---------------------+
| log_id | appointment_id | action_type   | old_status | new_status | description                | log_time            |
+--------+----------------+---------------+------------+------------+----------------------------+---------------------+
|      1 |              1 | INSERT        | NULL       | CONFIRMED  | New appointment created    | 2026-11-23 20:07:16 |
|      2 |              2 | INSERT        | NULL       | BOOKED     | New appointment created    | 2026-11-23 20:07:16 |
|      3 |              3 | INSERT        | NULL       | CONFIRMED  | New appointment created    | 2026-11-23 20:07:16 |
|      4 |              4 | INSERT        | NULL       | BOOKED     | New appointment created    | 2026-11-23 20:07:16 |
|      5 |              5 | INSERT        | NULL       | COMPLETED  | New appointment created    | 2026-11-23 20:07:16 |
|      6 |              6 | INSERT        | NULL       | CONFIRMED  | New appointment created    | 2026-11-23 20:07:16 |
|      7 |              7 | INSERT        | NULL       | BOOKED     | New appointment created    | 2026-11-23 20:07:16 |
|      8 |              8 | INSERT        | NULL       | COMPLETED  | New appointment created    | 2026-11-23 20:07:16 |
|      9 |              2 | STATUS_UPDATE | BOOKED     | CONFIRMED  | Appointment status changed | 2026-11-23 20:07:17 |
|     10 |              9 | INSERT        | NULL       | CONFIRMED  | New appointment created    | 2026-11-23 20:07:18 |
+--------+----------------+---------------+------------+------------+----------------------------+---------------------+
10 rows in set (0.0008 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 24. VERIFY TABLES AND RECORD COUNTS
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SHOW TABLES;
+--------------------------------------+
| Tables_in_hospital_management_system |
+--------------------------------------+
| appointment_logs                     |
| appointments                         |
| bills                                |
| departments                          |
| doctor_schedule                      |
| doctors                              |
| patients                             |
| v_appointment_details                |
| v_billing_summary                    |
| v_doctor_workload                    |
+--------------------------------------+
10 rows in set (0.0029 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT 'departments' AS table_name, COUNT(*) AS total
                                                           -> FROM departments
                                                           ->
                                                           -> UNION ALL
                                                           ->
                                                           -> SELECT 'patients', COUNT(*) FROM patients
                                                           ->
                                                           -> UNION ALL
                                                           ->
                                                           -> SELECT 'doctors', COUNT(*) FROM doctors
                                                           ->
                                                           -> UNION ALL
                                                           ->
                                                           -> SELECT 'doctor_schedule', COUNT(*) FROM doctor_schedule
                                                           ->
                                                           -> UNION ALL
                                                           ->
                                                           -> SELECT 'appointments', COUNT(*) FROM appointments
                                                           ->
                                                           -> UNION ALL
                                                           ->
                                                           -> SELECT 'bills', COUNT(*) FROM bills
                                                           ->
                                                           -> UNION ALL
                                                           ->
                                                           -> SELECT 'appointment_logs', COUNT(*) FROM appointment_logs;
+------------------+-------+
| table_name       | total |
+------------------+-------+
| departments      |     8 |
| patients         |     8 |
| doctors          |     8 |
| doctor_schedule  |     8 |
| appointments     |     9 |
| bills            |     9 |
| appointment_logs |    10 |
+------------------+-------+
7 rows in set (0.0227 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- 25. CHECK DATABASE
Query OK, 0 rows affected (0.0002 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > -- =========================================================
Query OK, 0 rows affected (0.0004 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
 MySQL  localhost:3306 ssl  hospital_management_system  SQL > SELECT DATABASE();
+----------------------------+
| DATABASE()                 |
+----------------------------+
| hospital_management_system |
+----------------------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306 ssl  hospital_management_system  SQL >
