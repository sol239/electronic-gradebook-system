/*
   File: pkg_grade.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Grade table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
*/

-- Package specification
create or replace package pkg_grade as

    /*
       Adds a new grade to the Grade table.
       Parameters:
         p_student_id - ID of the student
         p_subject_id - ID of the subject
         p_teacher_id - ID of the teacher
         p_grade      - grade value (1-5)
         p_grade_date - date of the grade (optional, defaults to sysdate)
    */
    procedure add_grade (
        p_student_id in number,
        p_subject_id in number,
        p_teacher_id in number,
        p_grade      in number,
        p_grade_date in date default sysdate
    );

    /*
       Updates an existing grade in the Grade table.
       Parameters:
         p_grade_id   - ID of the grade to update
         p_student_id - new student ID
         p_subject_id - new subject ID
         p_teacher_id - new teacher ID
         p_grade      - new grade value
         p_grade_date - new grade date (optional, defaults to sysdate)
    */
    procedure update_grade (
        p_grade_id   in number,
        p_student_id in number,
        p_subject_id in number,
        p_teacher_id in number,
        p_grade      in number,
        p_grade_date in date default sysdate
    );

    /*
       Deletes a grade from the Grade table.
       Parameters:
         p_grade_id - ID of the grade to delete
    */
    procedure delete_grade (
        p_grade_id in number
    );

    /*
       Type for return value of get_grade_by_id function.
    */
    type grade_rec is record (
        grade_id    number,
        student_id  number,
        subject_id  number,
        teacher_id  number,
        grade       number,
        grade_date  date
    );

    /*
       Returns grade details by ID.
       Parameters:
         p_grade_id - ID of the grade
       Returns:
         grade_rec with grade details, or NULL if not found.
    */
    function get_grade_by_id (
        p_grade_id in number
    ) return grade_rec;

end pkg_grade;
/

-- Package body
create or replace package body pkg_grade as

    procedure add_grade (
        p_student_id in number,
        p_subject_id in number,
        p_teacher_id in number,
        p_grade      in number,
        p_grade_date in date default sysdate
    ) as
    begin
        insert into grade (
            student_id,
            subject_id,
            teacher_id,
            grade,
            grade_date
        ) values (
            p_student_id,
            p_subject_id,
            p_teacher_id,
            p_grade,
            p_grade_date
        );
        dbms_output.put_line('Grade added for student ID ' || p_student_id);
    end add_grade;

    procedure update_grade (
        p_grade_id   in number,
        p_student_id in number,
        p_subject_id in number,
        p_teacher_id in number,
        p_grade      in number,
        p_grade_date in date default sysdate
    ) as
    begin
        update grade
            set student_id = p_student_id,
                subject_id = p_subject_id,
                teacher_id = p_teacher_id,
                grade      = p_grade,
                grade_date = p_grade_date
          where grade_id = p_grade_id;
        if sql%rowcount = 0 then
            dbms_output.put_line('No grade found with ID ' || p_grade_id);
        else
            dbms_output.put_line('Grade updated: ID ' || p_grade_id);
        end if;
    end update_grade;

    procedure delete_grade (
        p_grade_id in number
    ) as
    begin
        delete from grade
         where grade_id = p_grade_id;
        if sql%rowcount = 0 then
            dbms_output.put_line('No grade found with ID ' || p_grade_id);
        else
            dbms_output.put_line('Grade deleted: ID ' || p_grade_id);
        end if;
    end delete_grade;

    function get_grade_by_id (
        p_grade_id in number
    ) return grade_rec
    as
        v_grade grade_rec;
    begin
        select grade_id,
               student_id,
               subject_id,
               teacher_id,
               grade,
               grade_date
          into v_grade
          from grade
         where grade_id = p_grade_id;

        return v_grade;
    exception
        when no_data_found then
            return null;
    end get_grade_by_id;

end pkg_grade;
/
