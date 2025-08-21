/*
   File: pkg_student_parent.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for operations on the Student_Parent table.
*/

-- Package specification
create or replace package pkg_student_parent as

    /*
       Adds a student-parent link to the Student_Parent table.
       Parameters:
         p_student_id - ID of the student
         p_parent_id  - ID of the parent
    */
   procedure add_student_parent (
      p_student_id in number,
      p_parent_id  in number
   );

    /*
       Deletes a student-parent link from the Student_Parent table.
       Parameters:
         p_student_id - ID of the student
         p_parent_id  - ID of the parent
    */
   procedure delete_student_parent (
      p_student_id in number,
      p_parent_id  in number
   );

    /*
       Type for returning a list of student IDs.
    */
   type student_id_table is
      table of number;

    /*
       Type for returning a list of parent IDs.
    */
   type parent_id_table is
      table of number;

    /*
       Returns all student IDs for a given parent.
       Parameters:
         p_parent_id - ID of the parent
       Returns:
         student_id_table with student IDs.
    */
   function get_students_by_parent (
      p_parent_id in number
   ) return student_id_table;

    /*
       Returns all parent IDs for a given student.
       Parameters:
         p_student_id - ID of the student
       Returns:
         parent_id_table with parent IDs.
    */
   function get_parents_by_student (
      p_student_id in number
   ) return parent_id_table;

    /*
       Updates a student-parent link in the Student_Parent table.
       Parameters:
         p_old_student_id - Existing student ID
         p_old_parent_id  - Existing parent ID
         p_new_student_id - New student ID
         p_new_parent_id  - New parent ID
    */
   procedure update_student_parent (
      p_old_student_id in number,
      p_old_parent_id  in number,
      p_new_student_id in number,
      p_new_parent_id  in number
   );

   /*
      Type for linking students to their parents.
   */
   type student_parent_rec is record (
         student_id number,
         parent_id  number
   );
end pkg_student_parent;
/

-- Package body
create or replace package body pkg_student_parent as

   procedure add_student_parent (
      p_student_id in number,
      p_parent_id  in number
   ) as
   begin
      insert into student_parent (
         student_id,
         parent_id
      ) values ( p_student_id,
                 p_parent_id );
      dbms_output.put_line('Student-Parent link added: Student ID '
                           || p_student_id
                           || ', Parent ID '
                           || p_parent_id);
      commit;
   exception
      when dup_val_on_index then
         rollback;
         raise_application_error(
            -20091,
            'Student-Parent link already exists for Student ID '
            || p_student_id
            || ', Parent ID '
            || p_parent_id
         );
      when value_error then
         rollback;
         raise_application_error(
            -20092,
            'Invalid value or data type for Student-Parent link: Student ID '
            || p_student_id
            || ', Parent ID '
            || p_parent_id
         );
      when others then
         rollback;
         raise_application_error(
            -20093,
            'Other error when adding Student-Parent link: Student ID '
            || p_student_id
            || ', Parent ID '
            || p_parent_id
            || '. Error: '
            || sqlerrm
         );
   end add_student_parent;

   procedure delete_student_parent (
      p_student_id in number,
      p_parent_id  in number
   ) as
      v_deleted number;
   begin
      delete from student_parent
       where student_id = p_student_id
         and parent_id = p_parent_id returning 1 into v_deleted;
      dbms_output.put_line('Student-Parent link deleted: Student ID '
                           || p_student_id
                           || ', Parent ID '
                           || p_parent_id);
      commit;
   exception
      when no_data_found then
         rollback;
         raise_application_error(
            -20094,
            'No Student-Parent link found for Student ID '
            || p_student_id
            || ', Parent ID '
            || p_parent_id
         );
      when others then
         rollback;
         raise_application_error(
            -20095,
            'Other error when deleting Student-Parent link: Student ID '
            || p_student_id
            || ', Parent ID '
            || p_parent_id
            || '. Error: '
            || sqlerrm
         );
   end delete_student_parent;

   function get_students_by_parent (
      p_parent_id in number
   ) return student_id_table as
      v_students student_id_table;
   begin
      select student_id
      bulk collect
        into v_students
        from student_parent
       where parent_id = p_parent_id;
      return v_students;
   exception
      when no_data_found then
         raise_application_error(
            -20096,
            'No students found for Parent ID ' || p_parent_id
         );
      when too_many_rows then
         raise_application_error(
            -20097,
            'Multiple students found for Parent ID ' || p_parent_id
         );
      when others then
         raise_application_error(
            -20098,
            'Other error when reading students by parent: Parent ID '
            || p_parent_id
            || '. Error: '
            || sqlerrm
         );
   end get_students_by_parent;

   function get_parents_by_student (
      p_student_id in number
   ) return parent_id_table as
      v_parents parent_id_table;
   begin
      select parent_id
      bulk collect
        into v_parents
        from student_parent
       where student_id = p_student_id;
      return v_parents;
   exception
      when no_data_found then
         raise_application_error(
            -20099,
            'No parents found for Student ID ' || p_student_id
         );
      when too_many_rows then
         raise_application_error(
            -20100,
            'Multiple parents found for Student ID ' || p_student_id
         );
      when others then
         raise_application_error(
            -20101,
            'Other error when reading parents by student: Student ID '
            || p_student_id
            || '. Error: '
            || sqlerrm
         );
   end get_parents_by_student;

   procedure update_student_parent (
      p_old_student_id in number,
      p_old_parent_id  in number,
      p_new_student_id in number,
      p_new_parent_id  in number
   ) as
      v_updated number;
   begin
      update student_parent
         set student_id = p_new_student_id,
             parent_id  = p_new_parent_id
       where student_id = p_old_student_id
         and parent_id  = p_old_parent_id
       returning 1 into v_updated;
      dbms_output.put_line('Student-Parent link updated: Old Student ID '
                           || p_old_student_id
                           || ', Old Parent ID '
                           || p_old_parent_id
                           || ' -> New Student ID '
                           || p_new_student_id
                           || ', New Parent ID '
                           || p_new_parent_id);
      commit;
   exception
      when no_data_found then
         rollback;
         raise_application_error(
            -20102,
            'No Student-Parent link found to update: Old Student ID '
            || p_old_student_id
            || ', Old Parent ID '
            || p_old_parent_id
         );
      when dup_val_on_index then
         rollback;
         raise_application_error(
            -20103,
            'Student-Parent link already exists for New Student ID '
            || p_new_student_id
            || ', New Parent ID '
            || p_new_parent_id
         );
      when value_error then
         rollback;
         raise_application_error(
            -20104,
            'Invalid value or data type for updating Student-Parent link: New Student ID '
            || p_new_student_id
            || ', New Parent ID '
            || p_new_parent_id
         );
      when others then
         rollback;
         raise_application_error(
            -20105,
            'Other error when updating Student-Parent link: Old Student ID '
            || p_old_student_id
            || ', Old Parent ID '
            || p_old_parent_id
            || '. Error: '
            || sqlerrm
         );
   end update_student_parent;

end pkg_student_parent;
/