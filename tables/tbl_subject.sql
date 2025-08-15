/*
   File: tbl_subject.sql
   Author: David Válek
   Description: Table definition for Subject, which stores information about subjects
   Created: 2025-08-15
*/
create table subject (
   subject_id number primary key,
   name       varchar2(100) not null
);