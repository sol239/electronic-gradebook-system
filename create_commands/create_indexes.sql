/*
   File: create_indexes.sql
   Author: David Válek
   Created: 2025-08-19
   Description: Creates comprehensive indexes for foreign keys, date columns, and common query patterns
   Notes:
     - Foreign key indexes improve JOIN performance
     - Date column indexes improve WHERE clause performance on date/time filters
     - Composite indexes optimize common query patterns from views and packages
     - All indexes follow naming convention: idx_<table_name>_<column_names>
     - Note: Some columns are already indexed by unique constraints (subject.name, class.name, etc.)
*/

-- =====================================================
-- FOREIGN KEY INDEXES (32 indexes)
-- =====================================================

-- Student table foreign key indexes
CREATE INDEX idx_student_person_id ON student(person_id);
CREATE INDEX idx_student_class_id ON student(class_id);

-- Teacher table foreign key indexes
CREATE INDEX idx_teacher_person_id ON teacher(person_id);

-- Class table foreign key indexes
CREATE INDEX idx_class_teacher_id ON class(teacher_id);

-- Parent table foreign key indexes
CREATE INDEX idx_parent_person_id ON parent(person_id);

-- Grade Group table foreign key indexes
CREATE INDEX idx_grade_group_subject_id ON grade_group(subject_id);
CREATE INDEX idx_grade_group_teacher_id ON grade_group(teacher_id);

-- Lecture table foreign key indexes
CREATE INDEX idx_lecture_subject_id ON lecture(subject_id);
CREATE INDEX idx_lecture_classroom_id ON lecture(classroom_id);

-- Class Group table foreign key indexes
CREATE INDEX idx_class_group_class_id ON class_group(class_id);

-- Lecture Student table foreign key indexes
CREATE INDEX idx_lecture_student_lecture_id ON lecture_student(lecture_id);
CREATE INDEX idx_lecture_student_student_id ON lecture_student(student_id);

-- Lecture Teacher table foreign key indexes
CREATE INDEX idx_lecture_teacher_lecture_id ON lecture_teacher(lecture_id);
CREATE INDEX idx_lecture_teacher_teacher_id ON lecture_teacher(teacher_id);

-- Classroom Lecture table foreign key indexes
CREATE INDEX idx_classroom_lecture_classroom_id ON classroom_lecture(classroom_id);
CREATE INDEX idx_classroom_lecture_lecture_id ON classroom_lecture(lecture_id);

-- Subject Teacher table foreign key indexes
CREATE INDEX idx_subject_teacher_subject_id ON subject_teacher(subject_id);
CREATE INDEX idx_subject_teacher_teacher_id ON subject_teacher(teacher_id);

-- Student Subject table foreign key indexes
CREATE INDEX idx_student_subject_student_id ON student_subject(student_id);
CREATE INDEX idx_student_subject_subject_id ON student_subject(subject_id);

-- Student Parent table foreign key indexes
CREATE INDEX idx_student_parent_student_id ON student_parent(student_id);
CREATE INDEX idx_student_parent_parent_id ON student_parent(parent_id);

-- Grade Group Student table foreign key indexes
CREATE INDEX idx_grade_group_student_grade_group_id ON grade_group_student(grade_group_id);
CREATE INDEX idx_grade_group_student_student_id ON grade_group_student(student_id);

-- Class Group Student table foreign key indexes
CREATE INDEX idx_class_group_student_class_group_id ON class_group_student(class_group_id);
CREATE INDEX idx_class_group_student_student_id ON class_group_student(student_id);

-- =====================================================
-- DATE COLUMN INDEXES (4 indexes)
-- =====================================================

-- Grade Group table date indexes
CREATE INDEX idx_grade_group_grade_group_date ON grade_group(grade_group_date);

-- Lecture table date indexes
CREATE INDEX idx_lecture_start_time ON lecture(start_time);
CREATE INDEX idx_lecture_end_time ON lecture(end_time);

-- Grade Group Student table date indexes
CREATE INDEX idx_grade_group_student_grade_date ON grade_group_student(grade_date);

-- =====================================================
-- COMPOSITE INDEXES FOR COMMON QUERY PATTERNS (7 indexes)
-- =====================================================

-- Composite index for grade queries by student and date range (from vw_student_grades_details)
CREATE INDEX idx_grade_group_student_student_date ON grade_group_student(student_id, grade_date);

-- Composite index for lecture queries by subject and time range (from vw_student_lectures, vw_teacher_lectures)
CREATE INDEX idx_lecture_subject_time ON lecture(subject_id, start_time, end_time);

-- Composite index for grade group queries by subject and date (from vw_student_grades_summary)
CREATE INDEX idx_grade_group_subject_date ON grade_group(subject_id, grade_group_date);

-- Composite index for student queries by class (from vw_class_students)
CREATE INDEX idx_student_class ON student(class_id, student_id);

-- Composite index for teacher-subject relationships (from vw_teacher_subjects)
CREATE INDEX idx_subject_teacher_teacher_subject ON subject_teacher(teacher_id, subject_id);

-- Composite index for grade group queries by teacher and date
CREATE INDEX idx_grade_group_teacher_date ON grade_group(teacher_id, grade_group_date);

-- Composite index for lecture queries by classroom and time
CREATE INDEX idx_lecture_classroom_time ON lecture(classroom_id, start_time, end_time);

-- =====================================================
-- ADDITIONAL PERFORMANCE INDEXES (4 indexes)
-- =====================================================

-- Index for person name lookups (common in views)
CREATE INDEX idx_person_name ON person(last_name, first_name);

-- Index for grade filtering (common in grade statistics)
CREATE INDEX idx_grade_group_student_grade ON grade_group_student(grade);

-- Index for message filtering (common in grade queries)
CREATE INDEX idx_grade_group_student_message ON grade_group_student(message);
