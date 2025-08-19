/*
   File: create_views.sql
   Author: David Válek
   Description: Creates all views.
   Created: 2025-08-15
   TODO when running this script from here, and not from ~/create_schema.sql, there should be ../ at the beginning of each path
*/

@views/vw_class.sql
@views/vw_class_students.sql
@views/vw_teacher_subjects.sql
@views/vw_students_parents.sql
@views/vw_student_grades_summary.sql