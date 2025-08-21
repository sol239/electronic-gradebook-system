/*
    File: trg_grade_group_student_biu.sql
    Author: David Válek
    Created: 2025-08-19
    Description: Trigger for checking student enrollment in grade groups before isnerting/updating marks
*/
create or replace trigger trg_grade_group_student_biu before
   insert or update on grade_group_student
   for each row
declare
   v_subject_id number;
   v_count      integer;
begin
   select subject_id
     into v_subject_id
     from grade_group
    where grade_group_id = :new.grade_group_id;

   select count(*)
     into v_count
     from student_subject_teacher
    where student_id = :new.student_id
      and subject_id = v_subject_id;

   if v_count = 0 then
      raise_application_error(
         -20003,
         'Student is not enrolled in the subject for this grade group.'
      );
   end if;
end;
/