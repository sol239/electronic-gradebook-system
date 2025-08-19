/*
   File: pkg_lecture_teacher.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for operations on the Lecture_Teacher table.
   Notes:
     - Links lectures to their teachers.
     - Includes procedures: add, delete, get lectures by teacher, get teachers by lecture.
*/

-- Package specification
create or replace package pkg_lecture_teacher as

    /*
       Adds a lecture-teacher link to the Lecture_Teacher table.
       Parameters:
         p_lecture_id - ID of the lecture
         p_teacher_id - ID of the teacher
    */
   procedure add_lecture_teacher (
      p_lecture_id in number,
      p_teacher_id in number
   );

    /*
       Deletes a lecture-teacher link from the Lecture_Teacher table.
       Parameters:
         p_lecture_id - ID of the lecture
         p_teacher_id - ID of the teacher
    */
   procedure delete_lecture_teacher (
      p_lecture_id in number,
      p_teacher_id in number
   );

    /*
       Type for returning a list of lecture IDs.
    */
   type lecture_id_table is
      table of number;

    /*
       Type for returning a list of teacher IDs.
    */
   type teacher_id_table is
      table of number;

    /*
       Returns all lecture IDs for a given teacher.
       Parameters:
         p_teacher_id - ID of the teacher
       Returns:
         lecture_id_table with lecture IDs.
    */
   function get_lectures_by_teacher (
      p_teacher_id in number
   ) return lecture_id_table;

    /*
       Returns all teacher IDs for a given lecture.
       Parameters:
         p_lecture_id - ID of the lecture
       Returns:
         teacher_id_table with teacher IDs.
    */
   function get_teachers_by_lecture (
      p_lecture_id in number
   ) return teacher_id_table;

end pkg_lecture_teacher;
/

-- Package body
create or replace package body pkg_lecture_teacher as

   procedure add_lecture_teacher (
      p_lecture_id in number,
      p_teacher_id in number
   ) as
   begin
      insert into lecture_teacher (
         lecture_id,
         teacher_id
      ) values ( p_lecture_id,
                 p_teacher_id );
      dbms_output.put_line('Lecture-Teacher link added: Lecture ID '
                           || p_lecture_id
                           || ', Teacher ID '
                           || p_teacher_id);
      commit;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20241,
            'Lecture-Teacher link already exists for Lecture ID ' || p_lecture_id || ', Teacher ID ' || p_teacher_id
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20242,
            'Type or length error when adding Lecture-Teacher link: Lecture ID ' || p_lecture_id || ', Teacher ID ' || p_teacher_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20243,
            'Unexpected error when adding Lecture-Teacher link: Lecture ID ' || p_lecture_id || ', Teacher ID ' || p_teacher_id || '. Error: ' || SQLERRM
         );
   end add_lecture_teacher;

   procedure delete_lecture_teacher (
      p_lecture_id in number,
      p_teacher_id in number
   ) as
      v_deleted number;
   begin
      delete from lecture_teacher
       where lecture_id = p_lecture_id
         and teacher_id = p_teacher_id
       returning 1 into v_deleted;
      dbms_output.put_line('Lecture-Teacher link deleted: Lecture ID '
                           || p_lecture_id
                           || ', Teacher ID '
                           || p_teacher_id);
      commit;
   exception
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20244,
            'No Lecture-Teacher link found for Lecture ID ' || p_lecture_id || ', Teacher ID ' || p_teacher_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20245,
            'Unexpected error when deleting Lecture-Teacher link: Lecture ID ' || p_lecture_id || ', Teacher ID ' || p_teacher_id || '. Error: ' || SQLERRM
         );
   end delete_lecture_teacher;

   function get_lectures_by_teacher (
      p_teacher_id in number
   ) return lecture_id_table as
      v_lectures lecture_id_table;
   begin
      select lecture_id
      bulk collect
        into v_lectures
        from lecture_teacher
       where teacher_id = p_teacher_id;
      return v_lectures;
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20246,
            'No lectures found for Teacher ID ' || p_teacher_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20247,
            'Multiple lectures found for Teacher ID ' || p_teacher_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20248,
            'Unexpected error when reading lectures by teacher: Teacher ID ' || p_teacher_id || '. Error: ' || SQLERRM
         );
   end get_lectures_by_teacher;

   function get_teachers_by_lecture (
      p_lecture_id in number
   ) return teacher_id_table as
      v_teachers teacher_id_table;
   begin
      select teacher_id
      bulk collect
        into v_teachers
        from lecture_teacher
       where lecture_id = p_lecture_id;
      return v_teachers;
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20249,
            'No teachers found for Lecture ID ' || p_lecture_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20250,
            'Multiple teachers found for Lecture ID ' || p_lecture_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20251,
            'Unexpected error when reading teachers by lecture: Lecture ID ' || p_lecture_id || '. Error: ' || SQLERRM
         );
   end get_teachers_by_lecture;

end pkg_lecture_teacher;
/
