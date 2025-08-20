-- =====================================
--                VIEWS
-- =====================================

-- Display all students, their emails, and class names
select *
  from vw_class_students;

-- Display all students in a specific class
select *
  from vw_class_students
 where class_name = 'Prima';

-- Display all classes - their name, teacher name and teacher email (teacher is a main teacher of the class = třídní učitel)
select *
  from vw_class;

-- Display all students and their grades details
select *
  from vw_student_grades_details;

-- Display specific test - grade group - grades
select *
  from vw_student_grades_details
 where grade_group_name = 'Diktát 1';

-- Display students and their grade summary - similar to Bakalari.cz grades summary page
select *
  from vw_student_grades_summary
 order by full_name,
          subject_name;

-- Display specific student's lectures - timetable, with WHERE clause for start_time/end_time it can be use
-- to create a timetable view for current/next/past weeks
select *
  from vw_student_lectures
 where student_id = 1;

-- Display specific teacher's lectures - timetable, with WHERE clause for start_time/end_time it can be use
-- to create a timetable view for current/next/past weeks
select *
  from vw_teacher_lectures
 where teacher_id = 1;

-- Display students and their parents
select *
  from vw_students_parents;

-- Display all teachers and subjects they teach
select *
  from vw_teacher_subjects
 order by teacher_name,
          subject_name;

-- =====================================
--      PROCEDURES & FUNCTIONS
-- =====================================

-- Package: pkg_utils
-- 1) Login example
declare
   login_resp pkg_person.response;
begin 
   -- Correct password example
   login_resp := pkg_person.login_person(
      'zdeněk.veselý22@gmail.com',
      'hashed_password_p1'
   );
   dbms_output.put_line('Success: '
                        || case
      when login_resp.success then
         'TRUE'
      else 'FALSE'
   end);
   dbms_output.put_line('Message: ' || login_resp.message);

   -- Incorrect password example
   login_resp := pkg_person.login_person(
      'zdeněk.veselý22@gmail.com',
      'wrong_password'
   );
   dbms_output.put_line('Success: '
                        || case
      when login_resp.success then
         'TRUE'
      else 'FALSE'
   end);
   dbms_output.put_line('Message: ' || login_resp.message);
end;
/

-- 2) Admin password reset example -> old password is not needed
declare
   v_user_id number;
begin
   v_user_id := pkg_person.get_person_id_by_email('zdeněk.veselý22@gmail.com');
   dbms_output.put_line('User ID: ' || v_user_id);
   pkg_person.password_reset(
      v_user_id,
      'new_password'
   );
end;
/

-- 3) User password reset example
declare
   login_resp pkg_person.response;
begin
   login_resp := pkg_person.user_password_reset(
      'zdeněk.veselý22@gmail.com',
      'new_password',
      'password111'
   );
   dbms_output.put_line('Success: '
                        || case
      when login_resp.success then
         'TRUE'
      else 'FALSE'
   end);
   dbms_output.put_line('Message: ' || login_resp.message);
end;
/

-- 4) Login example to check that the new password works
declare
   login_resp pkg_person.response;
begin
   login_resp := pkg_person.login_person(
      'zdeněk.veselý22@gmail.com',
      'password111'
   );
   dbms_output.put_line('Success: '
                        || case
      when login_resp.success then
         'TRUE'
      else 'FALSE'
   end);
   dbms_output.put_line('Message: ' || login_resp.message);
end;
/

-- Package: pkg_grade_group
-- 1) Example to show statistics of a grade group (ef. of some quiz or test)
declare
   v_grade_group_id number;
begin
   v_grade_group_id := 1;
   dbms_output.put_line('Grade group name: ' || pkg_grade_group.get_grade_group_name_by_id(v_grade_group_id));
   dbms_output.put_line(' * Average grade: ' || pkg_grade_group.get_average_grade(v_grade_group_id));
   dbms_output.put_line(' * Most common grade: ' || pkg_grade_group.get_most_common_grade(v_grade_group_id));
   dbms_output.put_line(' * Median grade: ' || pkg_grade_group.get_median_grade(v_grade_group_id));
end;

-- Package: pkg_subject
-- 1) Example to show statistics of a student in a specific subject
declare
   v_student_id number;
   v_subject_id number;
begin
   v_student_id := 1;
   v_subject_id := 1;
   dbms_output.put_line('Student name: ' || pkg_student.get_student_full_name_by_id(v_student_id));
   dbms_output.put_line('Subject name: ' || pkg_subject.get_subject_name_by_id(v_subject_id));
   dbms_output.put_line(' * Average grade: '
                        || pkg_subject.get_student_average_grade(
      v_student_id,
      v_subject_id
   ));
   dbms_output.put_line(' * Most common grade: '
                        || pkg_subject.get_student_most_common_grade(
      v_student_id,
      v_subject_id
   ));
   dbms_output.put_line(' * Median grade: '
                        || pkg_subject.get_student_median_grade(
      v_student_id,
      v_subject_id
   ));
end;
/

-- 2) General statistics of a subject
declare begin
   dbms_output.put_line('Subject name: ' || pkg_subject.get_subject_name_by_id(1));
   dbms_output.put_line(' * Average grade: ' || pkg_subject.get_subject_average_grade(1));
   dbms_output.put_line(' * Most common grade: ' || pkg_subject.get_subject_most_common_grade(1));
   dbms_output.put_line(' * Median grade: ' || pkg_subject.get_subject_median_grade(1));
end;
/

-- =====================================
--                TRIGGERS
-- =====================================

-- Test of trg_class_group_student_biu -> insert student into class group which does not belong to student's class
-- It will raise exception because class_group:3 belongs to class:2 but student:1 is in class:1
declare
   v_student_id number;
   v_class_group_id number;
begin
   v_student_id := 1;
   v_class_group_id := 3;

   dbms_output.put_line('Inserting student ID: ' || pkg_student.get_student_full_name_by_id(v_student_id) || ' into class group ID: ' || pkg_class_group.GET_CLASS_GROUP_NAME_BY_ID(v_class_group_id));

   insert into class_group_student (
      class_group_id,
      student_id
   ) values ( v_class_group_id,
              v_student_id );
   commit;
end;
/