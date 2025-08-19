/*
   File: pkg_student_parent.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for operations on the Student_Parent table.
   Notes:
     - Links students to their parents.
     - Includes procedures: add, delete, get students by parent, get parents by student.
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
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20091,
            'Student-Parent link already exists for Student ID ' || p_student_id || ', Parent ID ' || p_parent_id
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20092,
            'Invalid value or data type for Student-Parent link: Student ID ' || p_student_id || ', Parent ID ' || p_parent_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20093,
            'Other error when adding Student-Parent link: Student ID ' || p_student_id || ', Parent ID ' || p_parent_id || '. Error: ' || SQLERRM
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
         and parent_id = p_parent_id
       returning 1 into v_deleted;
      dbms_output.put_line('Student-Parent link deleted: Student ID '
                           || p_student_id
                           || ', Parent ID '
                           || p_parent_id);
      commit;
   exception
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20094,
            'No Student-Parent link found for Student ID ' || p_student_id || ', Parent ID ' || p_parent_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20095,
            'Other error when deleting Student-Parent link: Student ID ' || p_student_id || ', Parent ID ' || p_parent_id || '. Error: ' || SQLERRM
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
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20096,
            'No students found for Parent ID ' || p_parent_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20097,
            'Multiple students found for Parent ID ' || p_parent_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20098,
            'Other error when reading students by parent: Parent ID ' || p_parent_id || '. Error: ' || SQLERRM
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
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20099,
            'No parents found for Student ID ' || p_student_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20100,
            'Multiple parents found for Student ID ' || p_student_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20101,
            'Other error when reading parents by student: Student ID ' || p_student_id || '. Error: ' || SQLERRM
         );
   end get_parents_by_student;

end pkg_student_parent;
/