/*
   File: tbl_teacher.sql
   Author: David Válek
   Description: Table definition for Teacher, which stores information about teachers
   Created: 2025-08-15
*/
CREATE TABLE Teacher (
    teacher_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE
);