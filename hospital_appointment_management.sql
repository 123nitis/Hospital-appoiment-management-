-- ============================================================
-- HOSPITAL APPOINTMENT MANAGEMENT SYSTEM
-- Database: MySQL 8.0+
-- ============================================================
-- Run this script in MySQL Workbench.
-- Run it once in a fresh database. It does not delete existing data.

CREATE DATABASE IF NOT EXISTS hospital_appointment_db;
USE hospital_appointment_db;

-- 1. CREATE THE FIVE CORE TABLES

CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    gender VARCHAR(20),
    date_of_birth DATE,
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    specialization VARCHAR(100),
    consultation_fee DECIMAL(10,2) NOT NULL,
    phone VARCHAR(20),
    CONSTRAINT fk_doctors_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT chk_consultation_fee CHECK (consultation_fee >= 0)
);

CREATE TABLE IF NOT EXISTS appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Booked', 'Confirmed', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Booked',
    notes VARCHAR(255),
    CONSTRAINT fk_appointments_patient
        FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    CONSTRAINT fk_appointments_doctor
        FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE IF NOT EXISTS bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    bill_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    payment_status ENUM('Pending', 'Paid') NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_bills_appointment
        FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    CONSTRAINT chk_bill_amount CHECK (amount >= 0)
);

-- Relationship summary:
-- One department can have many doctors.
-- One patient can have many appointments.
-- One doctor can have many appointments.
-- One appointment can have zero or one bill.

-- 2. TRIGGER: BLOCK THE SAME DOCTOR FROM GETTING TWO BOOKINGS
--    FOR THE SAME DATE AND TIME. Cancelled appointments do not
--    block a slot from being booked again.

DROP TRIGGER IF EXISTS prevent_duplicate_doctor_slot;
DELIMITER //
CREATE TRIGGER prevent_duplicate_doctor_slot
BEFORE INSERT ON appointments
FOR EACH ROW
BEGIN
    DECLARE existing_booking INT DEFAULT 0;

    IF NEW.status <> 'Cancelled' THEN
        SELECT COUNT(*)
        INTO existing_booking
        FROM appointments
        WHERE doctor_id = NEW.doctor_id
          AND appointment_date = NEW.appointment_date
          AND appointment_time = NEW.appointment_time
          AND status <> 'Cancelled';

        IF existing_booking > 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'This doctor already has an appointment in this time slot.';
        END IF;
    END IF;
END//
DELIMITER ;

-- 3. VIEW: SHOW TODAY'S APPOINTMENTS, INCLUDING DOCTOR AND PATIENT DETAILS

CREATE OR REPLACE VIEW todays_appointments_per_doctor AS
SELECT
    d.doctor_id,
    d.doctor_name,
    dep.department_name,
    a.appointment_id,
    p.patient_name,
    a.appointment_date,
    a.appointment_time,
    a.status
FROM appointments AS a
JOIN doctors AS d ON a.doctor_id = d.doctor_id
JOIN departments AS dep ON d.department_id = dep.department_id
JOIN patients AS p ON a.patient_id = p.patient_id
WHERE a.appointment_date = CURDATE()
  AND a.status <> 'Cancelled';

-- 4. SAMPLE DATA
-- The IDs below will be 1, 2, 3... when you run this in a fresh database.

INSERT INTO departments (department_name) VALUES
('Cardiology'),
('Dermatology'),
('Orthopedics'),
('Pediatrics');

INSERT INTO patients (patient_name, gender, date_of_birth, phone, email) VALUES
('Aarav Sharma', 'Male',   '1998-04-12', '9000000001', 'aarav@example.com'),
('Diya Roy',     'Female', '2001-08-21', '9000000002', 'diya@example.com'),
('Kabir Das',    'Male',   '1995-02-10', '9000000003', 'kabir@example.com'),
('Anaya Sen',    'Female', '1989-11-05', '9000000004', 'anaya@example.com'),
('Ishaan Paul',  'Male',   '2010-06-18', '9000000005', 'ishaan@example.com');

INSERT INTO doctors (doctor_name, department_id, specialization, consultation_fee, phone) VALUES
('Dr. Meera Sen',  1, 'Cardiologist',     800.00, '9100000001'),
('Dr. Arjun Roy',  2, 'Dermatologist',    600.00, '9100000002'),
('Dr. Neha Das',   3, 'Orthopedic',       700.00, '9100000003'),
('Dr. Rahul Bose', 4, 'Pediatrician',     500.00, '9100000004');

INSERT INTO appointments
    (patient_id, doctor_id, appointment_date, appointment_time, status, notes)
VALUES
    (1, 1, CURDATE(),                         '09:00:00', 'Booked', 'Regular check-up'),
    (2, 1, CURDATE(),                         '10:00:00', 'Booked', 'Follow-up visit'),
    (3, 2, CURDATE(),                         '09:30:00', 'Booked', 'Skin consultation'),
    (4, 3, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '11:00:00', 'Booked', 'Knee pain'),
    (5, 4, CURDATE(),                         '11:00:00', 'Booked', 'Child health check-up');

-- 5. TEST THE VIEW
SELECT *
FROM todays_appointments_per_doctor
ORDER BY doctor_name, appointment_time;

-- 6. TEST THE TRIGGER
-- Run the INSERT below separately. It should fail because doctor 1
-- already has an appointment today at 09:00.
--
-- INSERT INTO appointments
--     (patient_id, doctor_id, appointment_date, appointment_time)
-- VALUES
--     (2, 1, CURDATE(), '09:00:00');
--
-- Expected result: MySQL displays the trigger error message.

-- 7. TRANSACTION: CONFIRM AN APPOINTMENT AND CREATE ITS BILL TOGETHER
-- Change 1 to the appointment_id you want to confirm.
-- The two changes are committed together, or can both be rolled back.

SET @appointment_id = 1;

START TRANSACTION;

UPDATE appointments
SET status = 'Confirmed'
WHERE appointment_id = @appointment_id
  AND status = 'Booked';

INSERT INTO bills (appointment_id, amount, payment_status)
SELECT a.appointment_id, d.consultation_fee, 'Pending'
FROM appointments AS a
JOIN doctors AS d ON a.doctor_id = d.doctor_id
WHERE a.appointment_id = @appointment_id
  AND a.status = 'Confirmed'
  AND NOT EXISTS (
      SELECT 1
      FROM bills AS b
      WHERE b.appointment_id = a.appointment_id
  );

COMMIT;

-- Check the result of the transaction.
SELECT
    a.appointment_id,
    p.patient_name,
    d.doctor_name,
    a.status AS appointment_status,
    b.bill_id,
    b.amount,
    b.bill_date,
    b.payment_status
FROM appointments AS a
JOIN patients AS p ON a.patient_id = p.patient_id
JOIN doctors AS d ON a.doctor_id = d.doctor_id
LEFT JOIN bills AS b ON a.appointment_id = b.appointment_id
WHERE a.appointment_id = @appointment_id;

-- Optional: mark the bill as paid after receiving payment.
-- UPDATE bills SET payment_status = 'Paid' WHERE appointment_id = @appointment_id;

-- 8. REPORT 1: UNIQUE PATIENTS PER DEPARTMENT
-- A patient is counted in a department if they have a non-cancelled
-- appointment with a doctor in that department.

SELECT
    dep.department_name,
    COUNT(DISTINCT a.patient_id) AS total_patients
FROM departments AS dep
LEFT JOIN doctors AS d
    ON dep.department_id = d.department_id
LEFT JOIN appointments AS a
    ON d.doctor_id = a.doctor_id
   AND a.status <> 'Cancelled'
GROUP BY dep.department_id, dep.department_name
ORDER BY dep.department_name;

-- 9. REPORT 2: DOCTOR WORKLOAD
-- Counts all non-cancelled appointments for each doctor.

SELECT
    d.doctor_id,
    d.doctor_name,
    dep.department_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors AS d
JOIN departments AS dep ON d.department_id = dep.department_id
LEFT JOIN appointments AS a
    ON d.doctor_id = a.doctor_id
   AND a.status <> 'Cancelled'
GROUP BY d.doctor_id, d.doctor_name, dep.department_name
ORDER BY total_appointments DESC, d.doctor_name;

-- 10. REPORT 3: REVENUE PER MONTH
-- Total billed = all bills created.
-- Total collected = only bills whose payment_status is 'Paid'.

SELECT
    DATE_FORMAT(bill_date, '%Y-%m') AS revenue_month,
    SUM(amount) AS total_billed,
    SUM(CASE WHEN payment_status = 'Paid' THEN amount ELSE 0 END) AS total_collected
FROM bills
GROUP BY YEAR(bill_date), MONTH(bill_date), DATE_FORMAT(bill_date, '%Y-%m')
ORDER BY YEAR(bill_date), MONTH(bill_date);

-- 11. IMPORT DOCTORS FROM CSV
-- Example CSV columns:
-- doctor_name,department_id,specialization,consultation_fee,phone
--
-- Before using LOCAL INFILE, enable it in your MySQL client/server settings
-- if it is disabled. Then change the path to the real location of your CSV.
-- Example Windows path: C:/hospital_sql_project/doctors.csv
--
-- LOAD DATA LOCAL INFILE 'C:/hospital_sql_project/doctors.csv'
-- INTO TABLE doctors
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 LINES
-- (doctor_name, department_id, specialization, consultation_fee, phone);
--
-- Note: department_id values in the CSV must already exist in departments.

-- 12. EXPORT BILLS TO CSV USING SQL
-- First run this to see the permitted server export directory:
-- SHOW VARIABLES LIKE 'secure_file_priv';
--
-- Then replace the path below with a file path inside that directory.
-- The target file must not already exist. INTO OUTFILE writes on the MySQL server.
--
-- SELECT
--     b.bill_id,
--     a.appointment_id,
--     p.patient_name,
--     d.doctor_name,
--     b.amount,
--     b.bill_date,
--     b.payment_status
-- FROM bills AS b
-- JOIN appointments AS a ON b.appointment_id = a.appointment_id
-- JOIN patients AS p ON a.patient_id = p.patient_id
-- JOIN doctors AS d ON a.doctor_id = d.doctor_id
-- INTO OUTFILE 'C:/path_allowed_by_secure_file_priv/bills_export.csv'
-- FIELDS TERMINATED BY ','
-- OPTIONALLY ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n';

-- END OF PROJECT
