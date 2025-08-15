/*
   File: pkg_lecture.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Lecture table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
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
      p_start_time   in timestamp,
      p_end_time     in timestamp,
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
      p_start_time   in timestamp,
      p_end_time     in timestamp,
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
         start_time   timestamp,
         end_time     timestamp,
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

end pkg_lecture;
/

-- Package body
create or replace package body pkg_lecture as

   procedure add_lecture (
      p_subject_id   in number,
      p_start_time   in timestamp,
      p_end_time     in timestamp,
      p_description  in varchar2 default null
   ) as
   begin
      insert into lecture (
         subject_id,
         start_time,
         end_time,
         description
      ) values ( p_subject_id,
                 p_start_time,
                 p_end_time,
                 p_description );
      dbms_output.put_line('Lecture added: Subject ID '
                           || p_subject_id);
   end add_lecture;

   procedure update_lecture (
      p_lecture_id   in number,
      p_subject_id   in number,
      p_start_time   in timestamp,
      p_end_time     in timestamp,
      p_description  in varchar2 default null
   ) as
   begin
      update lecture
         set subject_id = p_subject_id,
             start_time = p_start_time,
             end_time = p_end_time,
             description = p_description
       where lecture_id = p_lecture_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No lecture found with ID ' || p_lecture_id);
      else
         dbms_output.put_line('Lecture updated: ID ' || p_lecture_id);
      end if;
   end update_lecture;

   procedure delete_lecture (
      p_lecture_id in number
   ) as
   begin
      delete from lecture
       where lecture_id = p_lecture_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No lecture found with ID ' || p_lecture_id);
      else
         dbms_output.put_line('Lecture deleted: ID ' || p_lecture_id);
      end if;
   end delete_lecture;

   function get_lecture_by_id (
      p_lecture_id in number
   ) return lecture_rec as
      v_lecture lecture_rec;
   begin
      select lecture_id,
             subject_id,
             start_time,
             end_time,
             description
        into v_lecture
        from lecture
       where lecture_id = p_lecture_id;

      return v_lecture;
   exception
      when no_data_found then
         return null;
   end get_lecture_by_id;

end pkg_lecture;
/