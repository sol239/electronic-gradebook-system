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
      p_subject_id in number,
      p_subject_name       in varchar2
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
         subject_id number,
         subject_name       varchar2(100)
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
   

end pkg_subject;
/

-- Package body
create or replace package body pkg_subject as

   procedure add_subject (
      p_subject_name in varchar2
   ) as
      v_exists number;
   begin
      select count(*) into v_exists
        from subject
       where UPPER(TRIM(subject_name)) = UPPER(TRIM(p_subject_name));
      if v_exists > 0 then
         RAISE_APPLICATION_ERROR(
            -20081,
            'Subject with this name already exists: ' || p_subject_name
         );
      end if;

      insert into subject (subject_name) values (p_subject_name);
      dbms_output.put_line('Subject added: ' || p_subject_name);
      commit;
   exception
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20082,
            'Invalid value or data type for Subject: ' || p_subject_name
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20083,
            'Other error when adding Subject: ' || p_subject_name || '. Error: ' || SQLERRM
         );
   end add_subject;

   procedure update_subject (
      p_subject_id in number,
      p_subject_name in varchar2
   ) as
      v_updated number;
   begin
      update subject
         set
         subject_name = p_subject_name
       where subject_id = p_subject_id
       returning 1 into v_updated;
      dbms_output.put_line('Subject updated: ID ' || p_subject_id);
      commit;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20084,
            'Subject with this name already exists: ' || p_subject_name
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20085,
            'Invalid value or data type for Subject update: ' || p_subject_name
         );
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20086,
            'No subject found with ID ' || p_subject_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20087,
            'Other error when updating Subject: ID ' || p_subject_id || '. Error: ' || SQLERRM
         );
   end update_subject;

   procedure delete_subject (
      p_subject_id in number
   ) as
      v_deleted number;
   begin
      delete from subject
       where subject_id = p_subject_id
       returning 1 into v_deleted;
      dbms_output.put_line('Subject deleted: ID ' || p_subject_id);
      commit;
   exception
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20088,
            'No subject found with ID ' || p_subject_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20089,
            'Other error when deleting Subject: ID ' || p_subject_id || '. Error: ' || SQLERRM
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
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20090,
            'No subject found with ID ' || p_subject_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20091,
            'Multiple subjects found with ID ' || p_subject_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20092,
            'Other error when reading Subject: ID ' || p_subject_id || '. Error: ' || SQLERRM
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
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20093,
            'No grades found for student ' || p_student_id || ' in subject ' || p_subject_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20094,
            'Multiple average grades found for student ' || p_student_id || ' in subject ' || p_subject_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20095,
            'Other error when reading student average grade: student ' || p_student_id || ', subject ' || p_subject_id || '. Error: ' || SQLERRM
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
           order by freq desc, grade
        )
       where rownum = 1;

      return v_most_common;
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20096,
            'No grades found for student ' || p_student_id || ' in subject ' || p_subject_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20097,
            'Multiple most common grades found for student ' || p_student_id || ' in subject ' || p_subject_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20098,
            'Other error when reading student most common grade: student ' || p_student_id || ', subject ' || p_subject_id || '. Error: ' || SQLERRM
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
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20099,
            'No grades found for student ' || p_student_id || ' in subject ' || p_subject_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20100,
            'Multiple median grades found for student ' || p_student_id || ' in subject ' || p_subject_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20101,
            'Other error when reading student median grade: student ' || p_student_id || ', subject ' || p_subject_id || '. Error: ' || SQLERRM
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
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20102,
            'No grades found for subject ' || p_subject_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20103,
            'Multiple average grades found for subject ' || p_subject_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20104,
            'Other error when reading subject average grade: subject ' || p_subject_id || '. Error: ' || SQLERRM
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
           order by freq desc, grade
        )
       where rownum = 1;

      return v_most_common;
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20105,
            'No grades found for subject ' || p_subject_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20106,
            'Multiple most common grades found for subject ' || p_subject_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20107,
            'Other error when reading subject most common grade: subject ' || p_subject_id || '. Error: ' || SQLERRM
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
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20108,
            'No grades found for subject ' || p_subject_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20109,
            'Multiple median grades found for subject ' || p_subject_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20110,
            'Other error when reading subject median grade: subject ' || p_subject_id || '. Error: ' || SQLERRM
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
       where UPPER(TRIM(subject_name)) = UPPER(TRIM(p_subject_name));
      return v_subject_id;
   exception
      when NO_DATA_FOUND then
         return null;
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20111,
            'Multiple subjects found with name: ' || p_subject_name
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20112,
            'Other error when reading subject ID by name: ' || p_subject_name || '. Error: ' || SQLERRM
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
      when NO_DATA_FOUND then
         return null;
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20113,
            'Multiple subjects found with ID: ' || p_subject_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20114,
            'Other error when reading subject name by ID: ' || p_subject_id || '. Error: ' || SQLERRM
         );
   end get_subject_name_by_id;

end pkg_subject;
/