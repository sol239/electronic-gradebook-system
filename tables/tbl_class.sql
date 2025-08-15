/*
   File: tbl_class.sql
   Author: David Válek
   Description: Table definition for Class, class name is eg. Prima, Sekunda, 4.A, ...
   Created: 2025-08-15
*/
CREATE TABLE Class (
    class_id NUMBER PRIMARY KEY,
    class_name VARCHAR2(50) NOT NULL,
    teacher_id NUMBER NOT NULL,
    CONSTRAINT fk_class_teacher FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);
