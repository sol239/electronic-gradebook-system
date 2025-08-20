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

    /*
       Returns class_group_id by natural key components.
       Parameters:
         p_class_id - ID of the class
         p_group_name - name of the group
       Returns:
         class_group_id if found, NULL otherwise.
    */
    function get_class_group_id_by_natural_key (
        p_class_id in number,
        p_group_name in varchar2
    ) return number;

    /*
       Returns the group name of a class group by its ID.
       Parameters:
         p_class_group_id - ID of the class group
       Returns:
         group_name as varchar2, or NULL if not found.
    */
    function get_class_group_name_by_id (
        p_class_group_id in number
    ) return varchar2;

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
        commit;
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20171,
                'Class group with this name already exists for class ID ' || p_class_id || ': ' || p_group_name
            );
        when VALUE_ERROR then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20172,
                'Type or length error when adding class group: ' || p_group_name || ' for class ID ' || p_class_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20173,
                'Unexpected error when adding class group: ' || p_group_name || ' for class ID ' || p_class_id || '. Error: ' || SQLERRM
            );
    end add_class_group;

    procedure update_class_group (
        p_class_group_id in number,
        p_class_id       in number,
        p_group_name     in varchar2
    ) as
        v_updated number;
    begin
        update class_group
            set class_id = p_class_id,
                group_name = p_group_name
          where class_group_id = p_class_group_id
          returning 1 into v_updated;
        dbms_output.put_line('Class group updated: ID ' || p_class_group_id);
        commit;
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20174,
                'Class group with this name already exists for class ID ' || p_class_id || ': ' || p_group_name
            );
        when VALUE_ERROR then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20175,
                'Type or length error when updating class group: ' || p_group_name || ' for class ID ' || p_class_id
            );
        when NO_DATA_FOUND then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20176,
                'No class group found with ID ' || p_class_group_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20177,
                'Unexpected error when updating class group: ID ' || p_class_group_id || '. Error: ' || SQLERRM
            );
    end update_class_group;

    procedure delete_class_group (
        p_class_group_id in number
    ) as
        v_deleted number;
    begin
        delete from class_group
         where class_group_id = p_class_group_id
         returning 1 into v_deleted;
        dbms_output.put_line('Class group deleted: ID ' || p_class_group_id);
        commit;
    exception
        when NO_DATA_FOUND then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20178,
                'No class group found with ID ' || p_class_group_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20179,
                'Unexpected error when deleting class group: ID ' || p_class_group_id || '. Error: ' || SQLERRM
            );
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
        when NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(
                -20180,
                'No class group found with ID ' || p_class_group_id
            );
        when TOO_MANY_ROWS then
            RAISE_APPLICATION_ERROR(
                -20181,
                'Multiple class groups found with ID ' || p_class_group_id
            );
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20182,
                'Unexpected error when reading class group: ID ' || p_class_group_id || '. Error: ' || SQLERRM
            );
    end get_class_group_by_id;

    function get_class_group_id_by_natural_key (
        p_class_id in number,
        p_group_name in varchar2
    ) return number as
        v_class_group_id number;
    begin
        select class_group_id
          into v_class_group_id
          from class_group
         where class_id = p_class_id
           and group_name = p_group_name;

        return v_class_group_id;
    exception
        when NO_DATA_FOUND then
            return null;
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20183,
                'Error when getting class group ID by natural key: class_id=' || p_class_id || 
                ', group_name=' || p_group_name || '. Error: ' || SQLERRM
            );
    end get_class_group_id_by_natural_key;

    function get_class_group_name_by_id (
        p_class_group_id in number
    ) return varchar2
    as
        v_group_name varchar2(100);
    begin
        select group_name
          into v_group_name
          from class_group
         where class_group_id = p_class_group_id;
        return v_group_name;
    exception
        when NO_DATA_FOUND then
            return null;
        when TOO_MANY_ROWS then
            RAISE_APPLICATION_ERROR(
                -20184,
                'Multiple class groups found with ID ' || p_class_group_id
            );
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20185,
                'Unexpected error when reading class group name: ID ' || p_class_group_id || '. Error: ' || SQLERRM
            );
    end get_class_group_name_by_id;

end pkg_class_group;
/
