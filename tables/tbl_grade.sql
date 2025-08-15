/*
   File: tbl_grade.sql
   Author: David Válek
   Description: Table definition for Grade, which stores the grades given to students
   Created: 2025-08-15
*/
CREATE TABLE Grade (
    grade_id NUMBER PRIMARY KEY,
    student_id NUMBER NOT NULL,
    subject_id NUMBER NOT NULL,
    teacher_id NUMBER NOT NULL,
    grade NUMBER(1) NOT NULL CHECK (grade BETWEEN 1 AND 5),
    CONSTRAINT fk_grade_student FOREIGN KEY (student_id) REFERENCES Student(student_id),
    CONSTRAINT fk_grade_subject FOREIGN KEY (subject_id) REFERENCES Subject(subject_id),
    CONSTRAINT fk_grade_teacher FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);