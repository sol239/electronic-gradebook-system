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
    end add_class_group_student;

    procedure delete_class_group_student (
        p_class_group_id in number,
        p_student_id     in number
    ) as
    begin
        delete from class_group_student
         where class_group_id = p_class_group_id
           and student_id = p_student_id;
        if sql%rowcount = 0 then
            dbms_output.put_line('No record found for class group ' || p_class_group_id || ' and student ' || p_student_id);
        else
            dbms_output.put_line('Student ' || p_student_id || ' removed from class group ' || p_class_group_id);
        end if;
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
        when no_data_found then
            return null;
    end get_class_group_student;

end pkg_class_group_student;
/
