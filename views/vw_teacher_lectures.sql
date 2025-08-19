/*
   File: vw_teacher_lectures.sql
   Author: David Válek
   Created: 2025-08-19
   Description: Displays teacher's lectures.
*/
create or replace view vw_teacher_lectures as
   select t.teacher_id,
          l.lecture_id,
          l.lecture_name as lecture_name,
          l.start_time as start_time,
          l.end_time as end_time
     from teacher t
     join lecture_teacher lt
   on t.teacher_id = lt.teacher_id
     join lecture l
   on lt.lecture_id = l.lecture_id
    order by t.teacher_id,
             l.start_time;