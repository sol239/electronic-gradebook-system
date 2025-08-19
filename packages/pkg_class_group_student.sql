/*
   File: pkg_class_group_student.sql
   Author: David Válek
   Created: 2025-08-19
   Description: Package for CRUD operations on the Class_Group_Student table.
   Notes:
     - Composite primary key (class_id_group, student_id).
     - Includes procedures: add, delete, get by ID.
*/

-- Package specification
create or replace package pkg_class_group_student as

    /*
       Adds a new student to a class group.
       Parameters:
         p_class_id_group - ID of the class group
         p_student_id     - ID of the student
    */
    procedure add_class_group_student (
        p_class_group_id in number,
        p_student_id     in number
    );

    /*
       Deletes a student from a class group.
       Parameters:
         p_class_id_group - ID of the class group
         p_student_id     - ID of the student
    */
    procedure delete_class_group_student (
        p_class_group_id in number,
        p_student_id     in number
    );

    /*
       Type for return value of get_class_group_student function.
    */
    type class_group_student_rec is record (
        class_group_id number,
        student_id     number
    );

    /*
       Returns class group student details by IDs.
       Parameters:
         p_class_id_group - ID of the class group
         p_student_id     - ID of the student
       Returns:
         class_group_student_rec with details, or NULL if not found.
    */
    function get_class_group_student (
        p_class_group_id in number,
        p_student_id     in number
    ) return class_group_student_rec;

    /*
       Updates an existing student-class group link.
       Parameters:
         p_class_group_id - ID of the class group
         p_student_id     - ID of the student
         p_new_class_group_id - new class group ID
         p_new_student_id     - new student ID
    */
    procedure update_class_group_student (
        p_class_group_id    in number,
        p_student_id        in number,
        p_new_class_group_id in number,
        p_new_student_id     in number
    );

end pkg_class_group_student;
/


-- Package body
create or replace package body pkg_class_group_student as

    procedure add_class_group_student (
        p_class_group_id in number,
        p_student_id     in number
    ) as
    begin
        insert into class_group_student (
            class_group_id,
            student_id
        ) values (
            p_class_group_id,
            p_student_id
        );
        dbms_output.put_line('Student ' || p_student_id || ' added to class group ' || p_class_group_id);
        commit;
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20181,
                'Student already assigned to this class group: ' || p_class_group_id || ', ' || p_student_id
            );
        when VALUE_ERROR then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20182,
                'Type or length error when adding student to class group: ' || p_class_group_id || ', ' || p_student_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20183,
                'Unexpected error when adding student to class group: ' || p_class_group_id || ', ' || p_student_id || '. Error: ' || SQLERRM
            );
    end add_class_group_student;

    procedure update_class_group_student (
        p_class_group_id    in number,
        p_student_id        in number,
        p_new_class_group_id in number,
        p_new_student_id     in number
    ) as
        v_updated number;
    begin
        update class_group_student
           set class_group_id = p_new_class_group_id,
               student_id = p_new_student_id
         where class_group_id = p_class_group_id
           and student_id = p_student_id
         returning 1 into v_updated;
        dbms_output.put_line('Class group student updated: Old (' || p_class_group_id || ', ' || p_student_id || ') -> New (' || p_new_class_group_id || ', ' || p_new_student_id || ')');
        commit;
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20189,
                'Update would create duplicate class group-student link: ' || p_new_class_group_id || ', ' || p_new_student_id
            );
        when VALUE_ERROR then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20190,
                'Type or length error when updating class group-student link: Old (' || p_class_group_id || ', ' || p_student_id || ')'
            );
        when NO_DATA_FOUND then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20191,
                'No class group-student link found for: ' || p_class_group_id || ', ' || p_student_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20192,
                'Unexpected error when updating class group-student link: Old (' || p_class_group_id || ', ' || p_student_id || '). Error: ' || SQLERRM
            );
    end update_class_group_student;

    procedure delete_class_group_student (
        p_class_group_id in number,
        p_student_id     in number
    ) as
        v_deleted number;
    begin
        delete from class_group_student
         where class_group_id = p_class_group_id
           and student_id = p_student_id
         returning 1 into v_deleted;
        dbms_output.put_line('Student ' || p_student_id || ' removed from class group ' || p_class_group_id);
        commit;
    exception
        when NO_DATA_FOUND then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20184,
                'No record found for class group ' || p_class_group_id || ' and student ' || p_student_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20185,
                'Unexpected error when deleting student from class group: ' || p_class_group_id || ', ' || p_student_id || '. Error: ' || SQLERRM
            );
    end delete_class_group_student;

    function get_class_group_student (
        p_class_group_id in number,
        p_student_id     in number
    ) return class_group_student_rec
    as
        v_cgs class_group_student_rec;
    begin
        select class_group_id,
               student_id
          into v_cgs
          from class_group_student
         where class_group_id = p_class_group_id
           and student_id = p_student_id;

        return v_cgs;
    exception
        when NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(
                -20186,
                'No class group student found for: ' || p_class_group_id || ', ' || p_student_id
            );
        when TOO_MANY_ROWS then
            RAISE_APPLICATION_ERROR(
                -20187,
                'Multiple class group student records found for: ' || p_class_group_id || ', ' || p_student_id
            );
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20188,
                'Unexpected error when reading class group student: ' || p_class_group_id || ', ' || p_student_id || '. Error: ' || SQLERRM
            );
    end get_class_group_student;

end pkg_class_group_student;
/
