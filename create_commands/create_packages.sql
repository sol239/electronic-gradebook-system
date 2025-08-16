/*
   File: create_packages.sql
   Author: David Válek
   Description: Creates all packages.
   Created: 2025-08-15
   TODO when running this script from here, and not from ~/create_schema.sql, there should be ../ at the beginning of each path
*/
@packages/pkg_utils.sql
@packages/pkg_class.sql
@packages/pkg_classroom.sql
@packages/pkg_grade.sql
@packages/pkg_lecture.sql
@packages/pkg_parent.sql
@packages/pkg_student_parent.sql
@packages/pkg_student_subject.sql
@packages/pkg_student.sql
@packages/pkg_subject_teacher.sql
@packages/pkg_subject.sql
@packages/pkg_teacher.sql
@packages/pkg_classroom_lecture.sql