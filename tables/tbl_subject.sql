/*
   File: tbl_subject.sql
   Author: David Válek
   Description: Table definition for Subject, which stores information about subjects
   Created: 2025-08-15
*/
CREATE TABLE Subject (
    subject_id NUMBER PRIMARY KEY,
    subject_name VARCHAR2(100) NOT NULL
);