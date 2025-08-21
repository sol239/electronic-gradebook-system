/*
   File: pkg_lecture.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Lecture table.
*/

-- Package specification
create or replace package pkg_lecture as

    /*
       Adds a new lecture to the Lecture table.
       Parameters:
         p_subject_id   - ID of the subject
         p_start_time   - start time of the lecture
         p_end_time     - end time of the lecture
         p_description  - optional description of the lecture
    */
   procedure add_lecture (
      p_subject_id   in number,
      p_classroom_id in number,
      p_start_time   in timestamp,
      p_end_time     in timestamp,
      p_lecture_name         in varchar2,
      p_description  in varchar2 default null
   );

    /*
       Updates an existing lecture in the Lecture table.
       Parameters:
         p_lecture_id   - ID of the lecture to update
         p_subject_id   - new subject ID
         p_start_time   - new start time
         p_end_time     - new end time
         p_description  - new description
    */
   procedure update_lecture (
      p_lecture_id   in number,
      p_subject_id   in number,
      p_classroom_id in number,
      p_start_time   in timestamp,
      p_end_time     in timestamp,
      p_lecture_name   in varchar2 default null,
      p_description  in varchar2 default null
   );

    /*
       Deletes a lecture from the Lecture table.
       Parameters:
         p_lecture_id - ID of the lecture to delete
    */
   procedure delete_lecture (
      p_lecture_id in number
   );

    /*
       Type for return value of get_lecture_by_id function.
    */
   type lecture_rec is record (
         lecture_id   number,
         subject_id   number,
         classroom_id number,
         start_time   timestamp,
         end_time     timestamp,
         lecture_name varchar2(100),
         description  varchar2(500)
   );

    /*
       Returns lecture details by ID.
       Parameters:
         p_lecture_id - ID of the lecture
       Returns:
         lecture_rec with lecture details, or NULL if not found.
    */
   function get_lecture_by_id (
      p_lecture_id in number
   ) return lecture_rec;

    /*
       Returns lecture_id by natural key components.
       Parameters:
         p_subject_id - ID of the subject
         p_classroom_id - ID of the classroom
         p_start_time - start time of the lecture
       Returns:
         lecture_id if found, NULL otherwise.
    */
   function get_lecture_id_by_natural_key (
      p_subject_id in number,
      p_classroom_id in number,
      p_start_time in timestamp
   ) return number;

end pkg_lecture;
/

-- Package body
create or replace package body pkg_lecture as

   procedure add_lecture (
      p_subject_id   in number,
      p_classroom_id in number,
      p_start_time   in timestamp,
      p_end_time     in timestamp,
      p_lecture_name       in varchar2,
      p_description  in varchar2 default null
   ) as
   begin
      insert into lecture (
         subject_id,
         classroom_id,
         start_time,
         end_time,
         lecture_name,
         description
      ) values (
         p_subject_id,
         p_classroom_id,
         p_start_time,
         p_end_time,
         p_lecture_name,
         p_description
      );
      dbms_output.put_line('Lecture added: Subject ID ' || p_subject_id);
      commit;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20221,
            'Lecture with this subject, classroom, and start time already exists: Subject ID ' || p_subject_id || ', Classroom ID ' || p_classroom_id || ', Start Time ' || TO_CHAR(p_start_time, 'YYYY-MM-DD HH24:MI:SS')
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20222,
            'Type or length error when adding lecture: Subject ID ' || p_subject_id || ', Classroom ID ' || p_classroom_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20223,
            'Unexpected error when adding lecture: Subject ID ' || p_subject_id || ', Classroom ID ' || p_classroom_id || '. Error: ' || SQLERRM
         );
   end add_lecture;

   procedure update_lecture (
      p_lecture_id   in number,
      p_subject_id   in number,
      p_classroom_id in number,
      p_start_time   in timestamp,
      p_end_time     in timestamp,
      p_lecture_name in varchar2,
      p_description  in varchar2 default null
   ) as
      v_updated number;
   begin
      update lecture
         set subject_id   = p_subject_id,
             classroom_id = p_classroom_id,
             start_time   = p_start_time,
             end_time     = p_end_time,
             lecture_name = p_lecture_name,
             description  = p_description
       where lecture_id = p_lecture_id
       returning 1 into v_updated;
      dbms_output.put_line('Lecture updated: ID ' || p_lecture_id);
      commit;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20224,
            'Lecture with this subject, classroom, and start time already exists: Subject ID ' || p_subject_id || ', Classroom ID ' || p_classroom_id || ', Start Time ' || TO_CHAR(p_start_time, 'YYYY-MM-DD HH24:MI:SS')
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20225,
            'Type or length error when updating lecture: ID ' || p_lecture_id
         );
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20226,
            'No lecture found with ID ' || p_lecture_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20227,
            'Unexpected error when updating lecture: ID ' || p_lecture_id || '. Error: ' || SQLERRM
         );
   end update_lecture;

   procedure delete_lecture (
      p_lecture_id in number
   ) as
      v_deleted number;
   begin
      delete from lecture
       where lecture_id = p_lecture_id
       returning 1 into v_deleted;
      dbms_output.put_line('Lecture deleted: ID ' || p_lecture_id);
      commit;
   exception
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20228,
            'No lecture found with ID ' || p_lecture_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20229,
            'Unexpected error when deleting lecture: ID ' || p_lecture_id || '. Error: ' || SQLERRM
         );
   end delete_lecture;

   function get_lecture_by_id (
      p_lecture_id in number
   ) return lecture_rec as
      v_lecture lecture_rec;
   begin
      select lecture_id,
             subject_id,
             classroom_id,
             start_time,
             end_time,
             lecture_name,
             description
        into v_lecture
        from lecture
       where lecture_id = p_lecture_id;

      return v_lecture;
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20230,
            'No lecture found with ID ' || p_lecture_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20231,
            'Multiple lectures found with ID ' || p_lecture_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20232,
            'Unexpected error when reading lecture: ID ' || p_lecture_id || '. Error: ' || SQLERRM
         );
   end get_lecture_by_id;

   function get_lecture_id_by_natural_key (
      p_subject_id in number,
      p_classroom_id in number,
      p_start_time in timestamp
   ) return number as
      v_lecture_id number;
   begin
      select lecture_id
        into v_lecture_id
        from lecture
       where subject_id = p_subject_id
         and classroom_id = p_classroom_id
         and start_time = p_start_time;

      return v_lecture_id;
   exception
      when NO_DATA_FOUND then
         return null;
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20233,
            'Error when getting lecture ID by natural key: subject_id=' || p_subject_id || 
            ', classroom_id=' || p_classroom_id || ', start_time=' || TO_CHAR(p_start_time, 'YYYY-MM-DD HH24:MI:SS') || 
            '. Error: ' || SQLERRM
         );
   end get_lecture_id_by_natural_key;

end pkg_lecture;
/