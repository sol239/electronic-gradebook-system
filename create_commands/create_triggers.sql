/*
   File: create_triggers.sql
   Author: David Válek
   Description: Creates all triggers.
   Created: 2025-08-15
   TODO when running this script from here, and not from ~/create_schema.sql, there should be ../ at the beginning of each path
*/

@triggers/trg_parent_biur.sql
@triggers/trg_student_biur.sql
@triggers/trg_teacher_biur.sql