/*
   File: pkg_subject_teacher.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for operations on the Subject_Teacher table.
   Notes:
     - Links subjects to their teachers.
     - Includes procedures: add, delete, get subjects by teacher, get teachers by subject.
*/

-- Package specification
create or replace package pkg_subject_teacher as

    /*
       Adds a subject-teacher link to the Subject_Teacher table.
       Parameters:
         p_subject_id - ID of the subject
         p_teacher_id - ID of the teacher
    */
   procedure add_subject_teacher (
      p_subject_id in number,
      p_teacher_id in number
   );

    /*
       Deletes a subject-teacher link from the Subject_Teacher table.
       Parameters:
         p_subject_id - ID of the subject
         p_teacher_id - ID of the teacher
    */
   procedure delete_subject_teacher (
      p_subject_id in number,
      p_teacher_id in number
   );

    /*
       Type for returning a list of subject IDs.
    */
   type subject_id_table is
      table of number;

    /*
       Type for returning a list of teacher IDs.
    */
   type teacher_id_table is
      table of number;

    /*
       Returns all subject IDs for a given teacher.
       Parameters:
         p_teacher_id - ID of the teacher
       Returns:
         subject_id_table with subject IDs.
    */
   function get_subjects_by_teacher (
      p_teacher_id in number
   ) return subject_id_table;

    /*
       Returns all teacher IDs for a given subject.
       Parameters:
         p_subject_id - ID of the subject
       Returns:
         teacher_id_table with teacher IDs.
    */
   function get_teachers_by_subject (
      p_subject_id in number
   ) return teacher_id_table;

end pkg_subject_teacher;
/

-- Package body
create or replace package body pkg_subject_teacher as

   procedure add_subject_teacher (
      p_subject_id in number,
      p_teacher_id in number
   ) as
   begin
      insert into subject_teacher (
         subject_id,
         teacher_id
      ) values ( p_subject_id,
                 p_teacher_id );
      dbms_output.put_line('Subject-Teacher link added: Subject ID '
                           || p_subject_id
                           || ', Teacher ID '
                           || p_teacher_id);
   end add_subject_teacher;

   procedure delete_subject_teacher (
      p_subject_id in number,
      p_teacher_id in number
   ) as
   begin
      delete from subject_teacher
       where subject_id = p_subject_id
         and teacher_id = p_teacher_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No Subject-Teacher link found for Subject ID '
                              || p_subject_id
                              || ', Teacher ID '
                              || p_teacher_id);
      else
         dbms_output.put_line('Subject-Teacher link deleted: Subject ID '
                              || p_subject_id
                              || ', Teacher ID '
                              || p_teacher_id);
      end if;
   end delete_subject_teacher;

   function get_subjects_by_teacher (
      p_teacher_id in number
   ) return subject_id_table as
      v_subjects subject_id_table;
   begin
      select subject_id
      bulk collect
        into v_subjects
        from subject_teacher
       where teacher_id = p_teacher_id;
      return v_subjects;
   end get_subjects_by_teacher;

   function get_teachers_by_subject (
      p_subject_id in number
   ) return teacher_id_table as
      v_teachers teacher_id_table;
   begin
      select teacher_id
      bulk collect
        into v_teachers
        from subject_teacher
       where subject_id = p_subject_id;
      return v_teachers;
   end get_teachers_by_subject;

end pkg_subject_teacher;
/