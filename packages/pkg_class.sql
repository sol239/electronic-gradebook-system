/*
   File: pkg_class.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Class table.
*/

-- Package specification
create or replace package pkg_class as

    /*
       Adds a new class to the Class table.
       Parameters:
         p_class_name  - name of the class
         p_teacher_id - ID of the teacher for the class
    */
    procedure add_class (
        p_class_name  in varchar2,
        p_teacher_id in number
    );

    /*
       Updates an existing class in the Class table.
       Parameters:
         p_class_id   - ID of the class to update
         p_class_name  - new name of the class
         p_teacher_id - new teacher ID for the class
    */
    procedure update_class (
        p_class_id   in number,
        p_class_name  in varchar2,
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
        class_name  varchar2(100),
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

    /*
       Returns class_id by name.
       Parameters:
         p_class_name - name of the class
       Returns:
         class_id if found, NULL otherwise.
    */
    function get_class_id_by_name (
        p_class_name in varchar2
    ) return number;

end pkg_class;
/

-- Package body
create or replace package body pkg_class as

    procedure add_class (
        p_class_name  in varchar2,
        p_teacher_id in number
    ) as
    begin
        insert into class (
            class_name,
            teacher_id
        ) values (
            p_class_name,
            p_teacher_id
        );
        dbms_output.put_line('Class added: ' || p_class_name);
        commit;
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20151,
                'Class with this name already exists: ' || p_class_name
            );
        when VALUE_ERROR then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20152,
                'Invalid value or data type for Class: ' || p_class_name || ', teacher_id: ' || p_teacher_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20153,
                'Other error when adding Class: ' || p_class_name || ', teacher_id: ' || p_teacher_id || '. Error: ' || SQLERRM
            );
    end add_class;

    procedure update_class (
        p_class_id   in number,
        p_class_name  in varchar2,
        p_teacher_id in number
    ) as
        v_updated number;
    begin
        update class
            set class_name = p_class_name,
                teacher_id = p_teacher_id
          where class_id = p_class_id
          returning 1 into v_updated;
        dbms_output.put_line('Class updated: ID ' || p_class_id);
        commit;
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20154,
                'Class with this name already exists: ' || p_class_name
            );
        when VALUE_ERROR then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20155,
                'Invalid value or data type when updating Class: ' || p_class_name || ', teacher_id: ' || p_teacher_id
            );
        when NO_DATA_FOUND then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20156,
                'No class found with ID ' || p_class_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20157,
                'Other error when updating Class: ID ' || p_class_id || '. Error: ' || SQLERRM
            );
    end update_class;

    procedure delete_class (
        p_class_id in number
    ) as
        v_deleted number;
    begin
        delete from class
         where class_id = p_class_id
         returning 1 into v_deleted;
        dbms_output.put_line('Class deleted: ID ' || p_class_id);
        commit;
    exception
        when NO_DATA_FOUND then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20158,
                'No class found with ID ' || p_class_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20159,
                'Other error when deleting Class: ID ' || p_class_id || '. Error: ' || SQLERRM
            );
    end delete_class;

    function get_class_by_id (
        p_class_id in number
    ) return class_rec
    as
        v_class class_rec;
    begin
        select class_id,
               class_name,
               teacher_id
          into v_class
          from class
         where class_id = p_class_id;

        return v_class;
    exception
        when NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(
                -20160,
                'No class found with ID ' || p_class_id
            );
        when TOO_MANY_ROWS then
            RAISE_APPLICATION_ERROR(
                -20161,
                'Multiple classes found with ID ' || p_class_id
            );
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20162,
                'Other error when reading Class: ID ' || p_class_id || '. Error: ' || SQLERRM
            );
    end get_class_by_id;

    function get_class_id_by_name (
        p_class_name in varchar2
    ) return number as
        v_class_id number;
    begin
        select class_id
          into v_class_id
          from class
         where class_name = p_class_name;

        return v_class_id;
    exception
        when NO_DATA_FOUND then
            return null;
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20163,
                'Error when getting class ID by name: ' || p_class_name || '. Error: ' || SQLERRM
            );
    end get_class_id_by_name;

end pkg_class;
/