/*
   File: pkg_teacher.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Teacher table.
   Notes:
     - Uses seq_teacher_id to auto-generate primary keys.
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
    */
    PROCEDURE add_teacher(
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2    
    );

    /*
       Updates an existing teacher in the Teacher table.
       Parameters:
         p_teacher_id - ID of the teacher to update
         p_first_name - new first name of the teacher
         p_last_name  - new last name of the teacher
         p_email      - new email of the teacher (must be unique)
    */
    PROCEDURE update_teacher(
        p_teacher_id IN NUMBER,
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2
    );

    PROCEDURE delete_teacher(
        p_teacher_id IN NUMBER
    );

    /*
       Retrieves a teacher by ID from the Teacher table.
       Parameters:
         p_teacher_id - ID of the teacher to retrieve
         p_first_name - first name of the teacher
         p_last_name  - last name of the teacher
         p_email      - email of the teacher
    */
    PROCEDURE get_teacher_by_id(
        p_teacher_id IN NUMBER,
        p_first_name OUT VARCHAR2,
        p_last_name  OUT VARCHAR2,
        p_email      OUT VARCHAR2
    );

END pkg_teacher;
/

-- Package body
CREATE OR REPLACE PACKAGE BODY pkg_teacher AS

    PROCEDURE add_teacher(
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Teacher (teacher_id, first_name, last_name, email)
        VALUES (seq_teacher_id.NEXTVAL, p_first_name, p_last_name, p_email);

        DBMS_OUTPUT.PUT_LINE('Teacher added: ' || p_first_name || ' ' || p_last_name);
    END add_teacher;

    PROCEDURE update_teacher(
        p_teacher_id IN NUMBER,
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Teacher
        SET first_name = p_first_name,
            last_name  = p_last_name,
            email      = p_email
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

    PROCEDURE get_teacher_by_id(
        p_teacher_id IN NUMBER,
        p_first_name OUT VARCHAR2,
        p_last_name  OUT VARCHAR2,
        p_email      OUT VARCHAR2
    ) IS
    BEGIN
        SELECT first_name, last_name, email
        INTO p_first_name, p_last_name, p_email
        FROM Teacher
        WHERE teacher_id = p_teacher_id;

        DBMS_OUTPUT.PUT_LINE('Teacher ID: ' || p_teacher_id);
        DBMS_OUTPUT.PUT_LINE('First Name: ' || p_first_name);
        DBMS_OUTPUT.PUT_LINE('Last Name: '  || p_last_name);
        DBMS_OUTPUT.PUT_LINE('Email: '      || p_email);

    END get_teacher_by_id;

END pkg_teacher;