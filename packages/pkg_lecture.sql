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
      p_lecture_name in varchar2,
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
      p_lecture_name in varchar2 default null,
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
      Deletes all subject's lectures
      Parameters:
         p_subject_id - ID of the subject
   */
   procedure delete_subject_lectures (
      p_subject_id in number
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
      p_subject_id   in number,
      p_classroom_id in number,
      p_start_time   in timestamp
   ) return number;

   /*
      Returns lecture ID by subject ID.
      Parameters:
         p_subject_id - ID of the subject
      Returns:
         lecture_id if found, NULL otherwise.
   */
   function get_lecture_by_subject_id (
      p_subject_id in number
   ) return number;

   /*
      Generates lecture entries for a subject.
      Parameters:
         p_from_date - start date for the lecture generation
         p_to_date   - end date for the lecture generation
         p_subject_id - ID of the subject for which to generate lectures
         p_start_time  - start time for the lecture generation
         p_length_minutes - length of the lecture in minutes
         p_repeats_monday - whether to repeat on Monday
         p_repeats_tuesday - whether to repeat on Tuesday
         p_repeats_wednesday - whether to repeat on Wednesday
         p_repeats_thursday - whether to repeat on Thursday
         p_repeats_friday - whether to repeat on Friday
   */
   procedure generate_lectures (
      p_from_date       in timestamp,
      p_to_date         in timestamp,
      p_subject_id      in number,
      p_classroom_id    in number,      -- ADDED
      p_start_time      in timestamp, -- keep as timestamp, but only H:M:S is used
      p_length_minutes  in number,
      repeats_monday    in boolean default false,
      repeats_tuesday   in boolean default false,
      repeats_wednesday in boolean default false,
      repeats_thursday  in boolean default false,
      repeats_friday    in boolean default false
   );

end pkg_lecture;
/

-- Package body
create or replace package body pkg_lecture as
   procedure generate_lectures (
      p_from_date       in timestamp,
      p_to_date         in timestamp,
      p_subject_id      in number,
      p_classroom_id    in number,      -- ADDED
      p_start_time      in timestamp,
      p_length_minutes  in number,
      repeats_monday    in boolean default false,
      repeats_tuesday   in boolean default false,
      repeats_wednesday in boolean default false,
      repeats_thursday  in boolean default false,
      repeats_friday    in boolean default false
   ) as
      v_date     timestamp;
      v_start_time timestamp;
      v_end_time timestamp;
      v_dow      number;
   begin
      v_date := p_from_date;
      while v_date <= p_to_date loop
         v_dow := to_number ( to_char(
            v_date,
            'D'
         ) );
         -- Oracle 'D' returns 1=Sunday, 2=Monday, ..., 7=Saturday (NLS_TERRITORY dependent)
         -- Adjust for Monday-Friday
         if (
            v_dow = 2
            and repeats_monday
         )
         or (
            v_dow = 3
            and repeats_tuesday
         )
         or (
            v_dow = 4
            and repeats_wednesday
         )
         or (
            v_dow = 5
            and repeats_thursday
         )
         or (
            v_dow = 6
            and repeats_friday
         ) then
            v_start_time := trunc(v_date) + (extract(hour from p_start_time)/24)
                                         + (extract(minute from p_start_time)/1440)
                                         + (extract(second from p_start_time)/86400);
            v_end_time := v_start_time + (p_length_minutes / 1440);
            insert into lecture (
               subject_id,
               classroom_id,      -- ADDED
               start_time,
               end_time,
               lecture_name
            ) values ( p_subject_id,
                       p_classroom_id, -- ADDED
                       v_start_time,
                       v_end_time,
                       'Lecture for subject '
                       || p_subject_id
                       || ' on '
                       || to_char(
                          v_start_time,
                          'YYYY-MM-DD HH24:MI'
                       ) );
         end if;
         v_date := v_date + 1;
      end loop;
      commit;
   exception
      when others then
         rollback;
         raise_application_error(
            -20235,
            'Error generating lectures: ' || sqlerrm
         );
   end generate_lectures;

   procedure add_lecture (
      p_subject_id   in number,
      p_classroom_id in number,
      p_start_time   in timestamp,
      p_end_time     in timestamp,
      p_lecture_name in varchar2,
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
      ) values ( p_subject_id,
                 p_classroom_id,
                 p_start_time,
                 p_end_time,
                 p_lecture_name,
                 p_description );
      dbms_output.put_line('Lecture added: Subject ID ' || p_subject_id);
      commit;
   exception
      when dup_val_on_index then
         rollback;
         raise_application_error(
            -20221,
            'Lecture with this subject, classroom, and start time already exists: Subject ID '
            || p_subject_id
            || ', Classroom ID '
            || p_classroom_id
            || ', Start Time '
            || to_char(
               p_start_time,
               'YYYY-MM-DD HH24:MI:SS'
            )
         );
      when value_error then
         rollback;
         raise_application_error(
            -20222,
            'Type or length error when adding lecture: Subject ID '
            || p_subject_id
            || ', Classroom ID '
            || p_classroom_id
         );
      when others then
         rollback;
         raise_application_error(
            -20223,
            'Unexpected error when adding lecture: Subject ID '
            || p_subject_id
            || ', Classroom ID '
            || p_classroom_id
            || '. Error: '
            || sqlerrm
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
         set subject_id = p_subject_id,
             classroom_id = p_classroom_id,
             start_time = p_start_time,
             end_time = p_end_time,
             lecture_name = p_lecture_name,
             description = p_description
       where lecture_id = p_lecture_id returning 1 into v_updated;
      dbms_output.put_line('Lecture updated: ID ' || p_lecture_id);
      commit;
   exception
      when dup_val_on_index then
         rollback;
         raise_application_error(
            -20224,
            'Lecture with this subject, classroom, and start time already exists: Subject ID '
            || p_subject_id
            || ', Classroom ID '
            || p_classroom_id
            || ', Start Time '
            || to_char(
               p_start_time,
               'YYYY-MM-DD HH24:MI:SS'
            )
         );
      when value_error then
         rollback;
         raise_application_error(
            -20225,
            'Type or length error when updating lecture: ID ' || p_lecture_id
         );
      when no_data_found then
         rollback;
         raise_application_error(
            -20226,
            'No lecture found with ID ' || p_lecture_id
         );
      when others then
         rollback;
         raise_application_error(
            -20227,
            'Unexpected error when updating lecture: ID '
            || p_lecture_id
            || '. Error: '
            || sqlerrm
         );
   end update_lecture;

   procedure delete_lecture (
      p_lecture_id in number
   ) as
      v_deleted number;
   begin
      delete from lecture
       where lecture_id = p_lecture_id returning 1 into v_deleted;
      dbms_output.put_line('Lecture deleted: ID ' || p_lecture_id);
      commit;
   exception
      when no_data_found then
         rollback;
         raise_application_error(
            -20228,
            'No lecture found with ID ' || p_lecture_id
         );
      when others then
         rollback;
         raise_application_error(
            -20229,
            'Unexpected error when deleting lecture: ID '
            || p_lecture_id
            || '. Error: '
            || sqlerrm
         );
   end delete_lecture;

   procedure delete_subject_lectures (
      p_subject_id in number
   ) as
      v_deleted number;
   begin
      delete from lecture
       where subject_id = p_subject_id;
      dbms_output.put_line('Deleted lectures for subject: ' || p_subject_id);
      commit;
   exception
      when others then
         rollback;
         raise_application_error(
            -20236,
            'Unexpected error when deleting lectures for subject: '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end delete_subject_lectures;

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
      when no_data_found then
         raise_application_error(
            -20230,
            'No lecture found with ID ' || p_lecture_id
         );
      when too_many_rows then
         raise_application_error(
            -20231,
            'Multiple lectures found with ID ' || p_lecture_id
         );
      when others then
         raise_application_error(
            -20232,
            'Unexpected error when reading lecture: ID '
            || p_lecture_id
            || '. Error: '
            || sqlerrm
         );
   end get_lecture_by_id;

   function get_lecture_by_subject_id (
      p_subject_id in number
   ) return number is
      v_lecture_id number;
   begin
      select lecture_id
        into v_lecture_id
        from lecture
       where subject_id = p_subject_id
         and rownum = 1;
      return v_lecture_id;
   exception
      when no_data_found then
         return null;
      when others then
         raise_application_error(
            -20234,
            'Error when getting lecture by subject_id: '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end get_lecture_by_subject_id;

   function get_lecture_id_by_natural_key (
      p_subject_id   in number,
      p_classroom_id in number,
      p_start_time   in timestamp
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
      when no_data_found then
         return null;
      when others then
         raise_application_error(
            -20233,
            'Error when getting lecture ID by natural key: subject_id='
            || p_subject_id
            || ', classroom_id='
            || p_classroom_id
            || ', start_time='
            || to_char(
               p_start_time,
               'YYYY-MM-DD HH24:MI:SS'
            )
            || '. Error: '
            || sqlerrm
         );
   end get_lecture_id_by_natural_key;


end pkg_lecture;
/
