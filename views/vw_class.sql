/*
   File: vw_class.sql
   Author: David Válek
   Created: 2025-08-15
   Modified: 2025-08-16 - Updated for normalized structure with Person table (no roles)
   Description: View for displaying class information.
*/
create or replace view vw_class as
   select c.class_id,
          c.name as class_name,
          c.teacher_id,
          p.first_name,
          p.last_name,
          p.email
     from class c
     join teacher t on c.teacher_id = t.teacher_id
     join person p on t.person_id = p.person_id;