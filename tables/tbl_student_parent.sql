/*
   File: tbl_student_parent.sql
   Author: David Válek
   Description: Table definition for Student_Parent, which links students to their parents
   Created: 2025-08-15
*/
create table student_parent (
   student_id number not null,
   parent_id  number not null,
   primary key ( student_id,
                 parent_id ),
   constraint fk_sp_student foreign key ( student_id )
      references student ( student_id ),
   constraint fk_sp_parent foreign key ( parent_id )
      references parent ( parent_id )
);