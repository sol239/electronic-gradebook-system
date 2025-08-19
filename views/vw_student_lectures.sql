/*
   File: vw_student_lectures.sql
   Author: David Válek
   Created: 2025-08-19
   Description: Displays student's lectures.
*/
CREATE OR REPLACE VIEW vw_student_lectures AS
SELECT
    s.student_id,
    l.lecture_id,
    l.lecture_name AS lecture_name,
    l.start_time AS start_time,
    l.end_time AS end_time
FROM student s
JOIN LECTURE_STUDENT ls ON s.student_id = ls.student_id
JOIN lecture l ON ls.lecture_id = l.lecture_id
ORDER BY s.student_id, l.start_time;
