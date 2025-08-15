-- Drop all triggers
DROP TRIGGER trg_parent_biur;
DROP TRIGGER trg_student_biur;
DROP TRIGGER trg_teacher_biur;

-- Drop all packages
DROP PACKAGE pkg_class;
DROP PACKAGE pkg_classroom;
DROP PACKAGE pkg_grade;
DROP PACKAGE pkg_lecture;
DROP PACKAGE pkg_parent;
DROP PACKAGE pkg_student_parent;
DROP PACKAGE pkg_student_subject;
DROP PACKAGE pkg_student;
DROP PACKAGE pkg_subject;
DROP PACKAGE pkg_subject_teacher;
DROP PACKAGE pkg_teacher;

-- Drop all tables
DROP TABLE Grade CASCADE CONSTRAINTS;
DROP TABLE Lecture CASCADE CONSTRAINTS;
DROP TABLE Student CASCADE CONSTRAINTS;
DROP TABLE Parent CASCADE CONSTRAINTS;
DROP TABLE Teacher CASCADE CONSTRAINTS;
DROP TABLE Subject CASCADE CONSTRAINTS;
DROP TABLE Class CASCADE CONSTRAINTS;
DROP TABLE Classroom CASCADE CONSTRAINTS;
DROP TABLE Student_Parent CASCADE CONSTRAINTS;
DROP TABLE Student_Subject CASCADE CONSTRAINTS;
DROP TABLE Subject_Teacher CASCADE CONSTRAINTS;

-- Drop all sequences
DROP SEQUENCE seq_class_id;
DROP SEQUENCE seq_classroom_id;
DROP SEQUENCE seq_grade_id;
DROP SEQUENCE seq_lecture_id;
DROP SEQUENCE seq_parent_id;
DROP SEQUENCE seq_student_id;
DROP SEQUENCE seq_subject_id;
DROP SEQUENCE seq_teacher_id;

BEGIN
	dbms_output.put_line('Schema deleted successfully.');
END;
/

