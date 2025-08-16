/*
   File: tbl_classroom_lecture.sql
   Author: David Válek
   Description: Table definition for Classroom_Lecture, which links classrooms to lectures
   Created: 2025-08-15
   TODO: Add to createtables and also package, also to drop
*/
create table classroom_lecture (
   classroom_id number not null,
   lecture_id   number not null,
   primary key ( classroom_id, lecture_id ),
   constraint fk_cl_classroom foreign key ( classroom_id )
      references classroom ( classroom_id ),
   constraint fk_cl_lecture foreign key ( lecture_id )
      references lecture ( lecture_id )
);