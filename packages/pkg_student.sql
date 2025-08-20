/*
   File: pkg_student.sql
   Author: David Válek
   Created: 2025-08-15
   Modified: 2025-08-16 - Updated for new table structure with person_id FK
   Description: Package for CRUD operations on the Student table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
     - Student table now only contains student_id, person_id, and class_id.
*/

-- Package specification
create or replace package pkg_student as

    /*
       Adds a new student to the Student table and corresponding Person record.
       Parameters:
         p_first_name    - first name of the student
         p_last_name     - last name of the student
         p_email         - email of the student (must be unique)
         p_password_hash - password hash for the student
         p_salt          - salt for password hashing
         p_class_id      - class ID (nullable)
       Returns:
         student_id of the newly created student
    */
   function add_student (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2,
      p_class_id      in number
   ) return number;

    /*
       Updates an existing student's class assignment.
       Parameters:
         p_student_id - ID of the student to update
         p_class_id   - new class ID
    */
   procedure update_student_class (
      p_student_id in number,
      p_class_id   in number
   );

    /*
       Updates a student's personal information via Person table.
       Parameters:
         p_student_id    - ID of the student
         p_first_name    - new first name
         p_last_name     - new last name
         p_email         - new email
         p_password_hash - new password hash
         p_salt          - new salt
    */
   procedure update_student_person_info (
      p_student_id    in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   );

    /*
       Deletes a student from the Student table and corresponding Person record.
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
         person_id     number,
         first_name    varchar2(50),
         last_name     varchar2(50),
         email         varchar2(100),
         password_hash varchar2(256),
         salt          varchar2(32),
         class_id      number
   );

    /*
       Returns student details by ID (joined with Person data).
       Parameters:
         p_student_id - ID of the student
       Returns:
         student_rec with student details, or NULL if not found.
    */
   function get_student_by_id (
      p_student_id in number
   ) return student_rec;

    /*
       Returns the full name (first name + last name) of a student by ID.
       Parameters:
         p_student_id - ID of the student
       Returns:
         Full name as varchar2, or NULL if not found.
    */
    function get_student_full_name_by_id (
        p_student_id in number
    ) return varchar2;

end pkg_student;
/

-- Package body
create or replace package body pkg_student as

   function add_student (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2,
      p_class_id      in number
   ) return number as
      v_student_id number;
      v_person_id  number;
   begin
      -- First create the person record
      v_person_id := pkg_person.add_person(
         p_first_name => p_first_name,
         p_last_name => p_last_name,
         p_email => p_email,
         p_password_hash => p_password_hash,
         p_salt => p_salt
      );
      
      -- Then insert into student table with person_id
      insert into student (person_id, class_id)
      values (v_person_id, p_class_id)
      returning student_id into v_student_id;
      dbms_output.put_line('Student added: '
                           || p_first_name
                           || ' '
                           || p_last_name
                           || ' (Student ID: '
                           || v_student_id
                           || ', Person ID: '
                           || v_person_id
                           || ')');
      commit;
      return v_student_id;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20121,
            'Student already exists for Person ID ' || v_person_id
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20122,
            'Invalid value or data type for Student: ' || p_first_name || ' ' || p_last_name
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20123,
            'Other error when adding Student: ' || p_first_name || ' ' || p_last_name || '. Error: ' || SQLERRM
         );
   end add_student;

   procedure update_student_class (
      p_student_id in number,
      p_class_id   in number
   ) as
      v_updated number;
   begin
      update student
         set class_id = p_class_id
       where student_id = p_student_id
       returning 1 into v_updated;
      dbms_output.put_line('Student class updated: ID ' || p_student_id);
      commit;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20124,
            'Student with this class already exists: Student ID ' || p_student_id || ', Class ID ' || p_class_id
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20125,
            'Invalid value or data type for Student class update: Student ID ' || p_student_id || ', Class ID ' || p_class_id
         );
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20126,
            'No student found with ID ' || p_student_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20127,
            'Other error when updating Student class: Student ID ' || p_student_id || '. Error: ' || SQLERRM
         );
   end update_student_class;

   procedure update_student_person_info (
      p_student_id    in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) as
      v_person_id number;
   begin
      -- Get the person_id for this student
      select person_id into v_person_id
        from student
       where student_id = p_student_id;
      
      -- Update the person record
      pkg_person.update_person(
         p_person_id => v_person_id,
         p_first_name => p_first_name,
         p_last_name => p_last_name,
         p_email => p_email,
         p_password_hash => p_password_hash,
         p_salt => p_salt
      );
      
      dbms_output.put_line('Student person info updated: ID ' || p_student_id);
      commit;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20128,
            'Student with this email already exists: ' || p_email
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20129,
            'Invalid value or data type for Student update: ' || p_first_name || ' ' || p_last_name
         );
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20130,
            'No student found with ID ' || p_student_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20131,
            'Other error when updating Student: ID ' || p_student_id || '. Error: ' || SQLERRM
         );
   end update_student_person_info;

   procedure delete_student (
      p_student_id in number
   ) as
      v_person_id number;
      v_deleted number;
   begin
      -- Get the person_id for this student
      select person_id into v_person_id
        from student
       where student_id = p_student_id;
      
      -- Delete from student table first
      delete from student
       where student_id = p_student_id
       returning 1 into v_deleted;
       
      -- Then delete from person table
      pkg_person.delete_person(v_person_id);
      dbms_output.put_line('Student deleted: ID ' || p_student_id);
      commit;
   exception
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20132,
            'No student found with ID ' || p_student_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20133,
            'Other error when deleting Student: ID ' || p_student_id || '. Error: ' || SQLERRM
         );
   end delete_student;

   function get_student_by_id (
      p_student_id in number
   ) return student_rec as
      v_student student_rec;
   begin
      select s.student_id,
             s.person_id,
             p.first_name,
             p.last_name,
             p.email,
             p.password_hash,
             p.salt,
             s.class_id
        into v_student
        from student s
        join person p on s.person_id = p.person_id
       where s.student_id = p_student_id;

      return v_student;
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20134,
            'No student found with ID ' || p_student_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20135,
            'Multiple students found with ID ' || p_student_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20136,
            'Other error when reading Student: ID ' || p_student_id || '. Error: ' || SQLERRM
         );
   end get_student_by_id;

   function get_student_full_name_by_id (
      p_student_id in number
   ) return varchar2
   as
      v_full_name varchar2(101);
   begin
      select p.first_name || ' ' || p.last_name
        into v_full_name
        from student s
        join person p on s.person_id = p.person_id
       where s.student_id = p_student_id;
      return v_full_name;
   exception
      when NO_DATA_FOUND then
         return null;
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20137,
            'Multiple students found with ID ' || p_student_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20138,
            'Other error when reading student full name: ID ' || p_student_id || '. Error: ' || SQLERRM
         );
   end get_student_full_name_by_id;

end pkg_student;
/