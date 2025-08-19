/*
   File: pkg_subject.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Subject table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
*/

-- Package specification
create or replace package pkg_subject as

    /*
       Adds a new subject to the Subject table.
       Parameters:
         p_name - name of the subject
    */
   procedure add_subject (
      p_name in varchar2
   );

    /*
       Updates an existing subject in the Subject table.
       Parameters:
         p_subject_id - ID of the subject to update
         p_name       - new name of the subject
    */
   procedure update_subject (
      p_subject_id in number,
      p_name       in varchar2
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
         name       varchar2(100)
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

end pkg_subject;
/

-- Package body
create or replace package body pkg_subject as

   procedure add_subject (
      p_name in varchar2
   ) as
   begin
      insert into subject ( name ) values ( p_name );
      dbms_output.put_line('Subject added: ' || p_name);
   end add_subject;

   procedure update_subject (
      p_subject_id in number,
      p_name       in varchar2
   ) as
   begin
      update subject
         set
         name = p_name
       where subject_id = p_subject_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No subject found with ID ' || p_subject_id);
      else
         dbms_output.put_line('Subject updated: ID ' || p_subject_id);
      end if;
   end update_subject;

   procedure delete_subject (
      p_subject_id in number
   ) as
   begin
      delete from subject
       where subject_id = p_subject_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No subject found with ID ' || p_subject_id);
      else
         dbms_output.put_line('Subject deleted: ID ' || p_subject_id);
      end if;
   end delete_subject;

   function get_subject_by_id (
      p_subject_id in number
   ) return subject_rec as
      v_subject subject_rec;
   begin
      select subject_id,
             name
        into v_subject
        from subject
       where subject_id = p_subject_id;

      return v_subject;
   exception
      when no_data_found then
         return null;
   end get_subject_by_id;

   function get_student_average_grade (
      p_student_id in number,
      p_subject_id in number
   ) return number as
      v_average number;
   begin
   -- Compute average
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
         dbms_output.put_line('No grades found for student '
                              || p_student_id
                              || ' in subject '
                              || p_subject_id);
         return null;
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
      when no_data_found then
         dbms_output.put_line('No grades found for student '
                              || p_student_id
                              || ' in subject '
                              || p_subject_id);
         return null;
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
         dbms_output.put_line('No grades found for student '
                              || p_student_id
                              || ' in subject '
                              || p_subject_id);
         return null;
   end get_student_median_grade;

end pkg_subject;


/