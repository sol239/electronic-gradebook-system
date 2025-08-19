/*
   File: create_triggers.sql
   Author: David Válek
   Description: Creates all triggers.
   Created: 2025-08-15
   TODO when running this script from here, and not from ~/create_schema.sql, there should be ../ at the beginning of each path
*/

@triggers/trg_grade_group_biu.sql
@triggers/trg_grade_group_student_biu.sql
@triggers/trg_class_group_student_biu.sql