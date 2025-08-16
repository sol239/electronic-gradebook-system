/*
   File: vw_student_grade.sql
   Author: David Válek
   Created: 2025-08-15
   Description: View for displaying student grades. It shows the average grade per subject of each student.
*/
CREATE OR REPLACE VIEW vw_student_grade AS    
SELECT 
    p.first_name || ' ' || p.last_name AS full_name,
    sub.name AS subject_name,
    AVG(g.grade) AS average_grade,
    COUNT(*) AS grade_count,
    LISTAGG(g.grade, ', ') AS grades
FROM student s      
JOIN person p ON s.person_id = p.person_id      
JOIN grade g ON s.student_id = g.student_id      
JOIN subject sub ON g.subject_id = sub.subject_id
GROUP BY p.first_name || ' ' || p.last_name, sub.name