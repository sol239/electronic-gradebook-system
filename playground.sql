select *
  from vw_class
 order by class_id;

SELECT student_id,
       LISTAGG(grade, ', ') WITHIN GROUP (ORDER BY grade) AS grades
FROM vw_student_grade
GROUP BY student_id
ORDER BY student_id;