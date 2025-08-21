/*
    File: trg_class_group_student_biu.sql
    Author: David Válek
    Created: 2025-08-19
    Description: Trigger for checking student enrollment in class groups.
*/
create or replace trigger trg_class_group_student_biu before
   insert or update on class_group_student
   for each row
declare
   v_class_id_group   number;
   v_class_id_student number;
begin
   select class_id
     into v_class_id_group
     from class_group
    where class_group_id = :new.class_group_id;

   select class_id
     into v_class_id_student
     from student
    where student_id = :new.student_id;

   if v_class_id_group != v_class_id_student then
      raise_application_error(
         -20004,
         'Class group belongs to different class than is the student one'
      );
   end if;
end;
/