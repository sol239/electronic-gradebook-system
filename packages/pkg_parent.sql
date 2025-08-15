/*
   File: pkg_parent.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for CRUD operations on the Parent table.
   Notes:
     - Uses seq_parent_id to auto-generate primary keys.
     - Includes procedures: add, update, delete, get by ID.
*/

-- Package specification
CREATE OR REPLACE PACKAGE pkg_parent AS

    /*
       Adds a new parent to the Parent table.
       Parameters:
         p_first_name - first name of the parent
         p_last_name  - last name of the parent
         p_email      - email of the parent (must be unique)
    */
    PROCEDURE add_parent(
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2
    );

    /*
       Updates an existing parent in the Parent table.
       Parameters:
         p_parent_id  - ID of the parent to update
         p_first_name - new first name
         p_last_name  - new last name
         p_email      - new email
    */
    PROCEDURE update_parent(
        p_parent_id  IN NUMBER,
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2
    );

    /*
       Deletes a parent from the Parent table.
       Parameters:
         p_parent_id - ID of the parent to delete
    */
    PROCEDURE delete_parent(
        p_parent_id IN NUMBER
    );

    /*
       Retrieves and prints parent details by ID.
       Parameters:
         p_parent_id - ID of the parent to retrieve
       Output:
         Prints parent information via DBMS_OUTPUT
    */
    PROCEDURE get_parent_by_id(
        p_parent_id IN NUMBER
    );

END pkg_parent;
/

-- Package body
CREATE OR REPLACE PACKAGE BODY pkg_parent AS

    PROCEDURE add_parent(
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO Parent (parent_id, first_name, last_name, email)
        VALUES (seq_parent_id.NEXTVAL, p_first_name, p_last_name, p_email);

        DBMS_OUTPUT.PUT_LINE('Parent added: ' || p_first_name || ' ' || p_last_name);
    END add_parent;


    PROCEDURE update_parent(
        p_parent_id  IN NUMBER,
        p_first_name IN VARCHAR2,
        p_last_name  IN VARCHAR2,
        p_email      IN VARCHAR2
    ) AS
    BEGIN
        UPDATE Parent
        SET first_name = p_first_name,
            last_name  = p_last_name,
            email      = p_email
        WHERE parent_id = p_parent_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No parent found with ID ' || p_parent_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Parent updated: ID ' || p_parent_id);
        END IF;
    END update_parent;


    PROCEDURE delete_parent(
        p_parent_id IN NUMBER
    ) AS
    BEGIN
        DELETE FROM Parent
        WHERE parent_id = p_parent_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No parent found to delete with ID ' || p_parent_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Parent deleted: ID ' || p_parent_id);
        END IF;
    END delete_parent;


    PROCEDURE get_parent_by_id(
        p_parent_id IN NUMBER
    ) AS
        v_first_name Parent.first_name%TYPE;
        v_last_name  Parent.last_name%TYPE;
        v_email      Parent.email%TYPE;
    BEGIN
        SELECT first_name, last_name, email
        INTO   v_first_name, v_last_name, v_email
        FROM   Parent
        WHERE  parent_id = p_parent_id;

        DBMS_OUTPUT.PUT_LINE('Parent ID: ' || p_parent_id);
        DBMS_OUTPUT.PUT_LINE('First Name: ' || v_first_name);
        DBMS_OUTPUT.PUT_LINE('Last Name: '  || v_last_name);
        DBMS_OUTPUT.PUT_LINE('Email: '      || v_email);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Parent with ID ' || p_parent_id || ' not found.');
    END get_parent_by_id;

END pkg_parent;
/
