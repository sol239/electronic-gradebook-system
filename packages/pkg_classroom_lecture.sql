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

   type classroom_lecture_rec is record (
         classroom_id number,
         lecture_id   number
   );

    /*
       Updates an existing classroom-lecture link.
       Parameters:
         p_classroom_id      - old classroom ID
         p_lecture_id        - old lecture ID
         p_new_classroom_id  - new classroom ID
         p_new_lecture_id    - new lecture ID
    */
   procedure update_classroom_lecture (
      p_classroom_id     in number,
      p_lecture_id       in number,
      p_new_classroom_id in number,
      p_new_lecture_id   in number
   );

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
      commit;
   exception
      when dup_val_on_index then
         rollback;
         raise_application_error(
            -20191,
            'Classroom-Lecture link already exists for Classroom ID '
            || p_classroom_id
            || ', Lecture ID '
            || p_lecture_id
         );
      when value_error then
         rollback;
         raise_application_error(
            -20192,
            'Type or length error when adding Classroom-Lecture link: Classroom ID '
            || p_classroom_id
            || ', Lecture ID '
            || p_lecture_id
         );
      when others then
         rollback;
         raise_application_error(
            -20193,
            'Unexpected error when adding Classroom-Lecture link: Classroom ID '
            || p_classroom_id
            || ', Lecture ID '
            || p_lecture_id
            || '. Error: '
            || sqlerrm
         );
   end add_classroom_lecture;

   procedure update_classroom_lecture (
      p_classroom_id     in number,
      p_lecture_id       in number,
      p_new_classroom_id in number,
      p_new_lecture_id   in number
   ) as
      v_updated number;
   begin
      update classroom_lecture
         set classroom_id = p_new_classroom_id,
             lecture_id = p_new_lecture_id
       where classroom_id = p_classroom_id
         and lecture_id = p_lecture_id returning 1 into v_updated;
      dbms_output.put_line('Classroom-Lecture link updated: Old (Classroom ID '
                           || p_classroom_id
                           || ', Lecture ID '
                           || p_lecture_id
                           || ') -> New (Classroom ID '
                           || p_new_classroom_id
                           || ', Lecture ID '
                           || p_new_lecture_id
                           || ')');
      commit;
   exception
      when dup_val_on_index then
         rollback;
         raise_application_error(
            -20198,
            'Update would create duplicate Classroom-Lecture link: Classroom ID '
            || p_new_classroom_id
            || ', Lecture ID '
            || p_new_lecture_id
         );
      when value_error then
         rollback;
         raise_application_error(
            -20199,
            'Type or length error when updating Classroom-Lecture link: Old (Classroom ID '
            || p_classroom_id
            || ', Lecture ID '
            || p_lecture_id
            || ')'
         );
      when no_data_found then
         rollback;
         raise_application_error(
            -20200,
            'No Classroom-Lecture link found for: Classroom ID '
            || p_classroom_id
            || ', Lecture ID '
            || p_lecture_id
         );
      when others then
         rollback;
         raise_application_error(
            -20201,
            'Unexpected error when updating Classroom-Lecture link: Old (Classroom ID '
            || p_classroom_id
            || ', Lecture ID '
            || p_lecture_id
            || '). Error: '
            || sqlerrm
         );
   end update_classroom_lecture;

   procedure delete_classroom_lecture (
      p_classroom_id in number,
      p_lecture_id   in number
   ) as
      v_deleted number;
   begin
      delete from classroom_lecture
       where classroom_id = p_classroom_id
         and lecture_id = p_lecture_id returning 1 into v_deleted;
      dbms_output.put_line('Classroom-Lecture link deleted: Classroom ID '
                           || p_classroom_id
                           || ', Lecture ID '
                           || p_lecture_id);
      commit;
   exception
      when no_data_found then
         rollback;
         raise_application_error(
            -20194,
            'No Classroom-Lecture link found for Classroom ID '
            || p_classroom_id
            || ', Lecture ID '
            || p_lecture_id
         );
      when others then
         rollback;
         raise_application_error(
            -20195,
            'Unexpected error when deleting Classroom-Lecture link: Classroom ID '
            || p_classroom_id
            || ', Lecture ID '
            || p_lecture_id
            || '. Error: '
            || sqlerrm
         );
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
   exception
      when others then
         raise_application_error(
            -20196,
            'Unexpected error when reading lectures by classroom: Classroom ID '
            || p_classroom_id
            || '. Error: '
            || sqlerrm
         );
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
   exception
      when others then
         raise_application_error(
            -20197,
            'Unexpected error when reading classrooms by lecture: Lecture ID '
            || p_lecture_id
            || '. Error: '
            || sqlerrm
         );
   end get_classrooms_by_lecture;

end pkg_classroom_lecture;
/