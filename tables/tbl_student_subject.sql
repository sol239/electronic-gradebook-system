/*
   File: tbl_student_subject.sql
   Author: David Válek
   Description: Table definition for Student_Subject, which links students to their subjects
   Created: 2025-08-15
*/
CREATE TABLE Student_Subject (
    student_id NUMBER NOT NULL,
    subject_id NUMBER NOT NULL,
    PRIMARY KEY (student_id, subject_id),
    CONSTRAINT fk_ss_student FOREIGN KEY (student_id) REFERENCES Student(student_id),
    CONSTRAINT fk_ss_subject FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);