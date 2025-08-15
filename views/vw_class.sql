/*
   File: vw_class.sql
   Author: David Válek
   Created: 2025-08-15
   Description: View for displaying class information.
*/
create or replace view vw_class as
   select c.class_id,
          c.name as class_name,
          c.teacher_id,
          t.first_name,
          t.last_name
     from class c
     join teacher t
   on c.teacher_id = t.teacher_id;