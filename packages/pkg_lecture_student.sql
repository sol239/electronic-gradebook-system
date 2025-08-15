/*
   File: pkg_lecture_student.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for operations on the Lecture_Student table.
   Notes:
     - Links lectures to their students.
     - Includes procedures: add, delete, get lectures by student, get students by lecture.
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
   end add_lecture_student;

   procedure delete_lecture_student (
      p_lecture_id in number,
      p_student_id in number
   ) as
   begin
      delete from lecture_student
       where lecture_id = p_lecture_id
         and student_id = p_student_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No Lecture-Student link found for Lecture ID '
                              || p_lecture_id
                              || ', Student ID '
                              || p_student_id);
      else
         dbms_output.put_line('Lecture-Student link deleted: Lecture ID '
                              || p_lecture_id
                              || ', Student ID '
                              || p_student_id);
      end if;
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
   end get_students_by_lecture;

end pkg_lecture_student;
/
