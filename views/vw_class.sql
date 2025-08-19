/*
   File: vw_class.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Displays main teacher's name and email of each class.
*/
create or replace view vw_class as
   select c.name as class_name,
          p.first_name || ' ' || p.last_name as teacher_name,
          p.email as teacher_email
     from class c
     join teacher t
   on c.teacher_id = t.teacher_id
     join person p
   on t.person_id = p.person_id;