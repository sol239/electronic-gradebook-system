/*
   File: create_tables.sql
   Author: David Válek
   Description: Creates all tables.
   Created: 2025-08-15
   TODO when running this script from here, and not from ~/create_schema.sql, there should be ../ at the beginning of each path
*/

@tables/tbl_parent.sql
@tables/tbl_teacher.sql
@tables/tbl_subject.sql
@tables/tbl_class.sql
@tables/tbl_student.sql
@tables/tbl_classroom.sql
@tables/tbl_lecture.sql
@tables/tbl_grade.sql
@tables/tbl_student_subject.sql
@tables/tbl_subject_teacher.sql
@tables/tbl_student_parent.sql
@tables/tbl_lecture_student.sql
@tables/tbl_lecture_teacher.sql
