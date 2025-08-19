/*
   File: pkg_parent.sql
   Author: David Válek
   Created: 2025-08-15
   Modified: 2025-08-16 - Updated for new table structure with person_id FK
   Description: Package for CRUD operations on the Parent table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
     - Parent table now only contains parent_id and person_id.
*/

-- Package specification
create or replace package pkg_parent as

    /*
       Adds a new parent to the Parent table and corresponding Person record.
       Parameters:
         p_first_name    - first name of the parent
         p_last_name     - last name of the parent
         p_email         - email of the parent (must be unique)
         p_password_hash - password hash for the parent
         p_salt          - salt for password hashing
       Returns:
         parent_id of the newly created parent
    */
   function add_parent (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) return number;

    /*
       Updates a parent's personal information via Person table.
       Parameters:
         p_parent_id     - ID of the parent
         p_first_name    - new first name
         p_last_name     - new last name
         p_email         - new email
         p_password_hash - new password hash
         p_salt          - new salt
    */
   procedure update_parent_person_info (
      p_parent_id     in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   );

    /*
       Deletes a parent from the Parent table and corresponding Person record.
       Parameters:
         p_parent_id - ID of the parent to delete
    */
   procedure delete_parent (
      p_parent_id in number
   );

    /*
       Type for return value of get_parent_by_id function.
    */
   type parent_rec is record (
         parent_id     number,
         person_id     number,
         first_name    varchar2(50),
         last_name     varchar2(50),
         email         varchar2(100),
         password_hash varchar2(256),
         salt          varchar2(32)
   );

    /*
       Returns parent details by ID (joined with Person data).
       Parameters:
         p_parent_id - ID of the parent
       Returns:
         parent_rec with parent details, or NULL if not found.
    */
   function get_parent_by_id (
      p_parent_id in number
   ) return parent_rec;

end pkg_parent;
/

-- Package body
create or replace package body pkg_parent as

   function add_parent (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) return number as
      v_parent_id number;
      v_person_id number;
   begin
      -- First create the person record
      v_person_id := pkg_person.add_person(
         p_first_name => p_first_name,
         p_last_name => p_last_name,
         p_email => p_email,
         p_password_hash => p_password_hash,
         p_salt => p_salt
      );
      
      -- Then insert into parent table with person_id
      insert into parent (person_id)
      values (v_person_id)
      returning parent_id into v_parent_id;
      dbms_output.put_line('Parent added: '
                           || p_first_name
                           || ' '
                           || p_last_name
                           || ' (Parent ID: '
                           || v_parent_id
                           || ', Person ID: '
                           || v_person_id
                           || ')');
      return v_parent_id;
   exception
      when DUP_VAL_ON_INDEX then
         RAISE_APPLICATION_ERROR(
            -20131,
            'Parent already exists for Person ID ' || v_person_id
         );
   end add_parent;

   procedure update_parent_person_info (
      p_parent_id     in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) as
      v_person_id number;
   begin
      -- Get the person_id for this parent
      select person_id into v_person_id
        from parent
       where parent_id = p_parent_id;
      
      -- Update the person record
      pkg_person.update_person(
         p_person_id => v_person_id,
         p_first_name => p_first_name,
         p_last_name => p_last_name,
         p_email => p_email,
         p_password_hash => p_password_hash,
         p_salt => p_salt
      );
      
      dbms_output.put_line('Parent person info updated: ID ' || p_parent_id);
   exception
      when no_data_found then
         dbms_output.put_line('No parent found with ID ' || p_parent_id);
   end update_parent_person_info;

   procedure delete_parent (
      p_parent_id in number
   ) as
      v_person_id number;
   begin
      -- Get the person_id for this parent
      select person_id into v_person_id
        from parent
       where parent_id = p_parent_id;
      
      -- Delete from parent table first
      delete from parent
       where parent_id = p_parent_id;
       
      -- Then delete from person table
      if sql%rowcount > 0 then
         pkg_person.delete_person(v_person_id);
         dbms_output.put_line('Parent deleted: ID ' || p_parent_id);
      else
         dbms_output.put_line('No parent found with ID ' || p_parent_id);
      end if;
   exception
      when no_data_found then
         dbms_output.put_line('No parent found with ID ' || p_parent_id);
   end delete_parent;

   function get_parent_by_id (
      p_parent_id in number
   ) return parent_rec as
      v_parent parent_rec;
   begin
      select pr.parent_id,
             pr.person_id,
             p.first_name,
             p.last_name,
             p.email,
             p.password_hash,
             p.salt
        into v_parent
        from parent pr
        join person p on pr.person_id = p.person_id
       where pr.parent_id = p_parent_id;

      return v_parent;
   exception
      when no_data_found then
         return null;
   end get_parent_by_id;

end pkg_parent;
/