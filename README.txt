HOSPITAL APPOINTMENT MANAGEMENT SYSTEM (MySQL 8.0+)

FILES
- hospital_appointment_management.sql : complete database project
- doctors.csv : sample CSV file for the doctor import task
- er_diagram.png : visual Entity-Relationship (ER) diagram of the database
- README.md : Markdown version of this README with embedded ER diagram

HOW TO RUN
1. Open MySQL Workbench and connect to your MySQL 8.0+ server.
2. Open hospital_appointment_management.sql.
3. Run the script from top to bottom in a fresh database.
4. The script creates the database, five tables, the duplicate-slot trigger,
   the today's-appointments view, sample records, and runs the transaction
   and three report queries.
5. The duplicate-slot test, CSV import, and CSV export statements are
   commented out intentionally. Follow the comments, adjust the file path,
   and run those statements separately when you are ready to test them.

IMPORTANT
- Run the main script once in a fresh database. It does not delete existing data.
- Sample department, patient, doctor, and appointment IDs assume a fresh database.
- For the CSV import, department_id values must already exist in departments.
- LOCAL INFILE may need to be enabled in both the MySQL server and client.
- SELECT ... INTO OUTFILE writes on the database server and is restricted by
  secure_file_priv. In MySQL Workbench, you can instead run the bills SELECT,
  then use the result-grid export option to save the rows as CSV.

ER DIAGRAM
----------
Visual diagram: see er_diagram.png

+-------------------------+          +-----------------------------+
|       departments       |          |           doctors           |
+-------------------------+          +-----------------------------+
| PK department_id (INT)  | 1      N | PK doctor_id (INT)          |
| UQ department_name      +--------->| FK department_id (INT)      |
+-------------------------+   has    |    doctor_name              |
                                     |    specialization           |
                                     |    consultation_fee         |
                                     |    phone                    |
                                     +--------------+--------------+
                                                    | 1
                                                    | attends
                                                    v N
+-------------------------+          +-----------------------------+          +---------------------------+
|        patients         |          |        appointments         |          |           bills           |
+-------------------------+          +-----------------------------+          +---------------------------+
| PK patient_id (INT)     | 1      N | PK appointment_id (INT)     | 1   0..1 | PK bill_id (INT)          |
|    patient_name         +--------->| FK patient_id (INT)         +--------->| FK/UQ appointment_id (INT)|
|    gender               |  books   | FK doctor_id (INT)          | generates|    amount (DECIMAL)       |
|    date_of_birth        |          |    appointment_date (DATE)  |          |    bill_date (DATE)       |
|    phone                |          |    appointment_time (TIME)  |          |    payment_status (ENUM)  |
|    email                |          |    status (ENUM)            |          +---------------------------+
+-------------------------+          |    notes                    |
                                     +-----------------------------+

RELATIONSHIPS
- departments (1) ---> (N) doctors      : One department has many doctors.
- patients    (1) ---> (N) appointments : One patient can book many appointments.
- doctors     (1) ---> (N) appointments : One doctor can have many appointments.
- appointments(1) ---> (0..1) bills     : One appointment has zero or one bill (UNIQUE FK).
