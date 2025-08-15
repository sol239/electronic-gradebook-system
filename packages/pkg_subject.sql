/*
   File: pkg_subject.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Subject table.
   Notes:
     - Uses seq_subject_id to auto-generate primary keys.
     - Includes procedures: add, update, delete, get by ID.
*/

-- Package specification
create or replace package pkg_subject as

    /*
    Adds a new subject to the database.
    Parameters:
      p_name - The name of the subject to add.
    */
   procedure add_subject (
      p_name in varchar2
   );

   /*
   Updates an existing subject in the database.
   Parameters:
      p_id   - The ID of the subject to update.
      p_name - The new name of the subject.
   */
   procedure update_subject (
      p_id   in number,
      p_name in varchar2
   );

   /*
   Deletes an existing subject from the database.
   Parameters:
      p_id - The ID of the subject to delete.
   */
   procedure delete_subject (
      p_id in number
   );

   /*
   Retrieves an existing subject from the database.
   Parameters:
      p_id - The ID of the subject to retrieve.
   */
   function get_subject (
      p_id in number
   ) return subject%rowtype;
end pkg_subject;

-- Package body
create or replace package body pkg_subject as

   procedure add_subject (
      p_name in varchar2
   ) is
   begin
      insert into subject (
         id,
         name
      ) values ( seq_subject_id.nextval,
                 p_name );
      dbms_output.put_line('Subject added: ' || p_name);
   end add_subject;

   procedure update_subject (
      p_id   in number,
      p_name in varchar2
   ) is
   begin
      update subject
         set
         name = p_name
       where id = p_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No subject found with ID ' || p_id);
      else
         dbms_output.put_line('Subject updated: ID ' || p_id);
      end if;
   end update_subject;

   procedure delete_subject (
      p_id in number
   ) is
   begin
      delete from subject
       where id = p_id;
      if sql%rowcount = 0 then
         dbms_output.put_line('No subject found with ID ' || p_id);
      else
         dbms_output.put_line('Subject deleted: ID ' || p_id);
      end if;
   end delete_subject;

   procedure get_subject_by_id (
      p_id in number
   ) is
      v_name subject.name%type;
   begin
      select name
        into v_name
        from subject
       where id = p_id;

      dbms_output.put_line('Subject ID: ' || p_id);
      dbms_output.put_line('Name: ' || v_name);
   exception
      when no_data_found then
         dbms_output.put_line('Subject with ID '
                              || p_id
                              || ' not found.');
   end get_subject_by_id;

end pkg_subject;