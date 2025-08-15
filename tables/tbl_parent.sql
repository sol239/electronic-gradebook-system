/*
   File: tbl_parent.sql
   Author: David Válek
   Description: Table definition for Parent
   Created: 2025-08-15
*/
CREATE TABLE Parent (
    parent_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE
);
