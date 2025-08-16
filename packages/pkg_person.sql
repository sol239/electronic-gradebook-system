/*
   File: pkg_person.sql
   Author: David Válek
   Created: 2025-08-16
   Description: Package for CRUD operations on the Person table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
     - Simplified structure without role fields.
*/

-- Package specification
create or replace package pkg_person as

    /*
       Adds a new person to the Person table.
       Parameters:
         p_first_name    - first name of the person
         p_last_name     - last name of the person
         p_email         - email of the person (must be unique)
         p_password_hash - password hash for the person
         p_salt          - salt for password hashing
       Returns:
         person_id of the newly created person
    */
   function add_person (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) return number;

    /*
       Updates an existing person in the Person table.
       Parameters:
         p_person_id     - ID of the person to update
         p_first_name    - new first name
         p_last_name     - new last name
         p_email         - new email
         p_password_hash - new password hash
         p_salt          - new salt
    */
   procedure update_person (
      p_person_id     in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   );

   

    /*
       Deletes a person from the Person table.
       Parameters:
         p_person_id - ID of the person to delete
    */
   procedure delete_person (
      p_person_id in number
   );

    /*
       Type for return value of get_person_by_id function.
    */
   type person_rec is record (
         person_id     number,
         first_name    varchar2(50),
         last_name     varchar2(50),
         email         varchar2(100),
         password_hash varchar2(256),
         salt          varchar2(32)
   );

    /*
       Returns person details by ID.
       Parameters:
         p_person_id - ID of the person
       Returns:
         person_rec with person details, or NULL if not found.
    */
   function get_person_by_id (
      p_person_id in number
   ) return person_rec;

end pkg_person;
/

-- Package body
create or replace package body pkg_person as

   function add_person (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) return number as
      v_person_id number;
   begin
      insert into person (
         first_name,
         last_name,
         email,
         password_hash,
         salt
      ) values ( p_first_name,
                 p_last_name,
                 p_email,
                 p_password_hash,
                 p_salt )
      returning person_id into v_person_id;
      
      dbms_output.put_line('Person added: '
                           || p_first_name
                           || ' '
                           || p_last_name
                           || ' (ID: '
                           || v_person_id
                           || ')');
      return v_person_id;
   end add_person;

   procedure update_person (
      p_person_id     in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) as
   begin
      update person
         set first_name = p_first_name,
             last_name = p_last_name,
             email = p_email,
             password_hash = p_password_hash,
             salt = p_salt
       where person_id = p_person_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No person found with ID ' || p_person_id);
      else
         dbms_output.put_line('Person updated: ID ' || p_person_id);
      end if;
   end update_person;

   procedure delete_person (
      p_person_id in number
   ) as
   begin
      delete from person
       where person_id = p_person_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No person found with ID ' || p_person_id);
      else
         dbms_output.put_line('Person deleted: ID ' || p_person_id);
      end if;
   end delete_person;

   function get_person_by_id (
      p_person_id in number
   ) return person_rec as
      v_person person_rec;
   begin
      select person_id,
             first_name,
             last_name,
             email,
             password_hash,
             salt
        into v_person
        from person
       where person_id = p_person_id;

      return v_person;
   exception
      when no_data_found then
         return null;
   end get_person_by_id;

end pkg_person;
/
