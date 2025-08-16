/*
   File: vw_student_grade.sql
   Author: David Válek
   Created: 2025-08-15
   Modified: 2025-08-16 - Updated for normalized structure with Person table (no roles)
   Modified: 2025-08-16 - Added grade_date column support
   Description: View for displaying student average grades per subject.
*/
CREATE OR REPLACE VIEW vw_student_grade AS    
SELECT 
    p.first_name || ' ' || p.last_name AS full_name,
    sub.name AS subject_name,
    AVG(g.grade) AS average_grade,
    COUNT(*) AS grade_count,
    LISTAGG(g.grade, ', ') AS grades,
    MIN(g.grade_date) AS first_grade_date,
    MAX(g.grade_date) AS last_grade_date
FROM student s      
JOIN person p ON s.person_id = p.person_id      
JOIN grade g ON s.student_id = g.student_id      
JOIN subject sub ON g.subject_id = sub.subject_id
GROUP BY p.first_name || ' ' || p.last_name, sub.name;