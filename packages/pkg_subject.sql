/*
   File: pkg_subject.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Subject table.
*/

-- Package specification
create or replace package pkg_subject as

    /*
       Adds a new subject to the Subject table.
       Parameters:
         p_name - name of the subject
    */
   procedure add_subject (
      p_subject_name in varchar2
   );

    /*
       Updates an existing subject in the Subject table.
       Parameters:
         p_subject_id - ID of the subject to update
         p_name       - new name of the subject
    */
   procedure update_subject (
      p_subject_id   in number,
      p_subject_name in varchar2
   );

    /*
       Deletes a subject from the Subject table.
       Parameters:
         p_subject_id - ID of the subject to delete
    */
   procedure delete_subject (
      p_subject_id in number
   );

    /*
       Type for return value of get_subject_by_id function.
    */
   type subject_rec is record (
         subject_id   number,
         subject_name varchar2(100)
   );

    /*
       Returns subject details by ID.
       Parameters:
         p_subject_id - ID of the subject
       Returns:
         subject_rec with subject details, or NULL if not found.
    */
   function get_subject_by_id (
      p_subject_id in number
   ) return subject_rec;

   /*
       Returns the average grade of a student in a specific subject.
       Parameters:
         p_student_id  - ID of the student
         p_subject_id  - ID of the subject
       Returns:
         Average grade as a number, or NULL if not found.
   */
   function get_student_average_grade (
      p_student_id in number,
      p_subject_id in number
   ) return number;

   /*
      Returns the most common grade of a student in a specific subject.
      Parameters:
         p_student_id  - ID of the student
         p_subject_id  - ID of the subject
      Returns:
         Most common grade as a number, or NULL if not found.
   */
   function get_student_most_common_grade (
      p_student_id in number,
      p_subject_id in number
   ) return number;
   
   /*
      Returns the median grade of a student in a specific subject.
      Parameters:
         p_student_id  - ID of the student
         p_subject_id  - ID of the subject
      Returns:
         Median grade as a number, or NULL if not found.
   */
   function get_student_median_grade (
      p_student_id in number,
      p_subject_id in number
   ) return number;

   /*
      Returns the average grade for a given subject.
      Parameters:
         p_subject_id  - ID of the subject
      Returns:
         Average grade as a number, or NULL if not found.
   */
   function get_subject_average_grade (
      p_subject_id in number
   ) return number;

   /*
      Returns the most common grade for a given subject.
      Parameters:
         p_subject_id  - ID of the subject
      Returns:
         Most common grade as a number, or NULL if not found.
   */
   function get_subject_most_common_grade (
      p_subject_id in number
   ) return number;

   /*
      Returns the median grade for a given subject.
      Parameters:
         p_subject_id  - ID of the subject
      Returns:
         Median grade as a number, or NULL if not found.
   */
   function get_subject_median_grade (
      p_subject_id in number
   ) return number;

   /*
      Returns the subject_id for a given subject name.
      Parameters:
         p_name - name of the subject
      Returns:
         subject_id as a number, or NULL if not found.
   */
   function get_subject_id_by_name (
      p_subject_name in varchar2
   ) return number;

   /*
      Returns the subject name for a given subject ID.
      Parameters:
         p_subject_id - ID of the subject
      Returns:
         name as varchar2, or NULL if not found.
   */
   function get_subject_name_by_id (
      p_subject_id in number
   ) return varchar2;

   /*
      Returns the attendance rate of a student for a specific subject.
      Parameters:
         p_student_id - ID of the student
         p_subject_id - ID of the subject
      Returns:
         Attendance rate as a number (0-1), or NULL if no lectures found.
   */
   function attendance_rate (
      p_student_id in number,
      p_subject_id in number
   ) return number;


end pkg_subject;
/

-- Package body
create or replace package body pkg_subject as

   procedure add_subject (
      p_subject_name in varchar2
   ) as
      v_exists number;
   begin
      select count(*)
        into v_exists
        from subject
       where upper(trim(subject_name)) = upper(trim(p_subject_name));
      if v_exists > 0 then
         raise_application_error(
            -20081,
            'Subject with this name already exists: ' || p_subject_name
         );
      end if;

      insert into subject ( subject_name ) values ( p_subject_name );
      dbms_output.put_line('Subject added: ' || p_subject_name);
      commit;
   exception
      when value_error then
         rollback;
         raise_application_error(
            -20082,
            'Invalid value or data type for Subject: ' || p_subject_name
         );
      when others then
         rollback;
         raise_application_error(
            -20083,
            'Other error when adding Subject: '
            || p_subject_name
            || '. Error: '
            || sqlerrm
         );
   end add_subject;

   procedure update_subject (
      p_subject_id   in number,
      p_subject_name in varchar2
   ) as
      v_updated number;
   begin
      update subject
         set
         subject_name = p_subject_name
       where subject_id = p_subject_id returning 1 into v_updated;
      dbms_output.put_line('Subject updated: ID ' || p_subject_id);
      commit;
   exception
      when dup_val_on_index then
         rollback;
         raise_application_error(
            -20084,
            'Subject with this name already exists: ' || p_subject_name
         );
      when value_error then
         rollback;
         raise_application_error(
            -20085,
            'Invalid value or data type for Subject update: ' || p_subject_name
         );
      when no_data_found then
         rollback;
         raise_application_error(
            -20086,
            'No subject found with ID ' || p_subject_id
         );
      when others then
         rollback;
         raise_application_error(
            -20087,
            'Other error when updating Subject: ID '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end update_subject;

   procedure delete_subject (
      p_subject_id in number
   ) as
      v_deleted number;
   begin
      delete from subject
       where subject_id = p_subject_id returning 1 into v_deleted;
      dbms_output.put_line('Subject deleted: ID ' || p_subject_id);
      commit;
   exception
      when no_data_found then
         rollback;
         raise_application_error(
            -20088,
            'No subject found with ID ' || p_subject_id
         );
      when others then
         rollback;
         raise_application_error(
            -20089,
            'Other error when deleting Subject: ID '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end delete_subject;

   function get_subject_by_id (
      p_subject_id in number
   ) return subject_rec as
      v_subject subject_rec;
   begin
      select subject_id,
             subject_name
        into v_subject
        from subject
       where subject_id = p_subject_id;

      return v_subject;
   exception
      when no_data_found then
         raise_application_error(
            -20090,
            'No subject found with ID ' || p_subject_id
         );
      when too_many_rows then
         raise_application_error(
            -20091,
            'Multiple subjects found with ID ' || p_subject_id
         );
      when others then
         raise_application_error(
            -20092,
            'Other error when reading Subject: ID '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end get_subject_by_id;

   function get_student_average_grade (
      p_student_id in number,
      p_subject_id in number
   ) return number as
      v_average number;
   begin
      select avg(grade)
        into v_average
        from grade_group_student
        join grade_group gg
      on gg.grade_group_id = grade_group_student.grade_group_id
       where student_id = p_student_id
         and gg.subject_id = p_subject_id;

      return v_average;
   exception
      when no_data_found then
         raise_application_error(
            -20093,
            'No grades found for student '
            || p_student_id
            || ' in subject '
            || p_subject_id
         );
      when too_many_rows then
         raise_application_error(
            -20094,
            'Multiple average grades found for student '
            || p_student_id
            || ' in subject '
            || p_subject_id
         );
      when others then
         raise_application_error(
            -20095,
            'Other error when reading student average grade: student '
            || p_student_id
            || ', subject '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end get_student_average_grade;

   function get_student_most_common_grade (
      p_student_id in number,
      p_subject_id in number
   ) return number as
      v_most_common number;
   begin
      select grade
        into v_most_common
        from (
         select grade,
                count(*) as freq
           from grade_group_student
           join grade_group gg
         on gg.grade_group_id = grade_group_student.grade_group_id
          where student_id = p_student_id
            and gg.subject_id = p_subject_id
          group by grade
          order by freq desc,
                   grade
      )
       where rownum = 1;

      return v_most_common;
   exception
      when no_data_found then
         raise_application_error(
            -20096,
            'No grades found for student '
            || p_student_id
            || ' in subject '
            || p_subject_id
         );
      when too_many_rows then
         raise_application_error(
            -20097,
            'Multiple most common grades found for student '
            || p_student_id
            || ' in subject '
            || p_subject_id
         );
      when others then
         raise_application_error(
            -20098,
            'Other error when reading student most common grade: student '
            || p_student_id
            || ', subject '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end get_student_most_common_grade;

   function get_student_median_grade (
      p_student_id in number,
      p_subject_id in number
   ) return number as
      v_median number;
   begin
      select median(grade)
        into v_median
        from grade_group_student
        join grade_group gg
      on gg.grade_group_id = grade_group_student.grade_group_id
       where student_id = p_student_id
         and gg.subject_id = p_subject_id;

      return v_median;
   exception
      when no_data_found then
         raise_application_error(
            -20099,
            'No grades found for student '
            || p_student_id
            || ' in subject '
            || p_subject_id
         );
      when too_many_rows then
         raise_application_error(
            -20100,
            'Multiple median grades found for student '
            || p_student_id
            || ' in subject '
            || p_subject_id
         );
      when others then
         raise_application_error(
            -20101,
            'Other error when reading student median grade: student '
            || p_student_id
            || ', subject '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end get_student_median_grade;

   function get_subject_average_grade (
      p_subject_id in number
   ) return number as
      v_average number;
   begin
      select avg(grade)
        into v_average
        from grade_group_student
        join grade_group gg
      on gg.grade_group_id = grade_group_student.grade_group_id
       where gg.subject_id = p_subject_id;

      return v_average;
   exception
      when no_data_found then
         raise_application_error(
            -20102,
            'No grades found for subject ' || p_subject_id
         );
      when too_many_rows then
         raise_application_error(
            -20103,
            'Multiple average grades found for subject ' || p_subject_id
         );
      when others then
         raise_application_error(
            -20104,
            'Other error when reading subject average grade: subject '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end get_subject_average_grade;

   function get_subject_most_common_grade (
      p_subject_id in number
   ) return number as
      v_most_common number;
   begin
      select grade
        into v_most_common
        from (
         select grade,
                count(*) as freq
           from grade_group_student
           join grade_group gg
         on gg.grade_group_id = grade_group_student.grade_group_id
          where gg.subject_id = p_subject_id
          group by grade
          order by freq desc,
                   grade
      )
       where rownum = 1;

      return v_most_common;
   exception
      when no_data_found then
         raise_application_error(
            -20105,
            'No grades found for subject ' || p_subject_id
         );
      when too_many_rows then
         raise_application_error(
            -20106,
            'Multiple most common grades found for subject ' || p_subject_id
         );
      when others then
         raise_application_error(
            -20107,
            'Other error when reading subject most common grade: subject '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end get_subject_most_common_grade;

   function get_subject_median_grade (
      p_subject_id in number
   ) return number as
      v_median number;
   begin
      select median(grade)
        into v_median
        from grade_group_student
        join grade_group gg
      on gg.grade_group_id = grade_group_student.grade_group_id
       where gg.subject_id = p_subject_id;

      return v_median;
   exception
      when no_data_found then
         raise_application_error(
            -20108,
            'No grades found for subject ' || p_subject_id
         );
      when too_many_rows then
         raise_application_error(
            -20109,
            'Multiple median grades found for subject ' || p_subject_id
         );
      when others then
         raise_application_error(
            -20110,
            'Other error when reading subject median grade: subject '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end get_subject_median_grade;

   function get_subject_id_by_name (
      p_subject_name in varchar2
   ) return number as
      v_subject_id number;
   begin
      select subject_id
        into v_subject_id
        from subject
       where upper(trim(subject_name)) = upper(trim(p_subject_name));
      return v_subject_id;
   exception
      when no_data_found then
         return null;
      when too_many_rows then
         raise_application_error(
            -20111,
            'Multiple subjects found with name: ' || p_subject_name
         );
      when others then
         raise_application_error(
            -20112,
            'Other error when reading subject ID by name: '
            || p_subject_name
            || '. Error: '
            || sqlerrm
         );
   end get_subject_id_by_name;

   function get_subject_name_by_id (
      p_subject_id in number
   ) return varchar2 as
      v_subject_name varchar2(100);
   begin
      select subject_name
        into v_subject_name
        from subject
       where subject_id = p_subject_id;
      return v_subject_name;
   exception
      when no_data_found then
         return null;
      when too_many_rows then
         raise_application_error(
            -20113,
            'Multiple subjects found with ID: ' || p_subject_id
         );
      when others then
         raise_application_error(
            -20114,
            'Other error when reading subject name by ID: '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end get_subject_name_by_id;

   function attendance_rate (
      p_student_id in number,
      p_subject_id in number
   ) return number as
      v_total_lectures    number;
      v_attended_lectures number;
      v_rate              number;
   begin
      -- Count total lectures for the subject
      select count(*)
        into v_total_lectures
        from lecture
       where subject_id = p_subject_id;

      if v_total_lectures = 0 then
         return null;
      end if;

      -- Count lectures attended by the student for the subject
      select count(*)
        into v_attended_lectures
        from lecture_student ls
        join lecture l
      on l.lecture_id = ls.lecture_id
       where ls.student_id = p_student_id
         and l.subject_id = p_subject_id;

      v_rate := v_attended_lectures / v_total_lectures;
      return v_rate;
   exception
      when no_data_found then
         return null;
      when others then
         raise_application_error(
            -20115,
            'Error calculating attendance rate: student '
            || p_student_id
            || ', subject '
            || p_subject_id
            || '. Error: '
            || sqlerrm
         );
   end attendance_rate;

end pkg_subject;
/