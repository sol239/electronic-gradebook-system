/*
   File: pkg_class.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Class table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
*/

-- Package specification
create or replace package pkg_class as

    /*
       Adds a new class to the Class table.
       Parameters:
         p_name       - name of the class
         p_teacher_id - ID of the teacher for the class
    */
    procedure add_class (
        p_name       in varchar2,
        p_teacher_id in number
    );

    /*
       Updates an existing class in the Class table.
       Parameters:
         p_class_id   - ID of the class to update
         p_name       - new name of the class
         p_teacher_id - new teacher ID for the class
    */
    procedure update_class (
        p_class_id   in number,
        p_name       in varchar2,
        p_teacher_id in number
    );

    /*
       Deletes a class from the Class table.
       Parameters:
         p_class_id - ID of the class to delete
    */
    procedure delete_class (
        p_class_id in number
    );

    /*
       Type for return value of get_class_by_id function.
    */
    type class_rec is record (
        class_id    number,
        name        varchar2(100),
        teacher_id  number
    );

    /*
       Returns class details by ID.
       Parameters:
         p_class_id - ID of the class
       Returns:
         class_rec with class details, or NULL if not found.
    */
    function get_class_by_id (
        p_class_id in number
    ) return class_rec;

end pkg_class;
/

-- Package body
create or replace package body pkg_class as

    procedure add_class (
        p_name       in varchar2,
        p_teacher_id in number
    ) as
    begin
        insert into class (
            name,
            teacher_id
        ) values (
            p_name,
            p_teacher_id
        );
        dbms_output.put_line('Class added: ' || p_name);
    end add_class;

    procedure update_class (
        p_class_id   in number,
        p_name       in varchar2,
        p_teacher_id in number
    ) as
    begin
        update class
            set name = p_name,
                teacher_id = p_teacher_id
          where class_id = p_class_id;
        if sql%rowcount = 0 then
            dbms_output.put_line('No class found with ID ' || p_class_id);
        else
            dbms_output.put_line('Class updated: ID ' || p_class_id);
        end if;
    end update_class;

    procedure delete_class (
        p_class_id in number
    ) as
    begin
        delete from class
         where class_id = p_class_id;
        if sql%rowcount = 0 then
            dbms_output.put_line('No class found with ID ' || p_class_id);
        else
            dbms_output.put_line('Class deleted: ID ' || p_class_id);
        end if;
    end delete_class;

    function get_class_by_id (
        p_class_id in number
    ) return class_rec
    as
        v_class class_rec;
    begin
        select class_id,
               name,
               teacher_id
          into v_class
          from class
         where class_id = p_class_id;

        return v_class;
    exception
        when no_data_found then
            return null;
    end get_class_by_id;

end pkg_class;
/