/*
   File: pkg_student_subject.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for operations on the Student_Subject table.
   Notes:
     - Links students to their subjects.
     - Includes procedures: add, delete, get students by subject, get subjects by student.
*/

-- Package specification
create or replace package pkg_student_subject as

    /*
       Adds a student-subject link to the Student_Subject table.
       Parameters:
         p_student_id - ID of the student
         p_subject_id - ID of the subject
    */
   procedure add_student_subject (
      p_student_id in number,
      p_subject_id in number
   );

    /*
       Deletes a student-subject link from the Student_Subject table.
       Parameters:
         p_student_id - ID of the student
         p_subject_id - ID of the subject
    */
   procedure delete_student_subject (
      p_student_id in number,
      p_subject_id in number
   );

    /*
       Type for returning a list of student IDs.
    */
   type student_id_table is
      table of number;

    /*
       Type for returning a list of subject IDs.
    */
   type subject_id_table is
      table of number;

    /*
       Returns all student IDs for a given subject.
       Parameters:
         p_subject_id - ID of the subject
       Returns:
         student_id_table with student IDs.
    */
   function get_students_by_subject (
      p_subject_id in number
   ) return student_id_table;

    /*
       Returns all subject IDs for a given student.
       Parameters:
         p_student_id - ID of the student
       Returns:
         subject_id_table with subject IDs.
    */
   function get_subjects_by_student (
      p_student_id in number
   ) return subject_id_table;

end pkg_student_subject;
/

-- Package body
create or replace package body pkg_student_subject as

   procedure add_student_subject (
      p_student_id in number,
      p_subject_id in number
   ) as
   begin
      insert into student_subject (
         student_id,
         subject_id
      ) values ( p_student_id,
                 p_subject_id );
      dbms_output.put_line('Student-Subject link added: Student ID '
                           || p_student_id
                           || ', Subject ID '
                           || p_subject_id);
      commit;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20071,
            'Student-Subject link already exists for Student ID ' || p_student_id || ', Subject ID ' || p_subject_id
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20072,
            'Invalid value or data type for Student-Subject link: Student ID ' || p_student_id || ', Subject ID ' || p_subject_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20073,
            'Other error when adding Student-Subject link: Student ID ' || p_student_id || ', Subject ID ' || p_subject_id || '. Error: ' || SQLERRM
         );
   end add_student_subject;

   procedure delete_student_subject (
      p_student_id in number,
      p_subject_id in number
   ) as
      v_deleted number;
   begin
      delete from student_subject
       where student_id = p_student_id
         and subject_id = p_subject_id
       returning 1 into v_deleted;
      dbms_output.put_line('Student-Subject link deleted: Student ID '
                           || p_student_id
                           || ', Subject ID '
                           || p_subject_id);
      commit;
   exception
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20074,
            'No Student-Subject link found for Student ID ' || p_student_id || ', Subject ID ' || p_subject_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20075,
            'Other error when deleting Student-Subject link: Student ID ' || p_student_id || ', Subject ID ' || p_subject_id || '. Error: ' || SQLERRM
         );
   end delete_student_subject;

   function get_students_by_subject (
      p_subject_id in number
   ) return student_id_table as
      v_students student_id_table;
   begin
      select student_id
      bulk collect
        into v_students
        from student_subject
       where subject_id = p_subject_id;
      return v_students;
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20076,
            'No students found for Subject ID ' || p_subject_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20077,
            'Multiple students found for Subject ID ' || p_subject_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20078,
            'Other error when reading students by subject: Subject ID ' || p_subject_id || '. Error: ' || SQLERRM
         );
   end get_students_by_subject;

   function get_subjects_by_student (
      p_student_id in number
   ) return subject_id_table as
      v_subjects subject_id_table;
   begin
      select subject_id
      bulk collect
        into v_subjects
        from student_subject
       where student_id = p_student_id;
      return v_subjects;
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20079,
            'No subjects found for Student ID ' || p_student_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20080,
            'Multiple subjects found for Student ID ' || p_student_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20081,
            'Other error when reading subjects by student: Student ID ' || p_student_id || '. Error: ' || SQLERRM
         );
   end get_subjects_by_student;

end pkg_student_subject;
/