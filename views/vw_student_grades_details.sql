/*
   File: vw_student_grades_details.sql
   Author: David Válek
   Created: 2025-08-19
   Description: Displays each student's grades, average grade and grade count per each student's subject if the student has some grades in the subject.
*/
CREATE OR REPLACE VIEW vw_student_grades_details AS
SELECT 
    p.first_name || ' ' || p.last_name AS full_name,
    sub.name AS subject_name,
    gg.name AS grade_group_name,
    gg.grade_group_date AS grade_group_date,
    gg.description AS grade_description,
    ggs.grade AS grade,
    ggs.message AS grade_message,
    ggs.grade_date AS grade_date
FROM student s
JOIN person p ON s.person_id = p.person_id
JOIN grade_group_student ggs ON s.student_id = ggs.student_id
JOIN grade_group gg ON ggs.grade_group_id = gg.grade_group_id
JOIN subject sub ON gg.subject_id = sub.subject_id