/*
   File: pkg_parent.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Parent table.
   Notes:
     - Uses seq_parent_id to auto-generate primary keys.
     - Includes procedures: add, update, delete, get by ID.
*/

-- Package specification
create or replace package pkg_parent as

    /*
       Adds a new parent to the Parent table.
       Parameters:
         p_first_name - first name of the parent
         p_last_name  - last name of the parent
         p_email      - email of the parent (must be unique)
    */
   procedure add_parent (
      p_first_name in varchar2,
      p_last_name  in varchar2,
      p_email      in varchar2
   );

    /*
       Updates an existing parent in the Parent table.
       Parameters:
         p_parent_id  - ID of the parent to update
         p_first_name - new first name
         p_last_name  - new last name
         p_email      - new email
    */
   procedure update_parent (
      p_parent_id  in number,
      p_first_name in varchar2,
      p_last_name  in varchar2,
      p_email      in varchar2
   );

    /*
       Deletes a parent from the Parent table.
       Parameters:
         p_parent_id - ID of the parent to delete
    */
   procedure delete_parent (
      p_parent_id in number
   );

    /*
       Retrieves and prints parent details by ID.
       Parameters:
         p_parent_id - ID of the parent to retrieve
       Output:
         Prints parent information via DBMS_OUTPUT
    */
   procedure get_parent_by_id (
      p_parent_id in number
   );

end pkg_parent;
/

-- Package body
create or replace package body pkg_parent as

   procedure add_parent (
      p_first_name in varchar2,
      p_last_name  in varchar2,
      p_email      in varchar2
   ) as
   begin
      insert into parent (
         parent_id,
         first_name,
         last_name,
         email
      ) values ( seq_parent_id.nextval,
                 p_first_name,
                 p_last_name,
                 p_email );

      dbms_output.put_line('Parent added: '
                           || p_first_name
                           || ' '
                           || p_last_name);
   end add_parent;


   procedure update_parent (
      p_parent_id  in number,
      p_first_name in varchar2,
      p_last_name  in varchar2,
      p_email      in varchar2
   ) as
   begin
      update parent
         set first_name = p_first_name,
             last_name = p_last_name,
             email = p_email
       where parent_id = p_parent_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No parent found with ID ' || p_parent_id);
      else
         dbms_output.put_line('Parent updated: ID ' || p_parent_id);
      end if;
   end update_parent;


   procedure delete_parent (
      p_parent_id in number
   ) as
   begin
      delete from parent
       where parent_id = p_parent_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No parent found to delete with ID ' || p_parent_id);
      else
         dbms_output.put_line('Parent deleted: ID ' || p_parent_id);
      end if;
   end delete_parent;


   procedure get_parent_by_id (
      p_parent_id in number
   ) as
      v_first_name parent.first_name%type;
      v_last_name  parent.last_name%type;
      v_email      parent.email%type;
   begin
      select first_name,
             last_name,
             email
        into
         v_first_name,
         v_last_name,
         v_email
        from parent
       where parent_id = p_parent_id;

      dbms_output.put_line('Parent ID: ' || p_parent_id);
      dbms_output.put_line('First Name: ' || v_first_name);
      dbms_output.put_line('Last Name: ' || v_last_name);
      dbms_output.put_line('Email: ' || v_email);
   exception
      when no_data_found then
         dbms_output.put_line('Parent with ID '
                              || p_parent_id
                              || ' not found.');
   end get_parent_by_id;

end pkg_parent;
/