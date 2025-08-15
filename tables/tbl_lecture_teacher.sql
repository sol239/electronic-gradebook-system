/*
   File: tbl_lecture_teacher.sql
   Author: David Válek
   Description: Table definition for Lecture_Teacher, which links teachers to their lectures
   Created: 2025-08-15
*/
create table lecture_teacher (
   lecture_id number not null,
   teacher_id number not null,
   primary key ( lecture_id,
                 teacher_id ),
   constraint fk_lt_lecture foreign key ( lecture_id )
      references lecture ( lecture_id ),
   constraint fk_lt_teacher foreign key ( teacher_id )
      references teacher ( teacher_id )
);