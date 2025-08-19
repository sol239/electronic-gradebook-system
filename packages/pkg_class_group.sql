/*
   File: pkg_class_group.sql
   Author: David Válek
   Created: 2025-08-19
   Description: Package for CRUD operations on the Class_Group table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
*/

-- Package specification
create or replace package pkg_class_group as

    /*
       Adds a new class group to the Class_Group table.
       Parameters:
         p_class_id   - ID of the class
         p_group_name - name of the group
    */
    procedure add_class_group (
        p_class_id   in number,
        p_group_name in varchar2
    );

    /*
       Updates an existing class group in the Class_Group table.
       Parameters:
         p_class_group_id - ID of the class group to update
         p_class_id       - new class ID
         p_group_name     - new group name
    */
    procedure update_class_group (
        p_class_group_id in number,
        p_class_id       in number,
        p_group_name     in varchar2
    );

    /*
       Deletes a class group from the Class_Group table.
       Parameters:
         p_class_group_id - ID of the class group to delete
    */
    procedure delete_class_group (
        p_class_group_id in number
    );

    /*
       Type for return value of get_class_group_by_id function.
    */
    type class_group_rec is record (
        class_group_id number,
        class_id       number,
        group_name     varchar2(100)
    );

    /*
       Returns class group details by ID.
       Parameters:
         p_class_group_id - ID of the class group
       Returns:
         class_group_rec with details, or NULL if not found.
    */
    function get_class_group_by_id (
        p_class_group_id in number
    ) return class_group_rec;

end pkg_class_group;
/


-- Package body
create or replace package body pkg_class_group as

    procedure add_class_group (
        p_class_id   in number,
        p_group_name in varchar2
    ) as
    begin
        insert into class_group (
            class_id,
            group_name
        ) values (
            p_class_id,
            p_group_name
        );
        dbms_output.put_line('Class group added: ' || p_group_name);
    end add_class_group;

    procedure update_class_group (
        p_class_group_id in number,
        p_class_id       in number,
        p_group_name     in varchar2
    ) as
    begin
        update class_group
            set class_id = p_class_id,
                group_name = p_group_name
          where class_group_id = p_class_group_id;
        if sql%rowcount = 0 then
            dbms_output.put_line('No class group found with ID ' || p_class_group_id);
        else
            dbms_output.put_line('Class group updated: ID ' || p_class_group_id);
        end if;
    end update_class_group;

    procedure delete_class_group (
        p_class_group_id in number
    ) as
    begin
        delete from class_group
         where class_group_id = p_class_group_id;
        if sql%rowcount = 0 then
            dbms_output.put_line('No class group found with ID ' || p_class_group_id);
        else
            dbms_output.put_line('Class group deleted: ID ' || p_class_group_id);
        end if;
    end delete_class_group;

    function get_class_group_by_id (
        p_class_group_id in number
    ) return class_group_rec
    as
        v_class_group class_group_rec;
    begin
        select class_group_id,
               class_id,
               group_name
          into v_class_group
          from class_group
         where class_group_id = p_class_group_id;

        return v_class_group;
    exception
        when no_data_found then
            return null;
    end get_class_group_by_id;

end pkg_class_group;
/
