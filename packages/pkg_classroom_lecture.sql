/*
   File: pkg_classroom_lecture.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for operations on the Classroom_Lecture table.
   Notes:
     - Links classrooms to their lectures.
     - Includes procedures: add, delete, get lectures by classroom, get classrooms by lecture.
*/

-- Package specification
create or replace package pkg_classroom_lecture as

    /*
       Adds a classroom-lecture link to the Classroom_Lecture table.
       Parameters:
         p_classroom_id - ID of the classroom
         p_lecture_id   - ID of the lecture
    */
   procedure add_classroom_lecture (
      p_classroom_id in number,
      p_lecture_id   in number
   );

    /*
       Deletes a classroom-lecture link from the Classroom_Lecture table.
       Parameters:
         p_classroom_id - ID of the classroom
         p_lecture_id   - ID of the lecture
    */
   procedure delete_classroom_lecture (
      p_classroom_id in number,
      p_lecture_id   in number
   );

    /*
       Type for returning a list of classroom IDs.
    */
   type classroom_id_table is
      table of number;

    /*
       Type for returning a list of lecture IDs.
    */
   type lecture_id_table is
      table of number;

    /*
       Returns all lecture IDs for a given classroom.
       Parameters:
         p_classroom_id - ID of the classroom
       Returns:
         lecture_id_table with lecture IDs.
    */
   function get_lectures_by_classroom (
      p_classroom_id in number
   ) return lecture_id_table;

    /*
       Returns all classroom IDs for a given lecture.
       Parameters:
         p_lecture_id - ID of the lecture
       Returns:
         classroom_id_table with classroom IDs.
    */
   function get_classrooms_by_lecture (
      p_lecture_id in number
   ) return classroom_id_table;

end pkg_classroom_lecture;
/

-- Package body
create or replace package body pkg_classroom_lecture as

   procedure add_classroom_lecture (
      p_classroom_id in number,
      p_lecture_id   in number
   ) as
   begin
      insert into classroom_lecture (
         classroom_id,
         lecture_id
      ) values ( p_classroom_id,
                 p_lecture_id );
      dbms_output.put_line('Classroom-Lecture link added: Classroom ID '
                           || p_classroom_id
                           || ', Lecture ID '
                           || p_lecture_id);
   exception
      when DUP_VAL_ON_INDEX then
         RAISE_APPLICATION_ERROR(
            -20191,
            'Classroom-Lecture link already exists for Classroom ID ' || p_classroom_id || ', Lecture ID ' || p_lecture_id
         );
   end add_classroom_lecture;

   procedure delete_classroom_lecture (
      p_classroom_id in number,
      p_lecture_id   in number
   ) as
   begin
      delete from classroom_lecture
       where classroom_id = p_classroom_id
         and lecture_id = p_lecture_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No Classroom-Lecture link found for Classroom ID '
                              || p_classroom_id
                              || ', Lecture ID '
                              || p_lecture_id);
      else
         dbms_output.put_line('Classroom-Lecture link deleted: Classroom ID '
                              || p_classroom_id
                              || ', Lecture ID '
                              || p_lecture_id);
      end if;
   end delete_classroom_lecture;

   function get_lectures_by_classroom (
      p_classroom_id in number
   ) return lecture_id_table as
      v_lectures lecture_id_table;
   begin
      select lecture_id
      bulk collect
        into v_lectures
        from classroom_lecture
       where classroom_id = p_classroom_id;
      return v_lectures;
   end get_lectures_by_classroom;

   function get_classrooms_by_lecture (
      p_lecture_id in number
   ) return classroom_id_table as
      v_classrooms classroom_id_table;
   begin
      select classroom_id
      bulk collect
        into v_classrooms
        from classroom_lecture
       where lecture_id = p_lecture_id;
      return v_classrooms;
   end get_classrooms_by_lecture;

end pkg_classroom_lecture;
/
