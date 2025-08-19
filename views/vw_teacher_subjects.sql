/*
   File: vw_teacher_subjects.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Displays what subject a teacher teaches. Can be used to display all teachers who teach a specific subject.
*/
create or replace view vw_teacher_subjects as
   select p.first_name || ' ' || p.last_name as teacher_name,
          p.email as teacher_email,
          sub.name as subject_name
     from teacher t
     join person p on p.person_id = t.person_id
     join subject_teacher st on st.teacher_id = t.teacher_id
     join subject sub on sub.subject_id = st.subject_id;