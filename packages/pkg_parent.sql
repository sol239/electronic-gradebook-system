/*
   File: pkg_parent.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Parent table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
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
         p_password_hash   - password hash for the parent
    */
   procedure add_parent (
      p_first_name in varchar2,
      p_last_name  in varchar2,
      p_email      in varchar2,
      p_password_hash   in varchar2
   );

    /*
       Updates an existing parent in the Parent table.
       Parameters:
         p_parent_id  - ID of the parent to update
         p_first_name - new first name
         p_last_name  - new last name
         p_email      - new email
         p_password_hash   - new password hash
    */
   procedure update_parent (
      p_parent_id  in number,
      p_first_name in varchar2,
      p_last_name  in varchar2,
      p_email      in varchar2,
      p_password_hash   in varchar2
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
       Type for return value of get_parent_by_id function.
    */
    type parent_rec is record (
        parent_id   number,
        first_name  varchar2(100),
        last_name   varchar2(100),
        email       varchar2(100),
        password_hash    varchar2(256)
    );

    /*
       Returns parent details by ID.
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

   procedure add_parent (
      p_first_name in varchar2,
      p_last_name  in varchar2,
      p_email      in varchar2,
      p_password_hash   in varchar2
   ) as
   begin
      insert into parent (
         first_name,
         last_name,
         email,
         password_hash
      ) values ( p_first_name,
                 p_last_name,
                 p_email,
                 p_password_hash );

      dbms_output.put_line('Parent added: '
                           || p_first_name
                           || ' '
                           || p_last_name);
   end add_parent;


   procedure update_parent (
      p_parent_id  in number,
      p_first_name in varchar2,
      p_last_name  in varchar2,
      p_email      in varchar2,
      p_password_hash   in varchar2
   ) as
   begin
      update parent
         set first_name = p_first_name,
             last_name = p_last_name,
             email = p_email,
             password_hash = p_password_hash
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


   function get_parent_by_id (
        p_parent_id in number
    ) return parent_rec
    as
        v_parent parent_rec;
    begin
        select parent_id,
               first_name,
               last_name,
               email,
               password_hash
          into v_parent
          from parent
         where parent_id = p_parent_id;

        return v_parent;
    exception
        when no_data_found then
            return null;
    end get_parent_by_id;

end pkg_parent;
/