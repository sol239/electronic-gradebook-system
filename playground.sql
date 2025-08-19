SET SERVEROUTPUT ON;

SELECT * FROM VW_STUDENT_GRADE ORDER BY full_name, subject_name;

SELECT * FROM VW_CLASS;

SELECT * FROM VW_CLASS_STUDENTS WHERE class_name = 'Prima';

select * from vw_teacher_subjects order by teacher_name, subject_name;

select * from vw_students_parents;

select * from STUDENT_PARENT;

-- LOGIN EXAMPLE
DECLARE
    login_resp pkg_person.response;
BEGIN
    -- Call the function and store the result
    login_resp := pkg_person.LOGIN_PERSON('zdeněk.veselý22@gmail.com', 'hashed_password_p1');

    -- Print each field separately
    DBMS_OUTPUT.PUT_LINE('Success: ' || CASE WHEN login_resp.success THEN 'TRUE' ELSE 'FALSE' END);
    DBMS_OUTPUT.PUT_LINE('Message: ' || login_resp.message);
END;
/