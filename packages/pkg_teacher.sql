/*
   File: pkg_teacher.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Teacher table.
   Notes:
     - Uses auto-incrementing identity columns for primary keys.
     - Includes procedures: add, update, delete, get by ID.
*/

-- Package specification
CREATE OR REPLACE PACKAGE pkg_teacher AS

    /*
       Adds a new teacher to the Teacher table.
       Parameters:
         p_first_name - first name of the teacher
         p_last_name  - last name of the teacher
         p_email      - email of the teacher (must be unique)
         p_password   - password for the teacher
    */
    PROCEDURE add_teacher(
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2,
        p_password   IN VARCHAR2
    );

    /*
       Updates an existing teacher in the Teacher table.
       Parameters:
         p_teacher_id - ID of the teacher to update
         p_first_name - new first name
         p_last_name  - new last name
         p_email      - new email
         p_password   - new password
    */
    PROCEDURE update_teacher(
        p_teacher_id IN NUMBER,
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2,
        p_password   IN VARCHAR2
    );

    /*
       Deletes a teacher from the Teacher table.
       Parameters:
         p_teacher_id - ID of the teacher to delete
    */
    PROCEDURE delete_teacher(
        p_teacher_id IN NUMBER
    );

    /*
       Type for return value of get_teacher_by_id function.
    */
    TYPE teacher_rec IS RECORD (
        teacher_id  NUMBER,
        first_name  VARCHAR2(100),
        last_name   VARCHAR2(100),
        email       VARCHAR2(100),
        password    VARCHAR2(256)
    );

    /*
       Returns teacher details by ID.
       Parameters:
         p_teacher_id - ID of the teacher
       Returns:
         teacher_rec with teacher details, or NULL if not found.
    */
    FUNCTION get_teacher_by_id(
        p_teacher_id IN NUMBER
    ) RETURN teacher_rec;

END pkg_teacher;
/

-- Package body
CREATE OR REPLACE PACKAGE BODY pkg_teacher AS

    PROCEDURE add_teacher(
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2,
        p_password   IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Teacher (
            first_name,
            last_name,
            email,
            password
        ) VALUES (
            p_first_name,
            p_last_name,
            p_email,
            p_password
        );

        DBMS_OUTPUT.PUT_LINE('Teacher added: ' || p_first_name || ' ' || p_last_name);
    END add_teacher;

    PROCEDURE update_teacher(
        p_teacher_id IN NUMBER,
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2,
        p_password   IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Teacher
        SET first_name = p_first_name,
            last_name  = p_last_name,
            email      = p_email,
            password   = p_password
        WHERE teacher_id = p_teacher_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No teacher found with ID ' || p_teacher_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Teacher updated: ID ' || p_teacher_id);
        END IF;

    END update_teacher;

    PROCEDURE delete_teacher(
        p_teacher_id IN NUMBER
    ) IS
    BEGIN
        DELETE FROM Teacher
        WHERE teacher_id = p_teacher_id;
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No teacher found with ID ' || p_teacher_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Teacher deleted: ID ' || p_teacher_id);
        END IF;
    END delete_teacher;

    FUNCTION get_teacher_by_id(
        p_teacher_id IN NUMBER
    ) RETURN teacher_rec
    IS
        v_teacher teacher_rec;
    BEGIN
        SELECT teacher_id,
               first_name,
               last_name,
               email,
               password
        INTO v_teacher
        FROM Teacher
        WHERE teacher_id = p_teacher_id;

        RETURN v_teacher;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END get_teacher_by_id;

END pkg_teacher;