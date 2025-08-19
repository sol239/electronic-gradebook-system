/*
   File: vw_student_grades_summary.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Displays each student's grades, average grade and grade count per each student's subject if the student has some grades in the subject.
*/
CREATE OR REPLACE VIEW vw_student_grades_summary AS
SELECT
    p.first_name || ' ' || p.last_name AS full_name,
    sub.name AS subject_name,
    AVG(ggs.grade) AS average_grade,
    COUNT(ggs.grade) AS grade_count,
    LISTAGG(ggs.grade, ', ') WITHIN GROUP (ORDER BY ggs.grade_date) AS grades
FROM student s
JOIN person p ON s.person_id = p.person_id
JOIN grade_group_student ggs ON s.student_id = ggs.student_id
JOIN grade_group gg ON ggs.grade_group_id = gg.grade_group_id
JOIN subject sub ON gg.subject_id = sub.subject_id
WHERE ggs.grade IS NOT NULL
GROUP BY p.first_name || ' ' || p.last_name, sub.name