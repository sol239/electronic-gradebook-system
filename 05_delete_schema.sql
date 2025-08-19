-- Drop all triggers
-- drop trigger trg_person_biur;
drop trigger trg_grade_group_biu;
drop trigger trg_grade_group_student_biu;
drop trigger trg_class_group_student_biu;

-- Drop all views
drop view vw_class;
drop view vw_teacher_subjects;
drop view vw_class_students;
drop view vw_students_parents;
drop view vw_student_grades_summary;

-- Drop all packages
drop package pkg_class;
drop package pkg_class_group;
drop package pkg_class_group_student;
drop package pkg_classroom;
drop package pkg_grade_group;
drop package pkg_grade_group_student;
drop package pkg_lecture;
drop package pkg_parent;
drop package pkg_student_parent;
drop package pkg_student_subject;
drop package pkg_student;
drop package pkg_subject;
drop package pkg_subject_teacher;
drop package pkg_teacher;
drop package pkg_classroom_lecture;
drop package pkg_utils;
drop package pkg_person;

-- Drop all tables
drop table grade_group cascade constraints;
drop table grade_group_student cascade constraints;
drop table lecture cascade constraints;
drop table student cascade constraints;
drop table parent cascade constraints;
drop table teacher cascade constraints;
drop table subject cascade constraints;
drop table class cascade constraints;
drop table class_group cascade constraints;
drop table class_group_student cascade constraints;
drop table classroom cascade constraints;
drop table student_parent cascade constraints;
drop table student_subject cascade constraints;
drop table subject_teacher cascade constraints;
drop table lecture_teacher cascade constraints;
drop table lecture_student cascade constraints;
drop table classroom_lecture cascade constraints;
drop table person cascade constraints;

-- Drop all sequences
drop sequence seq_class_id;
drop sequence seq_classroom_id;
drop sequence seq_grade_id;
drop sequence seq_lecture_id;
drop sequence seq_parent_id;
drop sequence seq_student_id;
drop sequence seq_subject_id;
drop sequence seq_teacher_id;

begin
   dbms_output.put_line('Schema deleted successfully.');
end;
/