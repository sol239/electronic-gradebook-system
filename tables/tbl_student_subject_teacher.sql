/*
   File: tbl_student_subject_teacher.sql
   Author: David Válek
   Description: Junction table for student, subject, and teacher relationships. It represents subject enrollment
   Created: 2025-08-15
*/
create table student_subject_teacher (
   student_id number not null,
   subject_id number not null,
   teacher_id number not null,
   CONSTRAINT pk_student_subject_teacher PRIMARY KEY ( student_id,
                 subject_id, teacher_id ),
   constraint fk_sst_student foreign key ( student_id )
      references student ( student_id ),
   constraint fk_sst_subject foreign key ( subject_id )
      references subject ( subject_id ),
   constraint fk_sst_teacher foreign key ( teacher_id )
      references teacher ( teacher_id )
);