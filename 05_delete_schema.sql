/*
    File: 05_delete_schema.sql
    Author: David Válek
    Created: 2025-08-15
    Description: Script for deleting the schema.
*/

-- Drop all indexes
drop index idx_student_person_id;
drop index idx_student_class_id;
drop index idx_teacher_person_id;
drop index idx_class_teacher_id;
drop index idx_parent_person_id;
drop index idx_grade_group_subject_id;
drop index idx_grade_group_teacher_id;
drop index idx_lecture_subject_id;
drop index idx_lecture_classroom_id;
drop index idx_class_group_class_id;
drop index idx_lecture_student_lecture_id;
drop index idx_lecture_student_student_id;
drop index idx_lecture_teacher_lecture_id;
drop index idx_lecture_teacher_teacher_id;
drop index idx_classroom_lecture_classroom_id;
drop index idx_classroom_lecture_lecture_id;
drop index idx_subject_teacher_subject_id;
drop index idx_subject_teacher_teacher_id;
drop index idx_student_subject_student_id;
drop index idx_student_subject_subject_id;
drop index idx_student_parent_student_id;
drop index idx_student_parent_parent_id;
drop index idx_grade_group_student_grade_group_id;
drop index idx_grade_group_student_student_id;
drop index idx_class_group_student_class_group_id;
drop index idx_class_group_student_student_id;
drop index idx_grade_group_grade_group_date;
drop index idx_lecture_start_time;
drop index idx_lecture_end_time;
drop index idx_grade_group_student_grade_date;
drop index idx_grade_group_student_student_date;
drop index idx_lecture_subject_time;
drop index idx_grade_group_subject_date;
drop index idx_student_class;
drop index idx_subject_teacher_teacher_subject;
drop index idx_grade_group_teacher_date;
drop index idx_lecture_classroom_time;
drop index idx_person_name;
drop index idx_class_name;
drop index idx_classroom_name;
drop index idx_grade_group_student_grade;
drop index idx_grade_group_student_message;

-- Drop all triggers
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

begin
   dbms_output.put_line('Schema deleted successfully.');
end;
/