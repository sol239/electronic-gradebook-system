/*
   File: tbl_student_parent.sql
   Author: David Válek
   Description: Table definition for Student_Parent, which links students to their parents
   Created: 2025-08-15
*/
CREATE TABLE Student_Parent (
    student_id NUMBER NOT NULL,
    parent_id NUMBER NOT NULL,
    PRIMARY KEY (student_id, parent_id),
    CONSTRAINT fk_sp_student FOREIGN KEY (student_id) REFERENCES Student(student_id),
    CONSTRAINT fk_sp_parent FOREIGN KEY (parent_id) REFERENCES Parent(parent_id)
);