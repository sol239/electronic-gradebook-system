/*
   File: tbl_classroom.sql
   Author: David Válek
   Description: Table definition for Classroom, which is room where the lectures take place
   Created: 2025-08-15
*/
CREATE TABLE Classroom (
    classroom_id NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    capacity NUMBER NOT NULL
);