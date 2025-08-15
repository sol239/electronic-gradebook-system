/*
   File: tbl_lecture_student.sql
   Author: David Válek
   Description: Table definition for Lecture_Student, which links students to their lectures
   Created: 2025-08-15
*/
create table lecture_student (
   lecture_id number not null,
   student_id number not null,
   primary key ( lecture_id,
                 student_id ),
   constraint fk_ls_lecture foreign key ( lecture_id )
      references lecture ( lecture_id ),
   constraint fk_ls_student foreign key ( student_id )
      references student ( student_id )
);