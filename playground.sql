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

  select * from vw_student_lectures where student_id = 1;
  select * from vw_teacher_lectures where teacher_id = 1;



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

-- GRADE GROUP STATS EXAMPLE
declare
begin
DBMS_OUTPUT.PUT_LINE(PKG_GRADE_GROUP.GET_AVERAGE_GRADE(1));
DBMS_OUTPUT.PUT_LINE(PKG_GRADE_GROUP.GET_MOST_COMMON_GRADE(1));
DBMS_OUTPUT.PUT_LINE(PKG_GRADE_GROUP.GET_MEDIAN_GRADE(1));
end;

-- STUDENT SUBJECT STATS EXAMPLE
  declare
  BEGIN
    DBMS_OUTPUT.PUT_LINE(PKG_SUBJECT.GET_STUDENT_AVERAGE_GRADE(1, 1));
    DBMS_OUTPUT.PUT_LINE(PKG_SUBJECT.GET_STUDENT_MOST_COMMON_GRADE(1, 1));
    DBMS_OUTPUT.PUT_LINE(PKG_SUBJECT.GET_STUDENT_MEDIAN_GRADE(1, 1));
  end;
  /

-- SUBJECT STATS EXAMPLE
declare
BEGIN
  DBMS_OUTPUT.PUT_LINE(PKG_SUBJECT.GET_SUBJECT_AVERAGE_GRADE(1));
  DBMS_OUTPUT.PUT_LINE(PKG_SUBJECT.GET_SUBJECT_MOST_COMMON_GRADE(1));
  DBMS_OUTPUT.PUT_LINE(PKG_SUBJECT.GET_SUBJECT_MEDIAN_GRADE(1));
end;

/

INSERT INTO Grade_Group (subject_id, teacher_id, name, description ) VALUES (4, 1, 'Espana', 'Madrid');
INSERT INTO Grade_Group_Student (grade_group_id, student_id, grade) VALUES (2, 1, 1);
COMMIT;

insert into class_group_student (class_group_id, student_id) values (3, 1);
commit;