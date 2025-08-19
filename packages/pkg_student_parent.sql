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
   exception
      when DUP_VAL_ON_INDEX then
         RAISE_APPLICATION_ERROR(
            -20091,
            'Student-Parent link already exists for Student ID ' || p_student_id || ', Parent ID ' || p_parent_id
         );
   end add_student_parent;

   procedure delete_student_parent (
      p_student_id in number,
      p_parent_id  in number
   ) as
   begin
      delete from student_parent
       where student_id = p_student_id
         and parent_id = p_parent_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No Student-Parent link found for Student ID '
                              || p_student_id
                              || ', Parent ID '
                              || p_parent_id);
      else
         dbms_output.put_line('Student-Parent link deleted: Student ID '
                              || p_student_id
                              || ', Parent ID '
                              || p_parent_id);
      end if;
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
   end get_parents_by_student;

end pkg_student_parent;
/