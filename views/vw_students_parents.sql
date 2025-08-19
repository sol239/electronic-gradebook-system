/*
   File: vw_students_parents.sql
   Author: David Válek
   Created: 2025-08-19
   Description: Displays parents and students associated to them.
*/
CREATE OR REPLACE VIEW vw_students_parents AS
SELECT
    s_person.first_name || ' ' || s_person.last_name AS student_name,
    s.student_id,
    p_person.first_name || ' ' || p_person.last_name AS parent_name,
    p.PARENT_ID
FROM student s
JOIN person s_person ON s.person_id = s_person.person_id  -- student info
JOIN student_parent sp ON s.student_id = sp.student_id
JOIN parent p ON sp.parent_id = p.parent_id
JOIN person p_person ON p.person_id = p_person.person_id
ORDER BY s.student_id; -- parent info
