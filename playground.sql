   SET SERVEROUTPUT ON;

select *
  from vw_student_grades_summary
 order by full_name,
          subject_name;

select *
  from vw_class;

select *
  from vw_class_students
 where class_name = 'Prima';

select *
  from vw_teacher_subjects
 order by teacher_name,
          subject_name;

select *
  from vw_students_parents;

select *
  from student_parent;

  select * from vw_student_grades_details;

-- LOGIN EXAMPLE
declare
   login_resp pkg_person.response;
   v_user_id  number;
begin 

    /*
    -- ADMIN PASSWORD RESET EXAMPLE
   v_user_id := pkg_person.get_person_id_by_email('zdeněk.veselý22@gmail.com');
   dbms_output.put_line('User ID: ' || v_user_id);
   pkg_person.password_reset(v_user_id, 'passwordWQE');
    */ 
    
    /*
    -- USER PASSWORD RESET EXAMPLE
    login_resp := pkg_person.USER_PASSWORD_RESET('zdeněk.veselý22@gmail.com', 'password', 'password111');
    DBMS_OUTPUT.PUT_LINE('Success: ' || CASE WHEN login_resp.success THEN 'TRUE' ELSE 'FALSE' END);
    DBMS_OUTPUT.PUT_LINE('Message: ' || login_resp.message);
    */

    -- USER LOGIN EXAMPLE
    login_resp := pkg_person.LOGIN_PERSON('zdeněk.veselý22@gmail.com', 'password111');
    DBMS_OUTPUT.PUT_LINE('Success: ' || CASE WHEN login_resp.success THEN 'TRUE' ELSE 'FALSE' END);
    DBMS_OUTPUT.PUT_LINE('Message: ' || login_resp.message);
    
    
end;





/