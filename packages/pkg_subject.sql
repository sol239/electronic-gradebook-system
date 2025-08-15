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