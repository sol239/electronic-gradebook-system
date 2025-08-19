/*
   File: tbl_student_subject.sql
   Author: David Válek
   Description: Table definition for Student_Subject, which links students to their subjects
   Created: 2025-08-15
*/
create table student_subject (
   student_id number not null,
   subject_id number not null,
   CONSTRAINT pk_student_subject PRIMARY KEY ( student_id,
                 subject_id ),
   constraint fk_ss_student foreign key ( student_id )
      references student ( student_id ),
   constraint fk_ss_subject foreign key ( subject_id )
      references subject ( subject_id )
);