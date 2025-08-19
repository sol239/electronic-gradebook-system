/*
   File: pkg_classroom.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Classroom table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
*/

-- Package specification
create or replace package pkg_classroom as

    /*
       Adds a new classroom to the Classroom table.
       Parameters:
         p_name     - name of the classroom
         p_capacity - capacity of the classroom
    */
    procedure add_classroom (
        p_name      in varchar2,
        p_capacity  in number
    );

    /*
       Updates an existing classroom in the Classroom table.
       Parameters:
         p_classroom_id - ID of the classroom to update
         p_name         - new name of the classroom
         p_capacity     - new capacity of the classroom
    */
    procedure update_classroom (
        p_classroom_id  in number,
        p_name          in varchar2,
        p_capacity      in number
    );

    /*
       Deletes a classroom from the Classroom table.
       Parameters:
         p_classroom_id - ID of the classroom to delete
    */
    procedure delete_classroom (
        p_classroom_id in number
    );

    /*
       Type for return value of get_classroom_by_id function.
    */
    type classroom_rec is record (
        classroom_id number,
        name         varchar2(50),
        capacity     number
    );

    /*
       Returns classroom details by ID.
       Parameters:
         p_classroom_id - ID of the classroom
       Returns:
         classroom_rec with classroom details, or NULL if not found.
    */
    function get_classroom_by_id (
        p_classroom_id in number
    ) return classroom_rec;

end pkg_classroom;
/

-- Package body
create or replace package body pkg_classroom as

    procedure add_classroom (
        p_name      in varchar2,
        p_capacity  in number
    ) as
    begin
        insert into classroom (
            name,
            capacity
        ) values (
            p_name,
            p_capacity
        );
        dbms_output.put_line('Classroom added: ' || p_name);
    end add_classroom;

    procedure update_classroom (
        p_classroom_id  in number,
        p_name          in varchar2,
        p_capacity      in number
    ) as
    begin
        update classroom
            set name     = p_name,
                capacity = p_capacity
          where classroom_id = p_classroom_id;
        if sql%rowcount = 0 then
            dbms_output.put_line('No classroom found with ID ' || p_classroom_id);
        else
            dbms_output.put_line('Classroom updated: ID ' || p_classroom_id);
        end if;
    end update_classroom;

    procedure delete_classroom (
        p_classroom_id in number
    ) as
    begin
        delete from classroom
         where classroom_id = p_classroom_id;
        if sql%rowcount = 0 then
            dbms_output.put_line('No classroom found with ID ' || p_classroom_id);
        else
            dbms_output.put_line('Classroom deleted: ID ' || p_classroom_id);
        end if;
    end delete_classroom;

    function get_classroom_by_id (
        p_classroom_id in number
    ) return classroom_rec
    as
        v_classroom classroom_rec;
    begin
        select classroom_id,
               name,
               capacity
          into v_classroom
          from classroom
         where classroom_id = p_classroom_id;

        return v_classroom;
    exception
        when no_data_found then
            return null;
    end get_classroom_by_id;

end pkg_classroom;
