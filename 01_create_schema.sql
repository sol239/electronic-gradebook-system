/*
   File: create_schema.sql
   Author: David Válek
   Description: Creates entire schema.
   Created: 2025-08-15
*/

/* 
Project assignment url: https://www.ms.mff.cuni.cz/~kopecky/vyuka/dbapl/

Electronic gradebook system

This project is designed to create an electronic gradebook system for primary and secondary schools using **Oracle SQL**. 
The system aims to manage student records, grades, schedules, and other related functionalities. It is supposed to work
similarly as https://www.skolaonline.cz/ or https://www.bakalari.cz/. These student information systems are huge and they
allow to store a large amount of data for students, teachers, etc. This application allows some basic school evidence.
Extending the schema is not difficult. Eg. adding personal number or phone number would be ideal. 

In assignment is stated that in script 1) should be object/procedure/function description. I put that description into the 
corresponding files represeting the objects. Eg. in tbl_lecture.sql you can find the description of the table lecture.

More information about the project can be found in the project documentation README.md.
*/


-- =====================================
--             Create Tables
-- =====================================

@tables/tbl_person.sql
@tables/tbl_parent.sql
@tables/tbl_teacher.sql
@tables/tbl_subject.sql
@tables/tbl_class.sql
@tables/tbl_class_group.sql
@tables/tbl_student.sql
@tables/tbl_class_group_student.sql
@tables/tbl_classroom.sql
@tables/tbl_lecture.sql
@tables/tbl_grade_group.sql
@tables/tbl_grade_group_student.sql
@tables/tbl_student_subject.sql
@tables/tbl_subject_teacher.sql
@tables/tbl_student_parent.sql
@tables/tbl_lecture_student.sql
@tables/tbl_lecture_teacher.sql
@tables/tbl_classroom_lecture.sql

-- =====================================
--             Create Packages
-- =====================================

@packages/pkg_utils.sql
@packages/pkg_class.sql
@packages/pkg_grade_group.sql
@packages/pkg_grade_group_student.sql
@packages/pkg_lecture.sql
@packages/pkg_person.sql
@packages/pkg_parent.sql
@packages/pkg_student_parent.sql
@packages/pkg_student_subject.sql
@packages/pkg_student.sql
@packages/pkg_class_group.sql
@packages/pkg_class_group_student.sql
@packages/pkg_subject_teacher.sql
@packages/pkg_subject.sql
@packages/pkg_teacher.sql
@packages/pkg_classroom_lecture.sql
@packages/pkg_classroom.sql

-- =====================================
--             Create Triggers
-- =====================================

@triggers/trg_grade_group_biu.sql
@triggers/trg_grade_group_student_biu.sql
@triggers/trg_class_group_student_biu.sql

-- =====================================
--             Create Views
-- =====================================

@views/vw_class.sql
@views/vw_class_students.sql
@views/vw_teacher_subjects.sql
@views/vw_students_parents.sql
@views/vw_student_grades_summary.sql

-- =====================================
--             Create Indexes
-- =====================================

-- There are many of indexes so they are created in a separate script
@create_commands/create_indexes.sql

BEGIN
	dbms_output.put_line('Schema creation process completed.');
END;
/

