/*
   File: pkg_grade_group.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Grade_Group table.
   Notes:
     - Uses auto-incrementing identity column for primary key.
     - Includes procedures: add, update, delete, get by ID.
*/

-- Package specification
create or replace package pkg_grade_group as

    /*
       Adds a new grade group to the Grade_Group table.
       Parameters:
         p_subject_id   - ID of the subject
         p_teacher_id   - ID of the teacher
         p_grade_group_date - date of the grade group (optional, defaults to current_timestamp)
         p_name         - name of the grade group
         p_description  - description (optional)
    */
    procedure add_grade_group (
        p_subject_id   in number,
        p_teacher_id   in number,
        p_grade_group_date in timestamp default current_timestamp,
        p_name         in varchar2,
        p_description  in varchar2 default null
    );

    /*
       Updates an existing grade group in the Grade_Group table.
       Parameters:
         p_grade_group_id - ID of the grade group to update
         p_subject_id     - new subject ID
         p_teacher_id     - new teacher ID
         p_grade_group_date - new date (optional, defaults to current_timestamp)
         p_name           - new name
         p_description    - new description (optional)
    */
    procedure update_grade_group (
        p_grade_group_id in number,
        p_subject_id     in number,
        p_teacher_id     in number,
        p_grade_group_date in timestamp default current_timestamp,
        p_name           in varchar2,
        p_description    in varchar2 default null
    );

    /*
       Deletes a grade group from the Grade_Group table.
       Parameters:
         p_grade_group_id - ID of the grade group to delete
    */
    procedure delete_grade_group (
        p_grade_group_id in number
    );

    /*
       Type for return value of get_grade_group_by_id function.
    */
    type grade_group_rec is record (
        grade_group_id number,
        subject_id     number,
        teacher_id     number,
        grade_group_date timestamp,
        name           varchar2(50),
        description    varchar2(255)
    );

    /*
       Returns grade group details by ID.
       Parameters:
         p_grade_group_id - ID of the grade group
       Returns:
         grade_group_rec with grade group details, or NULL if not found.
    */
    function get_grade_group_by_id (
        p_grade_group_id in number
    ) return grade_group_rec;

    /*
       Returns the average grade for a specific grade group.
       Parameters:
         p_grade_group_id - ID of the grade group
       Returns:
         Average grade as a number, or NULL if not found.
    */
    function get_average_grade (
        p_grade_group_id in number
    ) return number;

    /*
       Returns the most common grade for a specific grade group.
       Parameters:
         p_grade_group_id - ID of the grade group
       Returns:
         Most common grade as a number, or NULL if not found.
    */
    function get_most_common_grade (
        p_grade_group_id in number
    ) return number;

    /*
       Returns the median grade for a specific grade group.
       Parameters:
         p_grade_group_id - ID of the grade group
       Returns:
         Median grade as a number, or NULL if not found.
    */
    function get_median_grade (
        p_grade_group_id in number
    ) return number;

    /*
       Returns grade_group_id by natural key components.
       Parameters:
         p_subject_id - ID of the subject
         p_teacher_id - ID of the teacher
         p_grade_group_date - date of the grade group
         p_name - name of the grade group
       Returns:
         grade_group_id if found, NULL otherwise.
    */
    function get_grade_group_id_by_natural_key (
        p_subject_id in number,
        p_teacher_id in number,
        p_grade_group_date in timestamp,
        p_name in varchar2
    ) return number;

end pkg_grade_group;
/

-- Package body
create or replace package body pkg_grade_group as

    procedure add_grade_group (
        p_subject_id   in number,
        p_teacher_id   in number,
        p_grade_group_date in timestamp default current_timestamp,
        p_name         in varchar2,
        p_description  in varchar2 default null
    ) as
    begin
        insert into grade_group (
            subject_id,
            teacher_id,
            grade_group_date,
            name,
            description
        ) values (
            p_subject_id,
            p_teacher_id,
            p_grade_group_date,
            p_name,
            p_description
        );
        dbms_output.put_line('Grade group added for subject ID ' || p_subject_id || ', teacher ID ' || p_teacher_id);
        commit;
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20201,
                'Grade group with this name and date already exists for subject ID ' || p_subject_id || ', teacher ID ' || p_teacher_id
            );
        when VALUE_ERROR then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20202,
                'Type or length error when adding grade group: subject ID ' || p_subject_id || ', teacher ID ' || p_teacher_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20203,
                'Unexpected error when adding grade group: subject ID ' || p_subject_id || ', teacher ID ' || p_teacher_id || '. Error: ' || SQLERRM
            );
    end add_grade_group;

    procedure update_grade_group (
        p_grade_group_id in number,
        p_subject_id     in number,
        p_teacher_id     in number,
        p_grade_group_date in timestamp default current_timestamp,
        p_name           in varchar2,
        p_description    in varchar2 default null
    ) as
        v_updated number;
    begin
        update grade_group
           set subject_id  = p_subject_id,
               teacher_id  = p_teacher_id,
               grade_group_date = p_grade_group_date,
               name        = p_name,
               description = p_description
         where grade_group_id = p_grade_group_id
         returning 1 into v_updated;
        dbms_output.put_line('Grade group updated: ID ' || p_grade_group_id);
        commit;
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20204,
                'Grade group with this name and date already exists for subject ID ' || p_subject_id || ', teacher ID ' || p_teacher_id
            );
        when VALUE_ERROR then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20205,
                'Type or length error when updating grade group: ID ' || p_grade_group_id
            );
        when NO_DATA_FOUND then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20206,
                'No grade group found with ID ' || p_grade_group_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20207,
                'Unexpected error when updating grade group: ID ' || p_grade_group_id || '. Error: ' || SQLERRM
            );
    end update_grade_group;

    procedure delete_grade_group (
        p_grade_group_id in number
    ) as
        v_deleted number;
    begin
        delete from grade_group
         where grade_group_id = p_grade_group_id
         returning 1 into v_deleted;
        dbms_output.put_line('Grade group deleted: ID ' || p_grade_group_id);
        commit;
    exception
        when NO_DATA_FOUND then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20208,
                'No grade group found with ID ' || p_grade_group_id
            );
        when OTHERS then
            rollback;
            RAISE_APPLICATION_ERROR(
                -20209,
                'Unexpected error when deleting grade group: ID ' || p_grade_group_id || '. Error: ' || SQLERRM
            );
    end delete_grade_group;

    function get_grade_group_by_id (
        p_grade_group_id in number
    ) return grade_group_rec
    as
        v_rec grade_group_rec;
    begin
        select grade_group_id,
               subject_id,
               teacher_id,
               grade_group_date,
               name,
               description
          into v_rec
          from grade_group
         where grade_group_id = p_grade_group_id;

        return v_rec;
    exception
        when NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(
                -20210,
                'No grade group found with ID ' || p_grade_group_id
            );
        when TOO_MANY_ROWS then
            RAISE_APPLICATION_ERROR(
                -20211,
                'Multiple grade groups found with ID ' || p_grade_group_id
            );
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20212,
                'Unexpected error when reading grade group: ID ' || p_grade_group_id || '. Error: ' || SQLERRM
            );
    end get_grade_group_by_id;

    function get_average_grade (
        p_grade_group_id in number
    ) return number
    as 
        v_avg_grade number;
    begin
        select avg(ggs.grade)
          into v_avg_grade
          from grade_group_student ggs
         where ggs.grade_group_id = p_grade_group_id;
        return v_avg_grade;
    exception
        when NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(
                -20213,
                'No grades found for grade group ID ' || p_grade_group_id
            );
        when TOO_MANY_ROWS then
            RAISE_APPLICATION_ERROR(
                -20214,
                'Multiple average grades found for grade group ID ' || p_grade_group_id
            );
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20215,
                'Unexpected error when reading average grade: grade group ID ' || p_grade_group_id || '. Error: ' || SQLERRM
            );
    end get_average_grade;

    function get_most_common_grade (
        p_grade_group_id in number
    ) return number
    as
        v_most_common_grade number;
    begin
        select ggs.grade
          into v_most_common_grade
          from grade_group_student ggs
         where ggs.grade_group_id = p_grade_group_id
         group by ggs.grade
         order by count(*) desc
         fetch first row only;
        return v_most_common_grade;
    exception
        when NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(
                -20216,
                'No grades found for grade group ID ' || p_grade_group_id
            );
        when TOO_MANY_ROWS then
            RAISE_APPLICATION_ERROR(
                -20217,
                'Multiple most common grades found for grade group ID ' || p_grade_group_id
            );
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20218,
                'Unexpected error when reading most common grade: grade group ID ' || p_grade_group_id || '. Error: ' || SQLERRM
            );
    end get_most_common_grade;

    function get_median_grade (
        p_grade_group_id in number
    ) return number
    as
        v_median_grade number;
    begin
        select median(ggs.grade)
          into v_median_grade
          from grade_group_student ggs
         where ggs.grade_group_id = p_grade_group_id;
        return v_median_grade;
    exception
        when NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(
                -20219,
                'No grades found for grade group ID ' || p_grade_group_id
            );
        when TOO_MANY_ROWS then
            RAISE_APPLICATION_ERROR(
                -20220,
                'Multiple median grades found for grade group ID ' || p_grade_group_id
            );
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20221,
                'Unexpected error when reading median grade: grade group ID ' || p_grade_group_id || '. Error: ' || SQLERRM
            );
    end get_median_grade;

    function get_grade_group_id_by_natural_key (
        p_subject_id in number,
        p_teacher_id in number,
        p_grade_group_date in timestamp,
        p_name in varchar2
    ) return number as
        v_grade_group_id number;
    begin
        select grade_group_id
          into v_grade_group_id
          from grade_group
         where subject_id = p_subject_id
           and teacher_id = p_teacher_id
           and grade_group_date = p_grade_group_date
           and name = p_name;

        return v_grade_group_id;
    exception
        when NO_DATA_FOUND then
            return null;
        when OTHERS then
            RAISE_APPLICATION_ERROR(
                -20222,
                'Error when getting grade group ID by natural key: subject_id=' || p_subject_id || 
                ', teacher_id=' || p_teacher_id || ', date=' || p_grade_group_date || 
                ', name=' || p_name || '. Error: ' || SQLERRM
            );
    end get_grade_group_id_by_natural_key;

end pkg_grade_group;
/
