/*
   File: pkg_lecture_student.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for operations on the Lecture_Student table.
*/

-- Package specification
create or replace package pkg_lecture_student as

    /*
       Adds a lecture-student link to the Lecture_Student table.
       Parameters:
         p_lecture_id - ID of the lecture
         p_student_id - ID of the student
    */
   procedure add_lecture_student (
      p_lecture_id in number,
      p_student_id in number
   );

    /*
       Deletes a lecture-student link from the Lecture_Student table.
       Parameters:
         p_lecture_id - ID of the lecture
         p_student_id - ID of the student
    */
   procedure delete_lecture_student (
      p_lecture_id in number,
      p_student_id in number
   );

    /*
       Type for returning a list of lecture IDs.
    */
   type lecture_id_table is
      table of number;

    /*
       Type for returning a list of student IDs.
    */
   type student_id_table is
      table of number;

    /*
       Returns all lecture IDs for a given student.
       Parameters:
         p_student_id - ID of the student
       Returns:
         lecture_id_table with lecture IDs.
    */
   function get_lectures_by_student (
      p_student_id in number
   ) return lecture_id_table;

    /*
       Returns all student IDs for a given lecture.
       Parameters:
         p_lecture_id - ID of the lecture
       Returns:
         student_id_table with student IDs.
    */
   function get_students_by_lecture (
      p_lecture_id in number
   ) return student_id_table;

    /*
       Updates a lecture-student link in the Lecture_Student table.
       Parameters:
         p_old_lecture_id - Existing lecture ID
         p_old_student_id - Existing student ID
         p_new_lecture_id - New lecture ID
         p_new_student_id - New student ID
    */
   procedure update_lecture_student (
      p_old_lecture_id in number,
      p_old_student_id in number,
      p_new_lecture_id in number,
      p_new_student_id in number
   );

   /*
       Type for linking lectures to students.
   */
   type lecture_student_rec is record (
         lecture_id number,
         student_id number
   );
end pkg_lecture_student;
/

-- Package body
create or replace package body pkg_lecture_student as

   procedure add_lecture_student (
      p_lecture_id in number,
      p_student_id in number
   ) as
   begin
      insert into lecture_student (
         lecture_id,
         student_id
      ) values ( p_lecture_id,
                 p_student_id );
      dbms_output.put_line('Lecture-Student link added: Lecture ID '
                           || p_lecture_id
                           || ', Student ID '
                           || p_student_id);
      commit;
   exception
      when dup_val_on_index then
         rollback;
         raise_application_error(
            -20231,
            'Lecture-Student link already exists for Lecture ID '
            || p_lecture_id
            || ', Student ID '
            || p_student_id
         );
      when value_error then
         rollback;
         raise_application_error(
            -20232,
            'Type or length error when adding Lecture-Student link: Lecture ID '
            || p_lecture_id
            || ', Student ID '
            || p_student_id
         );
      when others then
         rollback;
         raise_application_error(
            -20233,
            'Unexpected error when adding Lecture-Student link: Lecture ID '
            || p_lecture_id
            || ', Student ID '
            || p_student_id
            || '. Error: '
            || sqlerrm
         );
   end add_lecture_student;

   procedure delete_lecture_student (
      p_lecture_id in number,
      p_student_id in number
   ) as
      v_deleted number;
   begin
      delete from lecture_student
       where lecture_id = p_lecture_id
         and student_id = p_student_id returning 1 into v_deleted;
      dbms_output.put_line('Lecture-Student link deleted: Lecture ID '
                           || p_lecture_id
                           || ', Student ID '
                           || p_student_id);
      commit;
   exception
      when no_data_found then
         rollback;
         raise_application_error(
            -20234,
            'No Lecture-Student link found for Lecture ID '
            || p_lecture_id
            || ', Student ID '
            || p_student_id
         );
      when others then
         rollback;
         raise_application_error(
            -20235,
            'Unexpected error when deleting Lecture-Student link: Lecture ID '
            || p_lecture_id
            || ', Student ID '
            || p_student_id
            || '. Error: '
            || sqlerrm
         );
   end delete_lecture_student;

   function get_lectures_by_student (
      p_student_id in number
   ) return lecture_id_table as
      v_lectures lecture_id_table;
   begin
      select lecture_id
      bulk collect
        into v_lectures
        from lecture_student
       where student_id = p_student_id;
      return v_lectures;
   exception
      when no_data_found then
         raise_application_error(
            -20236,
            'No lectures found for Student ID ' || p_student_id
         );
      when too_many_rows then
         raise_application_error(
            -20237,
            'Multiple lectures found for Student ID ' || p_student_id
         );
      when others then
         raise_application_error(
            -20238,
            'Unexpected error when reading lectures by student: Student ID '
            || p_student_id
            || '. Error: '
            || sqlerrm
         );
   end get_lectures_by_student;

   function get_students_by_lecture (
      p_lecture_id in number
   ) return student_id_table as
      v_students student_id_table;
   begin
      select student_id
      bulk collect
        into v_students
        from lecture_student
       where lecture_id = p_lecture_id;
      return v_students;
   exception
      when no_data_found then
         raise_application_error(
            -20239,
            'No students found for Lecture ID ' || p_lecture_id
         );
      when too_many_rows then
         raise_application_error(
            -20240,
            'Multiple students found for Lecture ID ' || p_lecture_id
         );
      when others then
         raise_application_error(
            -20241,
            'Unexpected error when reading students by lecture: Lecture ID '
            || p_lecture_id
            || '. Error: '
            || sqlerrm
         );
   end get_students_by_lecture;

   procedure update_lecture_student (
      p_old_lecture_id in number,
      p_old_student_id in number,
      p_new_lecture_id in number,
      p_new_student_id in number
   ) as
      v_updated number;
   begin
      update lecture_student
         set lecture_id = p_new_lecture_id,
             student_id = p_new_student_id
       where lecture_id = p_old_lecture_id
         and student_id = p_old_student_id
       returning 1 into v_updated;
      dbms_output.put_line('Lecture-Student link updated: Old Lecture ID '
                           || p_old_lecture_id
                           || ', Old Student ID '
                           || p_old_student_id
                           || ' -> New Lecture ID '
                           || p_new_lecture_id
                           || ', New Student ID '
                           || p_new_student_id);
      commit;
   exception
      when no_data_found then
         rollback;
         raise_application_error(
            -20242,
            'No Lecture-Student link found to update: Old Lecture ID '
            || p_old_lecture_id
            || ', Old Student ID '
            || p_old_student_id
         );
      when dup_val_on_index then
         rollback;
         raise_application_error(
            -20243,
            'Lecture-Student link already exists for New Lecture ID '
            || p_new_lecture_id
            || ', New Student ID '
            || p_new_student_id
         );
      when value_error then
         rollback;
         raise_application_error(
            -20244,
            'Type or length error when updating Lecture-Student link: New Lecture ID '
            || p_new_lecture_id
            || ', New Student ID '
            || p_new_student_id
         );
      when others then
         rollback;
         raise_application_error(
            -20245,
            'Unexpected error when updating Lecture-Student link: Old Lecture ID '
            || p_old_lecture_id
            || ', Old Student ID '
            || p_old_student_id
            || '. Error: '
            || sqlerrm
         );
   end update_lecture_student;

end pkg_lecture_student;
/