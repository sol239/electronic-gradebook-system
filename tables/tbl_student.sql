/*
   File: tbl_student.sql
   Author: David Válek
   Description: Table definition for Student, which stores information about students
   Created: 2025-08-15
*/
CREATE TABLE Student (
    student_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE,
    class_id NUMBER NULL,
    CONSTRAINT fk_student_class FOREIGN KEY (class_id) REFERENCES Class(class_id)
);