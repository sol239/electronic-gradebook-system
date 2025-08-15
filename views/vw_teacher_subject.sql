/*
   File: vw_teacher_subject.sql
   Author: David Válek
   Created: 2025-08-15
   Description: View for displaying teacher and subject information.
*/
create or replace view vw_teacher_subject as
   select s.subject_id,
          s.name as subject_name,
          st.teacher_id,
          t.first_name,
          t.last_name
     from subject s
     join subject_teacher st
   on s.subject_id = st.subject_id
     join teacher t
   on st.teacher_id = t.teacher_id