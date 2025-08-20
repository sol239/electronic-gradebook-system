/*
   File: vw_class_students.sql
   Author: David Válek
   Created: 2025-08-15
   Description: View for displaying the students of each class.
*/
create or replace view vw_class_students as
   select
          c.class_name as class_name,
          p.first_name || ' ' || p.last_name as student_name,
          p.email as student_email
     from student s
     join class c on c.class_id = s.class_id
     join person p on p.person_id = s.person_id;