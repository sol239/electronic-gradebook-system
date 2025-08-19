create or replace trigger trg_grade_group_biu before
   insert or update on grade_group
   for each row
declare
   v_count integer;
begin
   select count(*)
     into v_count
     from subject_teacher
    where subject_id = :new.subject_id
      and teacher_id = :new.teacher_id;

   if v_count = 0 then
      raise_application_error(
         -20001,
         'Teacher does not teach this subject.'
      );
   end if;
end;
/