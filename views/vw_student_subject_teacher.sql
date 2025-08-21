/*
   File: vw_student_subject_teacher.sql
   Author: David Válek
   Created: 2025-08-21
   Description: Displays student's subjects and teachers.
*/
CREATE OR REPLACE VIEW vw_student_subject_teacher AS
SELECT 
    s_person.first_name || ' ' || s_person.last_name AS student_name,
    subj.subject_name,
    t_person.first_name || ' ' || t_person.last_name AS teacher_name
FROM student_subject_teacher sst
JOIN student s ON sst.student_id = s.student_id
JOIN person s_person ON s.person_id = s_person.person_id
JOIN subject subj ON sst.subject_id = subj.subject_id
JOIN teacher t ON sst.teacher_id = t.teacher_id
JOIN person t_person ON t.person_id = t_person.person_id
ORDER BY 
    s_person.last_name,
    s_person.first_name,
    subj.subject_name,
    t_person.last_name,
    t_person.first_name;