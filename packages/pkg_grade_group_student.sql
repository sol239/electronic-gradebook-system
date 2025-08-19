/*
   File: pkg_grade_group_student.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for operations on the Grade_Group_Student table.
   Notes:
     - Links grade groups to their students.
     - Includes procedures: add, delete, get grade groups by student, get students by grade group.
*/

-- Package specification
create or replace package pkg_grade_group_student as

    /*
       Adds a grade group-student link to the Grade_Group_Student table.
       Parameters:
         p_grade_group_id - ID of the grade group
         p_student_id     - ID of the student
         p_grade          - grade value (optional)
         p_message        - message (optional)
         p_grade_date     - date of evaluation (optional, defaults to current_timestamp)
    */
    procedure add_grade_group_student (
        p_grade_group_id in number,
        p_student_id     in number,
        p_grade          in number default null,
        p_message        in varchar2 default null,
        p_grade_date     in timestamp default current_timestamp
    );

    /*
       Deletes a grade group-student link from the Grade_Group_Student table.
       Parameters:
         p_grade_group_id - ID of the grade group
         p_student_id     - ID of the student
    */
    procedure delete_grade_group_student (
        p_grade_group_id in number,
        p_student_id     in number
    );

    /*
       Type for returning a list of grade group IDs.
    */
    type grade_group_id_table is table of number;

    /*
       Type for returning a list of student IDs.
    */
    type student_id_table is table of number;

    /*
       Returns all grade group IDs for a given student.
       Parameters:
         p_student_id - ID of the student
       Returns:
         grade_group_id_table with grade group IDs.
    */
    function get_grade_groups_by_student (
        p_student_id in number
    ) return grade_group_id_table;

    /*
       Returns all student IDs for a given grade group.
       Parameters:
         p_grade_group_id - ID of the grade group
       Returns:
         student_id_table with student IDs.
    */
    function get_students_by_grade_group (
        p_grade_group_id in number
    ) return student_id_table;

end pkg_grade_group_student;
/

-- Package body
create or replace package body pkg_grade_group_student as

    procedure add_grade_group_student (
        p_grade_group_id in number,
        p_student_id     in number,
        p_grade          in number default null,
        p_message        in varchar2 default null,
        p_grade_date     in timestamp default current_timestamp
    ) as
    begin
        insert into grade_group_student (
            grade_group_id,
            student_id,
            grade,
            message,
            grade_date
        ) values (
            p_grade_group_id,
            p_student_id,
            p_grade,
            p_message,
            p_grade_date
        );
        dbms_output.put_line('Grade group-student link added: Grade Group ID '
                             || p_grade_group_id
                             || ', Student ID '
                             || p_student_id);
        commit;
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20211,
                'Grade group-student link already exists: Grade Group ID ' || p_grade_group_id || ', Student ID ' || p_student_id
            );
        when VALUE_ERROR then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20212,
                'Type or length error when adding grade group-student link: Grade Group ID ' || p_grade_group_id || ', Student ID ' || p_student_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20213,
                'Unexpected error when adding grade group-student link: Grade Group ID ' || p_grade_group_id || ', Student ID ' || p_student_id || '. Error: ' || SQLERRM
            );
    end add_grade_group_student;

    procedure delete_grade_group_student (
        p_grade_group_id in number,
        p_student_id     in number
    ) as
        v_deleted number;
    begin
        delete from grade_group_student
         where grade_group_id = p_grade_group_id
           and student_id = p_student_id
         returning 1 into v_deleted;
        dbms_output.put_line('Grade group-student link deleted: Grade Group ID '
                             || p_grade_group_id
                             || ', Student ID '
                             || p_student_id);
        commit;
    exception
        when NO_DATA_FOUND then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20214,
                'No Grade Group-Student link found for Grade Group ID ' || p_grade_group_id || ', Student ID ' || p_student_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20215,
                'Unexpected error when deleting Grade Group-Student link: Grade Group ID ' || p_grade_group_id || ', Student ID ' || p_student_id || '. Error: ' || SQLERRM
            );
    end delete_grade_group_student;

    function get_grade_groups_by_student (
        p_student_id in number
    ) return grade_group_id_table as
        v_groups grade_group_id_table;
    begin
        select grade_group_id
        bulk collect
          into v_groups
          from grade_group_student
         where student_id = p_student_id;
        return v_groups;
    exception
        when NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(
                -20216,
                'No grade groups found for Student ID ' || p_student_id
            );
        when TOO_MANY_ROWS then
            RAISE_APPLICATION_ERROR(
                -20217,
                'Multiple grade groups found for Student ID ' || p_student_id
            );
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20218,
                'Unexpected error when reading grade groups by student: Student ID ' || p_student_id || '. Error: ' || SQLERRM
            );
    end get_grade_groups_by_student;

    function get_students_by_grade_group (
        p_grade_group_id in number
    ) return student_id_table as
        v_students student_id_table;
    begin
        select student_id
        bulk collect
          into v_students
          from grade_group_student
         where grade_group_id = p_grade_group_id;
        return v_students;
    exception
        when NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(
                -20219,
                'No students found for Grade Group ID ' || p_grade_group_id
            );
        when TOO_MANY_ROWS then
            RAISE_APPLICATION_ERROR(
                -20220,
                'Multiple students found for Grade Group ID ' || p_grade_group_id
            );
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20221,
                'Unexpected error when reading students by grade group: Grade Group ID ' || p_grade_group_id || '. Error: ' || SQLERRM
            );
    end get_students_by_grade_group;

end pkg_grade_group_student;
/
