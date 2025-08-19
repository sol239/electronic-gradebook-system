/*
   File: pkg_teacher.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Teacher table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
     - Teacher table now only contains teacher_id and person_id.
*/

-- Package specification
create or replace package pkg_teacher as

    /*
       Adds a new teacher to the Teacher table and corresponding Person record.
       Parameters:
         p_first_name    - first name of the teacher
         p_last_name     - last name of the teacher
         p_email         - email of the teacher (must be unique)
         p_password_hash - password hash for the teacher
         p_salt          - salt for password hashing
       Returns:
         teacher_id of the newly created teacher
    */
   function add_teacher (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) return number;

    /*
       Updates a teacher's personal information via Person table.
       Parameters:
         p_teacher_id    - ID of the teacher
         p_first_name    - new first name
         p_last_name     - new last name
         p_email         - new email
         p_password_hash - new password hash
         p_salt          - new salt
    */
   procedure update_teacher_person_info (
      p_teacher_id    in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   );

    /*
       Deletes a teacher from the Teacher table and corresponding Person record.
       Parameters:
         p_teacher_id - ID of the teacher to delete
    */
   procedure delete_teacher (
      p_teacher_id in number
   );

    /*
       Type for return value of get_teacher_by_id function.
    */
   type teacher_rec is record (
         teacher_id    number,
         person_id     number,
         first_name    varchar2(50),
         last_name     varchar2(50),
         email         varchar2(100),
         password_hash varchar2(256),
         salt          varchar2(32)
   );

    /*
       Returns teacher details by ID (joined with Person data).
       Parameters:
         p_teacher_id - ID of the teacher
       Returns:
         teacher_rec with teacher details, or NULL if not found.
    */
   function get_teacher_by_id (
      p_teacher_id in number
   ) return teacher_rec;

end pkg_teacher;
/

-- Package body
create or replace package body pkg_teacher as

   function add_teacher (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) return number as
      v_teacher_id number;
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
      
      -- Then insert into teacher table with person_id
      insert into teacher (person_id)
      values (v_person_id)
      returning teacher_id into v_teacher_id;
      dbms_output.put_line('Teacher added: '
                           || p_first_name
                           || ' '
                           || p_last_name
                           || ' (Teacher ID: '
                           || v_teacher_id
                           || ', Person ID: '
                           || v_person_id
                           || ')');
      commit;
      return v_teacher_id;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20111,
            'Teacher already exists for Person ID ' || v_person_id
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20112,
            'Invalid value or data type for Teacher: ' || p_first_name || ' ' || p_last_name
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20113,
            'Other error when adding Teacher: ' || p_first_name || ' ' || p_last_name || '. Error: ' || SQLERRM
         );
   end add_teacher;

   procedure update_teacher_person_info (
      p_teacher_id    in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) as
      v_person_id number;
   begin
      -- Get the person_id for this teacher
      select person_id into v_person_id
        from teacher
       where teacher_id = p_teacher_id;
      
      -- Update the person record
      pkg_person.update_person(
         p_person_id => v_person_id,
         p_first_name => p_first_name,
         p_last_name => p_last_name,
         p_email => p_email,
         p_password_hash => p_password_hash,
         p_salt => p_salt
      );
      
      dbms_output.put_line('Teacher person info updated: ID ' || p_teacher_id);
      commit;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20114,
            'Update would create duplicate teacher for email: ' || p_email
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20115,
            'Invalid value or data type for Teacher update: ' || p_first_name || ' ' || p_last_name
         );
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20116,
            'No teacher found with ID ' || p_teacher_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20117,
            'Other error when updating Teacher: ID ' || p_teacher_id || '. Error: ' || SQLERRM
         );
   end update_teacher_person_info;

   procedure delete_teacher (
      p_teacher_id in number
   ) as
      v_person_id number;
      v_deleted number;
   begin
      -- Get the person_id for this teacher
      select person_id into v_person_id
        from teacher
       where teacher_id = p_teacher_id;
      
      -- Delete from teacher table first
      delete from teacher
       where teacher_id = p_teacher_id
       returning 1 into v_deleted;
       
      -- Then delete from person table
      pkg_person.delete_person(v_person_id);
      dbms_output.put_line('Teacher deleted: ID ' || p_teacher_id);
      commit;
   exception
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20118,
            'No teacher found with ID ' || p_teacher_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20119,
            'Other error when deleting Teacher: ID ' || p_teacher_id || '. Error: ' || SQLERRM
         );
   end delete_teacher;

   function get_teacher_by_id (
      p_teacher_id in number
   ) return teacher_rec as
      v_teacher teacher_rec;
   begin
      select t.teacher_id,
             t.person_id,
             p.first_name,
             p.last_name,
             p.email,
             p.password_hash,
             p.salt
        into v_teacher
        from teacher t
        join person p on t.person_id = p.person_id
       where t.teacher_id = p_teacher_id;

      return v_teacher;
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20120,
            'No teacher found with ID ' || p_teacher_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20121,
            'Multiple teachers found with ID ' || p_teacher_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20122,
            'Other error when reading Teacher: ID ' || p_teacher_id || '. Error: ' || SQLERRM
         );
   end get_teacher_by_id;

end pkg_teacher;
/