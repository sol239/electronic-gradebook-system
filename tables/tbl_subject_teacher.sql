/*
   File: tbl_subject_teacher.sql
   Author: David Válek
   Description: Table definition for Subject_Teacher, which links subjects to their teachers
   Created: 2025-08-15
*/
CREATE TABLE Subject_Teacher (
    subject_id NUMBER NOT NULL,
    teacher_id NUMBER NOT NULL,
    PRIMARY KEY (subject_id, teacher_id),
    CONSTRAINT fk_st_subject FOREIGN KEY (subject_id) REFERENCES Subject(subject_id),
    CONSTRAINT fk_st_teacher FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);