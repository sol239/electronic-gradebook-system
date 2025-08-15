/*
   File: vw_student_grade.sql
   Author: David Válek
   Created: 2025-08-15
   Description: View for displaying student grades.
*/
create or replace view vw_student_grade as
   select s.student_id,
          s.first_name,
          s.last_name,
          g.subject_id,
          g.grade
        from student s
        JOIN grade g ON s.student_id = g.student_id