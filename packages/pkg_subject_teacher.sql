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
      commit;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20101,
            'Subject-Teacher link already exists for Subject ID ' || p_subject_id || ', Teacher ID ' || p_teacher_id
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20102,
            'Invalid value or data type for Subject-Teacher link: Subject ID ' || p_subject_id || ', Teacher ID ' || p_teacher_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20103,
            'Other error when adding Subject-Teacher link: Subject ID ' || p_subject_id || ', Teacher ID ' || p_teacher_id || '. Error: ' || SQLERRM
         );
   end add_subject_teacher;

   procedure delete_subject_teacher (
      p_subject_id in number,
      p_teacher_id in number
   ) as
      v_deleted number;
   begin
      delete from subject_teacher
       where subject_id = p_subject_id
         and teacher_id = p_teacher_id
       returning 1 into v_deleted;
      dbms_output.put_line('Subject-Teacher link deleted: Subject ID '
                           || p_subject_id
                           || ', Teacher ID '
                           || p_teacher_id);
      commit;
   exception
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20104,
            'No Subject-Teacher link found for Subject ID ' || p_subject_id || ', Teacher ID ' || p_teacher_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20105,
            'Other error when deleting Subject-Teacher link: Subject ID ' || p_subject_id || ', Teacher ID ' || p_teacher_id || '. Error: ' || SQLERRM
         );
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
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20106,
            'No subjects found for Teacher ID ' || p_teacher_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20107,
            'Multiple subjects found for Teacher ID ' || p_teacher_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20108,
            'Other error when reading subjects by teacher: Teacher ID ' || p_teacher_id || '. Error: ' || SQLERRM
         );
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
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20109,
            'No teachers found for Subject ID ' || p_subject_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20110,
            'Multiple teachers found for Subject ID ' || p_subject_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20111,
            'Other error when reading teachers by subject: Subject ID ' || p_subject_id || '. Error: ' || SQLERRM
         );
   end get_teachers_by_subject;

end pkg_subject_teacher;
/