/*
   File: pkg_student.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Student table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
*/

-- Package specification
create or replace package pkg_student as

    /*
       Adds a new student to the Student table.
       Parameters:
         p_first_name   - first name of the student
         p_last_name    - last name of the student
         p_date_of_birth- date of birth of the student
         p_email        - email of the student (must be unique)
         p_class_id     - class ID (nullable)
    */
   procedure add_student (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_date_of_birth in date,
      p_email         in varchar2,
      p_class_id      in number
   );

    /*
       Updates an existing student in the Student table.
       Parameters:
         p_student_id    - ID of the student to update
         p_first_name    - new first name
         p_last_name     - new last name
         p_date_of_birth - new date of birth
         p_email         - new email
         p_class_id      - new class ID
    */
   procedure update_student (
      p_student_id    in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_date_of_birth in date,
      p_email         in varchar2,
      p_class_id      in number
   );

    /*
       Deletes a student from the Student table.
       Parameters:
         p_student_id - ID of the student to delete
    */
   procedure delete_student (
      p_student_id in number
   );

    /*
       Type for return value of get_student_by_id function.
    */
   type student_rec is record (
         student_id    number,
         first_name    varchar2(50),
         last_name     varchar2(50),
         date_of_birth date,
         email         varchar2(100),
         class_id      number
   );

    /*
       Returns student details by ID.
       Parameters:
         p_student_id - ID of the student
       Returns:
         student_rec with student details, or NULL if not found.
    */
   function get_student_by_id (
      p_student_id in number
   ) return student_rec;

end pkg_student;
/

-- Package body
create or replace package body pkg_student as

   procedure add_student (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_date_of_birth in date,
      p_email         in varchar2,
      p_class_id      in number
   ) as
   begin
      insert into student (
         first_name,
         last_name,
         date_of_birth,
         email,
         class_id
      ) values ( p_first_name,
                 p_last_name,
                 p_date_of_birth,
                 p_email,
                 p_class_id );
      dbms_output.put_line('Student added: '
                           || p_first_name
                           || ' '
                           || p_last_name);
   end add_student;

   procedure update_student (
      p_student_id    in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_date_of_birth in date,
      p_email         in varchar2,
      p_class_id      in number
   ) as
   begin
      update student
         set first_name = p_first_name,
             last_name = p_last_name,
             date_of_birth = p_date_of_birth,
             email = p_email,
             class_id = p_class_id
       where student_id = p_student_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No student found with ID ' || p_student_id);
      else
         dbms_output.put_line('Student updated: ID ' || p_student_id);
      end if;
   end update_student;

   procedure delete_student (
      p_student_id in number
   ) as
   begin
      delete from student
       where student_id = p_student_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No student found with ID ' || p_student_id);
      else
         dbms_output.put_line('Student deleted: ID ' || p_student_id);
      end if;
   end delete_student;

   function get_student_by_id (
      p_student_id in number
   ) return student_rec as
      v_student student_rec;
   begin
      select student_id,
             first_name,
             last_name,
             date_of_birth,
             email,
             class_id
        into v_student
        from student
       where student_id = p_student_id;

      return v_student;
   exception
      when no_data_found then
         return null;
   end get_student_by_id;

end pkg_student;
/