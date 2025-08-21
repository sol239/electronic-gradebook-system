/*
   File: pkg_student_subject_teacher.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for operations on the Student_Subject_Teacher table.
*/

-- Package specification
create or replace package pkg_student_subject_teacher as

    /*
       Adds a student-subject-teacher link to the Student_Subject_Teacher table.
       Parameters:
         p_student_id - ID of the student
         p_subject_id - ID of the subject
         p_teacher_id - ID of the teacher
    */
   procedure add_student_subject_teacher (
      p_student_id in number,
      p_subject_id in number,
      p_teacher_id in number
   );

    /*
       Deletes a student-subject-teacher link from the Student_Subject_Teacher table.
       Parameters:
         p_student_id - ID of the student
         p_subject_id - ID of the subject
         p_teacher_id - ID of the teacher
    */
   procedure delete_student_subject_teacher (
      p_student_id in number,
      p_subject_id in number,
      p_teacher_id in number
   );

    /*
       Updates a student-subject-teacher link in the Student_Subject_Teacher table.
       Parameters:
         p_old_student_id - Existing student ID
         p_old_subject_id - Existing subject ID
         p_old_teacher_id - Existing teacher ID
         p_new_student_id - New student ID
         p_new_subject_id - New subject ID
         p_new_teacher_id - New teacher ID
    */
   procedure update_student_subject_teacher (
      p_old_student_id in number,
      p_old_subject_id in number,
      p_old_teacher_id in number,
      p_new_student_id in number,
      p_new_subject_id in number,
      p_new_teacher_id in number
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
       Type for returning a list of teacher IDs.
    */
   type teacher_id_table is
      table of number;

    /*
       Returns all student IDs for a given subject and teacher.
       Parameters:
         p_subject_id - ID of the subject
         p_teacher_id - ID of the teacher
       Returns:
         student_id_table with student IDs.
    */
   function get_students_by_subject_teacher (
      p_subject_id in number,
      p_teacher_id in number
   ) return student_id_table;

    /*
       Returns all subject IDs for a given student and teacher.
       Parameters:
         p_student_id - ID of the student
         p_teacher_id - ID of the teacher
       Returns:
         subject_id_table with subject IDs.
    */
   function get_subjects_by_student_teacher (
      p_student_id in number,
      p_teacher_id in number
   ) return subject_id_table;

    /*
       Returns all teacher IDs for a given student and subject.
       Parameters:
         p_student_id - ID of the student
         p_subject_id - ID of the subject
       Returns:
         teacher_id_table with teacher IDs.
    */
   function get_teachers_by_student_subject (
      p_student_id in number,
      p_subject_id in number
   ) return teacher_id_table;

   /*
      Type for student-subject-teacher record.
   */
   type student_subject_teacher_rec is record (
         student_id number,
         subject_id number,
         teacher_id number
   );
end pkg_student_subject_teacher;
/

-- Package body
create or replace package body pkg_student_subject_teacher as

   procedure add_student_subject_teacher (
      p_student_id in number,
      p_subject_id in number,
      p_teacher_id in number
   ) as
   begin
      insert into student_subject_teacher (
         student_id,
         subject_id,
         teacher_id
      ) values ( p_student_id,
                 p_subject_id,
                 p_teacher_id );
      dbms_output.put_line('Student-Subject-Teacher link added: Student ID '
                           || p_student_id
                           || ', Subject ID '
                           || p_subject_id
                           || ', Teacher ID '
                           || p_teacher_id);
      commit;
   exception
      when dup_val_on_index then
         rollback;
         raise_application_error(
            -20071,
            'Student-Subject-Teacher link already exists for Student ID '
            || p_student_id
            || ', Subject ID '
            || p_subject_id
            || ', Teacher ID '
            || p_teacher_id
         );
      when value_error then
         rollback;
         raise_application_error(
            -20072,
            'Invalid value or data type for Student-Subject-Teacher link: Student ID '
            || p_student_id
            || ', Subject ID '
            || p_subject_id
            || ', Teacher ID '
            || p_teacher_id
         );
      when others then
         rollback;
         raise_application_error(
            -20073,
            'Other error when adding Student-Subject-Teacher link: Student ID '
            || p_student_id
            || ', Subject ID '
            || p_subject_id
            || ', Teacher ID '
            || p_teacher_id
            || '. Error: '
            || sqlerrm
         );
   end add_student_subject_teacher;

   procedure delete_student_subject_teacher (
      p_student_id in number,
      p_subject_id in number,
      p_teacher_id in number
   ) as
      v_deleted number;
   begin
      delete from student_subject_teacher
       where student_id = p_student_id
         and subject_id = p_subject_id
         and teacher_id = p_teacher_id
       returning 1 into v_deleted;
      dbms_output.put_line('Student-Subject-Teacher link deleted: Student ID '
                           || p_student_id
                           || ', Subject ID '
                           || p_subject_id
                           || ', Teacher ID '
                           || p_teacher_id);
      commit;
   exception
      when no_data_found then
         rollback;
         raise_application_error(
            -20074,
            'No Student-Subject-Teacher link found for Student ID '
            || p_student_id
            || ', Subject ID '
            || p_subject_id
            || ', Teacher ID '
            || p_teacher_id
         );
      when others then
         rollback;
         raise_application_error(
            -20075,
            'Other error when deleting Student-Subject-Teacher link: Student ID '
            || p_student_id
            || ', Subject ID '
            || p_subject_id
            || ', Teacher ID '
            || p_teacher_id
            || '. Error: '
            || sqlerrm
         );
   end delete_student_subject_teacher;

   procedure update_student_subject_teacher (
      p_old_student_id in number,
      p_old_subject_id in number,
      p_old_teacher_id in number,
      p_new_student_id in number,
      p_new_subject_id in number,
      p_new_teacher_id in number
   ) as
      v_updated number;
   begin
      update student_subject_teacher
         set student_id = p_new_student_id,
             subject_id = p_new_subject_id,
             teacher_id = p_new_teacher_id
       where student_id = p_old_student_id
         and subject_id = p_old_subject_id
         and teacher_id = p_old_teacher_id
       returning 1 into v_updated;
      dbms_output.put_line('Student-Subject-Teacher link updated: Old Student ID '
                           || p_old_student_id
                           || ', Old Subject ID '
                           || p_old_subject_id
                           || ', Old Teacher ID '
                           || p_old_teacher_id
                           || ' -> New Student ID '
                           || p_new_student_id
                           || ', New Subject ID '
                           || p_new_subject_id
                           || ', New Teacher ID '
                           || p_new_teacher_id);
      commit;
   exception
      when no_data_found then
         rollback;
         raise_application_error(
            -20082,
            'No Student-Subject-Teacher link found to update: Old Student ID '
            || p_old_student_id
            || ', Old Subject ID '
            || p_old_subject_id
            || ', Old Teacher ID '
            || p_old_teacher_id
         );
      when dup_val_on_index then
         rollback;
         raise_application_error(
            -20083,
            'Student-Subject-Teacher link already exists for New Student ID '
            || p_new_student_id
            || ', New Subject ID '
            || p_new_subject_id
            || ', New Teacher ID '
            || p_new_teacher_id);
   end update_student_subject_teacher;

   /*
       Returns all student IDs for a given subject and teacher.
       Parameters:
         p_subject_id - ID of the subject
         p_teacher_id - ID of the teacher
       Returns:
         student_id_table with student IDs.
    */
   function get_students_by_subject_teacher (
      p_subject_id in number,
      p_teacher_id in number
   ) return student_id_table is
      v_students student_id_table;
   begin
      select student_id
      bulk collect
        into v_students
        from student_subject_teacher
       where subject_id = p_subject_id
         and teacher_id = p_teacher_id;
      return v_students;
   exception
      when no_data_found then
         raise_application_error(
            -20079,
            'No students found for Subject ID ' || p_subject_id || ' and Teacher ID ' || p_teacher_id
         );
      when too_many_rows then
         raise_application_error(
            -20080,
            'Multiple students found for Subject ID ' || p_subject_id || ' and Teacher ID ' || p_teacher_id
         );
      when others then
         raise_application_error(
            -20081,
            'Other error when reading students by subject and teacher: Subject ID '
            || p_subject_id
            || ', Teacher ID ' || p_teacher_id
            || '. Error: '
            || sqlerrm
         );
   end get_students_by_subject_teacher;

   /*
       Returns all subject IDs for a given student and teacher.
       Parameters:
         p_student_id - ID of the student
         p_teacher_id - ID of the teacher
       Returns:
         subject_id_table with subject IDs.
    */
   function get_subjects_by_student_teacher (
      p_student_id in number,
      p_teacher_id in number
   ) return subject_id_table is
      v_subjects subject_id_table;
   begin
      select subject_id
      bulk collect
        into v_subjects
        from student_subject_teacher
       where student_id = p_student_id
         and teacher_id = p_teacher_id;
      return v_subjects;
   exception
      when no_data_found then
         raise_application_error(
            -20079,
            'No subjects found for Student ID ' || p_student_id
         );
      when too_many_rows then
         raise_application_error(
            -20080,
            'Multiple subjects found for Student ID ' || p_student_id
         );
      when others then
         raise_application_error(
            -20081,
            'Other error when reading subjects by student: Student ID '
            || p_student_id
            || '. Error: '
            || sqlerrm
         );
   end get_subjects_by_student_teacher;

   /*
       Returns all teacher IDs for a given student and subject.
       Parameters:
         p_student_id - ID of the student
         p_subject_id - ID of the subject
       Returns:
         teacher_id_table with teacher IDs.
    */
   function get_teachers_by_student_subject (
      p_student_id in number,
      p_subject_id in number
   ) return teacher_id_table is
      v_teachers teacher_id_table;
   begin
      select teacher_id
      bulk collect
        into v_teachers
        from student_subject_teacher
       where student_id = p_student_id
         and subject_id = p_subject_id;
      return v_teachers;
   exception
      when no_data_found then
         raise_application_error(
            -20079,
            'No teachers found for Student ID ' || p_student_id || ' and Subject ID ' || p_subject_id
         );
      when too_many_rows then
         raise_application_error(
            -20080,
            'Multiple teachers found for Student ID ' || p_student_id || ' and Subject ID ' || p_subject_id
         );
      when others then
         raise_application_error(
            -20081,
            'Other error when reading teachers by student and subject: Student ID '
            || p_student_id
            || ', Subject ID ' || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end get_teachers_by_student_subject;

end pkg_student_subject_teacher;
/