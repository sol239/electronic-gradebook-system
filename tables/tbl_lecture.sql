/*
   File: tbl_lecture.sql
   Author: David Válek
   Description: Table definition for Lecture, which stores information about lectures
   Created: 2025-08-15
*/
CREATE TABLE Lecture (
    lecture_id NUMBER PRIMARY KEY,
    subject_id NUMBER NOT NULL,
    teacher_id NUMBER NOT NULL,
    classroom_id NUMBER NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    CONSTRAINT fk_lecture_subject FOREIGN KEY (subject_id) REFERENCES Subject(subject_id),
    CONSTRAINT fk_lecture_teacher FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id),
    CONSTRAINT fk_lecture_classroom FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);