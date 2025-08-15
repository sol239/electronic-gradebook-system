/*
   File: tbl_class.sql
   Author: David Válek
   Description: Table definition for Class, class name is eg. Prima, Sekunda, 4.A, ...
   Created: 2025-08-15
*/
create table class (
   class_id   number primary key,
   name       varchar2(50) not null,
   teacher_id number not null,
   constraint fk_class_teacher foreign key ( teacher_id )
      references teacher ( teacher_id )
);