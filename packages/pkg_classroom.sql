/*
   File: pkg_classroom.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Classroom table.
*/

-- Package specification
create or replace package pkg_classroom as

    /*
       Adds a new classroom to the Classroom table.
       Parameters:
         p_classroom_name     - name of the classroom
         p_capacity - capacity of the classroom
    */
    procedure add_classroom (
        p_classroom_name      in varchar2,
        p_capacity  in number
    );

    /*
       Updates an existing classroom in the Classroom table.
       Parameters:
         p_classroom_id      - old classroom ID
         p_classroom_name              - new name
         p_capacity          - new capacity
    */
    procedure update_classroom (
        p_classroom_id  in number,
        p_classroom_name in varchar2,
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
        classroom_name varchar2(50),
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

    /*
       Returns classroom_id by name.
       Parameters:
         p_classroom_name - name of the classroom
       Returns:
         classroom_id if found, NULL otherwise.
    */
    function get_classroom_id_by_name (
        p_classroom_name in varchar2
    ) return number;

end pkg_classroom;
/

-- Package body
create or replace package body pkg_classroom as

    procedure add_classroom (
        p_classroom_name in varchar2,
        p_capacity  in number
    ) as
    begin
        insert into classroom (
            classroom_name,
            capacity
        ) values (
            p_classroom_name,
            p_capacity
        );
        dbms_output.put_line('Classroom added: ' || p_classroom_name);
        commit;
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20161,
                'Classroom with this name already exists: ' || p_classroom_name
            );
        when VALUE_ERROR then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20162,
                'Invalid value or data type for Classroom: ' || p_classroom_name || ', capacity: ' || p_capacity
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20163,
                'Other error when adding Classroom: ' || p_classroom_name || ', capacity: ' || p_capacity || '. Error: ' || SQLERRM
            );
    end add_classroom;

    procedure update_classroom (
        p_classroom_id  in number,
        p_classroom_name in varchar2,
        p_capacity      in number
    ) as
        v_updated number;
    begin
        update classroom
            set classroom_name = p_classroom_name,
                capacity = p_capacity
          where classroom_id = p_classroom_id
          returning 1 into v_updated;
        dbms_output.put_line('Classroom updated: ID ' || p_classroom_id);
        commit;
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20164,
                'Classroom with this name already exists: ' || p_classroom_name
            );
        when VALUE_ERROR then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20165,
                'Invalid value or data type for Classroom: ' || p_classroom_name || ', capacity: ' || p_capacity
            );
        when NO_DATA_FOUND then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20166,
                'No classroom found with ID ' || p_classroom_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20167,
                'Other error when updating Classroom: ID ' || p_classroom_id || '. Error: ' || SQLERRM
            );
    end update_classroom;

    procedure delete_classroom (
        p_classroom_id in number
    ) as
        v_deleted number;
    begin
        delete from classroom
         where classroom_id = p_classroom_id
         returning 1 into v_deleted;
        dbms_output.put_line('Classroom deleted: ID ' || p_classroom_id);
        commit;
    exception
        when NO_DATA_FOUND then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20168,
                'No classroom found with ID ' || p_classroom_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20169,
                'Other error when deleting Classroom: ID ' || p_classroom_id || '. Error: ' || SQLERRM
            );
    end delete_classroom;

    function get_classroom_by_id (
        p_classroom_id in number
    ) return classroom_rec
    as
        v_classroom classroom_rec;
    begin
        select classroom_id,
               classroom_name,
               capacity
          into v_classroom
          from classroom
         where classroom_id = p_classroom_id;

        return v_classroom;
    exception
        when NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(
                -20170,
                'No classroom found with ID ' || p_classroom_id
            );
        when TOO_MANY_ROWS then
            RAISE_APPLICATION_ERROR(
                -20171,
                'Multiple classrooms found with ID ' || p_classroom_id
            );
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20172,
                'Other error when reading Classroom: ID ' || p_classroom_id || '. Error: ' || SQLERRM
            );
    end get_classroom_by_id;

    function get_classroom_id_by_name (
        p_classroom_name in varchar2
    ) return number as
        v_classroom_id number;
    begin
        select classroom_id
          into v_classroom_id
          from classroom
         where classroom_name = p_classroom_name;

        return v_classroom_id;
    exception
        when NO_DATA_FOUND then
            return null;
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20173,
                'Error when getting classroom ID by name: ' || p_classroom_name || '. Error: ' || SQLERRM
            );
    end get_classroom_id_by_name;

end pkg_classroom;
/
