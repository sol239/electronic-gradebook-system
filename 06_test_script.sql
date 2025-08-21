/*
   File: 06_test_script.sql
   Author: David Válek
   Description: Script for testing database functionality.
   Created: 2025-08-19
*/

-- NOTE: At the end of the file are NON-CRUD operations

   SET SERVEROUTPUT ON;

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
 where student_id = 6;

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

select *
  from vw_student_subject_teacher;


/*
TODO:
      Add Fix Errors in 06 30MIN
      Final assignment check 5MINd
      Submit 5MIN
*/


-- =====================================
--      PROCEDURES & FUNCTIONS
-- =====================================

-- =====================================
--       Package: pkg_person
-- =====================================

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

-- 5) Test person CRUD operations
declare
   v_person_id number;
   v_person    pkg_person.person_rec;
begin
   -- Create new person
   v_person_id := pkg_person.add_person(
      'Test',
      'User',
      'test.user@example.com',
      'hashed_password',
      'salt123'
   );
   dbms_output.put_line('New person created with ID: ' || v_person_id);
   
   -- Read person
   v_person := pkg_person.get_person_by_id(v_person_id);
   dbms_output.put_line('Person details: '
                        || v_person.first_name
                        || ' '
                        || v_person.last_name);
   
   -- Update person
   pkg_person.update_person(
      v_person_id,
      'Updated',
      'User',
      'updated.user@example.com',
      'new_hashed_password',
      'new_salt'
   );
   dbms_output.put_line('Person updated successfully');
   
   -- Delete person (cleanup)
   pkg_person.delete_person(v_person_id);
   dbms_output.put_line('Person deleted successfully');
end;
/

-- =====================================
-- Package: pkg_student - CRUD Operations
-- =====================================

-- Test student CRUD operations
declare
   v_student_id number;
   v_student    pkg_student.student_rec;
begin
   -- Create new student
   v_student_id := pkg_student.add_student(
      'John',
      'Doe',
      'john.doe@example.com',
      'hashed_password',
      'salt123',
      1
   );
   dbms_output.put_line('New student created with ID: ' || v_student_id);
   
   -- Read student
   v_student := pkg_student.get_student_by_id(v_student_id);
   dbms_output.put_line('Student details: '
                        || v_student.first_name
                        || ' '
                        || v_student.last_name);
   
   -- Update student class
   pkg_student.update_student_class(
      v_student_id,
      2
   );
   dbms_output.put_line('Student class updated to class ID: 2');
   
   -- Update student person info
   pkg_student.update_student_person_info(
      v_student_id,
      'John',
      'Smith',
      'john.smith@example.com',
      'new_hashed_password',
      'new_salt'
   );
   dbms_output.put_line('Student person info updated');
   
   -- Get student full name
   dbms_output.put_line('Student full name: ' || pkg_student.get_student_full_name_by_id(v_student_id));
   
   -- Delete student (cleanup)
   pkg_student.delete_student(v_student_id);
   dbms_output.put_line('Student deleted successfully');
end;
/

-- =====================================
-- Package: pkg_teacher - CRUD Operations
-- =====================================

-- Test teacher CRUD operations
declare
   v_teacher_id number;
   v_teacher    pkg_teacher.teacher_rec;
begin
   -- Create new teacher
   v_teacher_id := pkg_teacher.add_teacher(
      'Jane',
      'Smith',
      'jane.smith@example.com',
      'hashed_password',
      'salt123'
   );
   dbms_output.put_line('New teacher created with ID: ' || v_teacher_id);
   
   -- Read teacher
   v_teacher := pkg_teacher.get_teacher_by_id(v_teacher_id);
   dbms_output.put_line('Teacher details: '
                        || v_teacher.first_name
                        || ' '
                        || v_teacher.last_name);
   
   -- Update teacher person info
   pkg_teacher.update_teacher_person_info(
      v_teacher_id,
      'Jane',
      'Johnson',
      'jane.johnson@example.com',
      'new_hashed_password',
      'new_salt'
   );
   dbms_output.put_line('Teacher person info updated');
   
   -- Delete teacher (cleanup)
   pkg_teacher.delete_teacher(v_teacher_id);
   dbms_output.put_line('Teacher deleted successfully');
end;
/

-- =====================================
-- Package: pkg_subject - CRUD Operations
-- =====================================
-- Test subject CRUD operations
declare
   v_subject_id number;
   v_subject    pkg_subject.subject_rec;
begin
   -- Create new subject
   pkg_subject.add_subject('Advanced Mathematics');
   dbms_output.put_line('New subject created: Advanced Mathematics');
   
   -- Get subject ID by name
   v_subject_id := pkg_subject.get_subject_id_by_name('Advanced Mathematics');
   dbms_output.put_line('Subject ID: ' || v_subject_id);
   
   -- Read subject
   v_subject := pkg_subject.get_subject_by_id(v_subject_id);
   dbms_output.put_line('Subject details: ' || v_subject.subject_name);
   
   -- Update subject
   pkg_subject.update_subject(
      v_subject_id,
      'Advanced Mathematics II'
   );
   dbms_output.put_line('Subject updated');
   
   -- Get subject name by ID
   dbms_output.put_line('Subject name: ' || pkg_subject.get_subject_name_by_id(v_subject_id));
   
   -- Delete subject (cleanup)
   pkg_subject.delete_subject(v_subject_id);
   dbms_output.put_line('Subject deleted successfully');
end;
/

-- =====================================
-- Package: pkg_class - CRUD Operations
-- =====================================

-- Test class CRUD operations
declare
   v_class_id number;
   v_class    pkg_class.class_rec;
begin
   -- Create new class
   pkg_class.add_class(
      'Test Class',
      1
   );
   dbms_output.put_line('New class created: Test Class');
   
   -- Get class ID by name
   v_class_id := pkg_class.get_class_id_by_name('Test Class');
   dbms_output.put_line('Class ID: ' || v_class_id);
   
   -- Read class
   v_class := pkg_class.get_class_by_id(v_class_id);
   dbms_output.put_line('Class details: '
                        || v_class.class_name
                        || ' with teacher ID: '
                        || v_class.teacher_id);
   
   -- Update class
   pkg_class.update_class(
      v_class_id,
      'Updated Test Class',
      2
   );
   dbms_output.put_line('Class updated');
   
   -- Delete class (cleanup)
   pkg_class.delete_class(v_class_id);
   dbms_output.put_line('Class deleted successfully');
end;
/

-- =====================================
-- Package: pkg_classroom - CRUD Operations
-- =====================================

-- Test classroom CRUD operations
declare
   v_classroom_id number;
   v_classroom    pkg_classroom.classroom_rec;
begin
   -- Create new classroom
   pkg_classroom.add_classroom(
      'Test Room',
      30
   );
   dbms_output.put_line('New classroom created: Test Room');
   
   -- Get classroom ID by name
   v_classroom_id := pkg_classroom.get_classroom_id_by_name('Test Room');
   dbms_output.put_line('Classroom ID: ' || v_classroom_id);
   
   -- Read classroom
   v_classroom := pkg_classroom.get_classroom_by_id(v_classroom_id);
   dbms_output.put_line('Classroom details: '
                        || v_classroom.classroom_name
                        || ' with capacity: '
                        || v_classroom.capacity);
   
   -- Update classroom
   pkg_classroom.update_classroom(
      v_classroom_id,
      'Updated Test Room',
      35
   );
   dbms_output.put_line('Classroom updated');
   
   -- Delete classroom (cleanup)
   pkg_classroom.delete_classroom(v_classroom_id);
   dbms_output.put_line('Classroom deleted successfully');
end;
/

-- =====================================
-- Package: pkg_lecture - CRUD Operations
-- =====================================

-- Test lecture CRUD operations
declare
   v_lecture_id number;
   v_lecture    pkg_lecture.lecture_rec;
begin
   -- Create new lecture
   pkg_lecture.add_lecture(
      1,
      1,
      to_timestamp('2025-01-20 09:00:00',
                           'YYYY-MM-DD HH24:MI:SS'),
      to_timestamp('2025-01-20 10:30:00',
                           'YYYY-MM-DD HH24:MI:SS'),
      'Test Lecture',
      'This is a test lecture'
   );
   dbms_output.put_line('New lecture created: Test Lecture');
   
   -- Get lecture ID by natural key
   v_lecture_id := pkg_lecture.get_lecture_id_by_natural_key(
      1,
      1,
      to_timestamp('2025-01-20 09:00:00',
                                          'YYYY-MM-DD HH24:MI:SS')
   );
   dbms_output.put_line('Lecture ID: ' || v_lecture_id);
   
   -- Read lecture
   v_lecture := pkg_lecture.get_lecture_by_id(v_lecture_id);
   dbms_output.put_line('Lecture details: ' || v_lecture.lecture_name);
   
   -- Update lecture
   pkg_lecture.update_lecture(
      v_lecture_id,
      1,
      1,
      to_timestamp('2025-01-20 09:00:00',
                              'YYYY-MM-DD HH24:MI:SS'),
      to_timestamp('2025-01-20 10:30:00',
                              'YYYY-MM-DD HH24:MI:SS'),
      'Updated Test Lecture',
      'This is an updated test lecture'
   );
   dbms_output.put_line('Lecture updated');
   
   -- Delete lecture (cleanup)
   pkg_lecture.delete_lecture(v_lecture_id);
   dbms_output.put_line('Lecture deleted successfully');
end;
/

-- =====================================
-- Package: pkg_parent - CRUD Operations
-- =====================================

-- Test parent CRUD operations
declare
   v_parent_id number;
   v_parent    pkg_parent.parent_rec;
begin
   -- Create new parent
   v_parent_id := pkg_parent.add_parent(
      'Parent',
      'Test',
      'parent.test@example.com',
      'hashed_password',
      'salt123'
   );
   dbms_output.put_line('New parent created with ID: ' || v_parent_id);
   
   -- Read parent
   v_parent := pkg_parent.get_parent_by_id(v_parent_id);
   dbms_output.put_line('Parent details: '
                        || v_parent.first_name
                        || ' '
                        || v_parent.last_name);
   
   -- Update parent person info
   pkg_parent.update_parent_person_info(
      v_parent_id,
      'Updated',
      'Parent',
      'updated.parent@example.com',
      'new_hashed_password',
      'new_salt'
   );
   dbms_output.put_line('Parent person info updated');
   
   -- Delete parent (cleanup)
   pkg_parent.delete_parent(v_parent_id);
   dbms_output.put_line('Parent deleted successfully');
end;
/

-- =====================================
-- Package: pkg_grade_group - CRUD Operations
-- =====================================

-- Test grade group CRUD operations
declare
   v_grade_group_id number;
   v_grade_group    pkg_grade_group.grade_group_rec;
begin
   -- Create new grade group
   pkg_grade_group.add_grade_group(
      1,
      1,
      to_timestamp('2025-08-20 05:08:02.912',
                                   'YYYY-MM-DD HH24:MI:SS.FF'),
      'Test Quiz',
      'This is a test quiz'
   );
   dbms_output.put_line('New grade group created: Test Quiz');
   
   -- Get grade group ID by natural key
   v_grade_group_id := pkg_grade_group.get_grade_group_id_by_natural_key(
      1,
      1,
      to_timestamp('2025-08-20 05:08:02.912',
                                                  'YYYY-MM-DD HH24:MI:SS.FF'),
      'Test Quiz'
   );
   dbms_output.put_line('Grade group ID: ' || v_grade_group_id);
   
   -- Read grade group
   v_grade_group := pkg_grade_group.get_grade_group_by_id(v_grade_group_id);
   dbms_output.put_line('Grade group details: ' || v_grade_group.grade_group_name);
   
   -- Update grade group
   pkg_grade_group.update_grade_group(
      v_grade_group_id,
      1,
      1,
      systimestamp,
      'Updated Test Quiz',
      'This is an updated test quiz'
   );
   dbms_output.put_line('Grade group updated');
   
   -- Get grade group name by ID
   dbms_output.put_line('Grade group name: ' || pkg_grade_group.get_grade_group_name_by_id(v_grade_group_id));
   
   -- Delete grade group (cleanup)
   pkg_grade_group.delete_grade_group(v_grade_group_id);
   dbms_output.put_line('Grade group deleted successfully');
end;
/


-- =====================================
-- Package: pkg_class_group - CRUD Operations
-- =====================================

-- Test class group CRUD operations
declare
   v_class_group_id number;
   v_class_group    pkg_class_group.class_group_rec;
begin
   -- Create new class group
   pkg_class_group.add_class_group(
      1,
      'Test Group'
   );
   dbms_output.put_line('New class group created: Test Group');
   
   -- Get class group ID by natural key
   v_class_group_id := pkg_class_group.get_class_group_id_by_natural_key(
      1,
      'Test Group'
   );
   dbms_output.put_line('Class group ID: ' || v_class_group_id);
   
   -- Read class group
   v_class_group := pkg_class_group.get_class_group_by_id(v_class_group_id);
   dbms_output.put_line('Class group details: ' || v_class_group.group_name);
   
   -- Update class group
   pkg_class_group.update_class_group(
      v_class_group_id,
      1,
      'Updated Test Group'
   );
   dbms_output.put_line('Class group updated');
   
   -- Get class group name by ID
   dbms_output.put_line('Class group name: ' || pkg_class_group.get_class_group_name_by_id(v_class_group_id));
   
   -- Delete class group (cleanup)
   pkg_class_group.delete_class_group(v_class_group_id);
   dbms_output.put_line('Class group deleted successfully');
end;
/

-- =====================================
-- Package: pkg_student_parent - CRUD Operations 
-- =====================================

-- Test student-parent relationship operations
declare
   v_student_id number := 8;
   v_parent_id  number := 1;
   v_rec        pkg_student_parent.student_parent_rec;
begin
   -- Add student-parent relationship
   pkg_student_parent.add_student_parent(
      v_student_id,
      v_parent_id
   );
   dbms_output.put_line('Student-parent relationship added');
   
   -- Update relationship
   pkg_student_parent.update_student_parent(
      v_student_id,
      v_parent_id,
      2,
      2
   );
   dbms_output.put_line('Student-parent relationship updated');
   
   -- Get students by parent
   declare
      v_students pkg_student_parent.student_id_table;
   begin
      v_students := pkg_student_parent.get_students_by_parent(2);
      dbms_output.put_line('Students for parent 2: ' || v_students.count);
   end;
   
   -- Get parents by student
   declare
      v_parents pkg_student_parent.parent_id_table;
   begin
      v_parents := pkg_student_parent.get_parents_by_student(2);
      dbms_output.put_line('Parents for student 2: ' || v_parents.count);
   end;
   
   -- Delete relationship (cleanup)
   pkg_student_parent.delete_student_parent(
      2,
      2
   );
   dbms_output.put_line('Student-parent relationship deleted');
end;
/

-- =====================================
-- Package: pkg_subject_teacher - CRUD Operations 
-- =====================================

-- Test subject-teacher relationship operations
declare
   v_subject_id number := 4;
   v_teacher_id number := 2;
   v_rec        pkg_subject_teacher.subject_teacher_rec;
begin
   -- Add subject-teacher relationship
   pkg_subject_teacher.add_subject_teacher(
      v_subject_id,
      v_teacher_id
   );
   dbms_output.put_line('Subject-teacher relationship added');
   
   
   -- Update relationship
   pkg_subject_teacher.update_subject_teacher(
      v_subject_id,
      v_teacher_id,
      3,
      4
   );
   dbms_output.put_line('Subject-teacher relationship updated');
   
   -- Get teachers by subject
   declare
      v_teachers pkg_subject_teacher.teacher_id_table;
   begin
      v_teachers := pkg_subject_teacher.get_teachers_by_subject(2);
      dbms_output.put_line('Teachers for subject 2: ' || v_teachers.count);
   end;
   
   -- Delete relationship (cleanup)
   pkg_subject_teacher.delete_subject_teacher(
      2,
      2
   );
   dbms_output.put_line('Subject-teacher relationship deleted');
end;
/

-- =====================================
-- Package: pkg_student_subject_teacher - CRUD Operations
-- =====================================

-- Test student-subject-teacher relationship operations
declare
   v_student_id number := 1;
   v_subject_id number := 4;
   v_teacher_id number := 1;
   v_rec        pkg_student_subject_teacher.student_subject_teacher_rec;
   v_subjects   pkg_student_subject_teacher.subject_id_table;
   v_teachers   pkg_student_subject_teacher.teacher_id_table;
   v_students   pkg_student_subject_teacher.student_id_table;
begin
   -- Add student-subject-teacher relationship
   pkg_student_subject_teacher.add_student_subject_teacher(
      v_student_id,
      v_subject_id,
      v_teacher_id
   );
   dbms_output.put_line('Student-Subject-Teacher relationship added');

   -- Update relationship (example: change to student_id=2, subject_id=2, teacher_id=2)
   pkg_student_subject_teacher.update_student_subject_teacher(
      v_student_id,
      v_subject_id,
      v_teacher_id,
      2,
      5,
      2
   );
   dbms_output.put_line('Student-Subject-Teacher relationship updated');

   -- Get subjects by student and teacher (for student_id=2, teacher_id=2)
   v_subjects := pkg_student_subject_teacher.get_subjects_by_student_teacher(2, 2);
   dbms_output.put_line('Subjects for student 2 and teacher 2: ' || v_subjects.count);

   -- Get teachers by student and subject (for student_id=2, subject_id=2)
   v_teachers := pkg_student_subject_teacher.get_teachers_by_student_subject(2, 2);
   dbms_output.put_line('Teachers for student 2 and subject 2: ' || v_teachers.count);

   -- Get students by subject and teacher (for subject_id=2, teacher_id=2)
   v_students := pkg_student_subject_teacher.get_students_by_subject_teacher(2, 2);
   dbms_output.put_line('Students for subject 2 and teacher 2: ' || v_students.count);

   -- Delete relationship (cleanup)
   pkg_student_subject_teacher.delete_student_subject_teacher(
      2,
      5,
      2
   );
   dbms_output.put_line('Student-Subject-Teacher relationship deleted');
end;
/

-- =====================================
-- Package: pkg_classroom_lecture - CRUD Operations
-- =====================================

-- Test classroom-lecture relationship operations
declare
   v_classroom_id number := 1;
   v_lecture_id   number := 1;
begin
   -- Add classroom-lecture relationship
   pkg_classroom_lecture.add_classroom_lecture(
      v_classroom_id,
      v_lecture_id
   );
   dbms_output.put_line('Classroom-lecture relationship added');
   
   -- Update relationship
   pkg_classroom_lecture.update_classroom_lecture(
      v_classroom_id,
      v_lecture_id,
      2,
      2
   );
   dbms_output.put_line('Classroom-lecture relationship updated');
   
   -- Get lectures by classroom
   declare
      v_lectures pkg_classroom_lecture.lecture_id_table;
   begin
      v_lectures := pkg_classroom_lecture.get_lectures_by_classroom(2);
      dbms_output.put_line('Lectures for classroom 2: ' || v_lectures.count);
   end;
   
   -- Get classrooms by lecture
   declare
      v_classrooms pkg_classroom_lecture.classroom_id_table;
   begin
      v_classrooms := pkg_classroom_lecture.get_classrooms_by_lecture(2);
      dbms_output.put_line('Classrooms for lecture 2: ' || v_classrooms.count);
   end;
   
   -- Delete relationship (cleanup)
   pkg_classroom_lecture.delete_classroom_lecture(
      2,
      2
   );
   dbms_output.put_line('Classroom-lecture relationship deleted');
end;
/

-- =====================================
--             END OF CRUD
-- =====================================

-- =====================================
-- Package: pkg_grade_group - Statistics
-- =====================================

-- Example to show statistics of a grade group (ef. of some quiz or test)
declare
   v_grade_group_id number;
begin
   v_grade_group_id := 1;
   dbms_output.put_line('Grade group name: ' || pkg_grade_group.get_grade_group_name_by_id(v_grade_group_id));
   dbms_output.put_line(' * Average grade: ' || pkg_grade_group.get_average_grade(v_grade_group_id));
   dbms_output.put_line(' * Most common grade: ' || pkg_grade_group.get_most_common_grade(v_grade_group_id));
   dbms_output.put_line(' * Median grade: ' || pkg_grade_group.get_median_grade(v_grade_group_id));
end;
/

-- =====================================
-- Package: pkg_subject - Statistics
-- =====================================

-- Example to show statistics of a student in a specific subject
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

-- General statistics of a subject
declare
   v_subject_id number;
begin
   v_subject_id := 1;
   dbms_output.put_line('Subject name: ' || pkg_subject.get_subject_name_by_id(v_subject_id));
   dbms_output.put_line(' * Average grade: ' || pkg_subject.get_subject_average_grade(v_subject_id));
   dbms_output.put_line(' * Most common grade: ' || pkg_subject.get_subject_most_common_grade(v_subject_id));
   dbms_output.put_line(' * Median grade: ' || pkg_subject.get_subject_median_grade(v_subject_id));
end;
/

-- Get student's attendance of a subject
declare
   v_student_id number;
   v_subject_id number;
begin
   v_student_id := 12;
   v_subject_id := 1;
   dbms_output.put_line('Student name: ' || pkg_student.get_student_full_name_by_id(v_student_id));
   dbms_output.put_line('Subject name: ' || pkg_subject.get_subject_name_by_id(v_subject_id));
   dbms_output.put_line(' * Student attendance rate: '
                        || pkg_subject.attendance_rate(
      v_student_id,
      v_subject_id
   ));
end;

-- Generate lectures for a subject
declare
   v_subject_id number;
begin
   v_subject_id := 2;

   pkg_lecture.generate_lectures(
      p_from_date       => to_timestamp('2025-09-01',
             'YYYY-MM-DD'),
      p_to_date         => to_timestamp('2025-09-30',
             'YYYY-MM-DD'),
      p_subject_id      => v_subject_id,
      p_classroom_id    => 3,
     -- Only time H:M:S is used in the method:
      p_start_time      => to_timestamp('1970-01-01 08:00:00',
             'YYYY-MM-DD HH24:MI:SS'),
      p_length_minutes  => 45,
      repeats_monday    => true,
      repeats_wednesday => true
   );

   -- For clean up:
   -- pkg_lecture.delete_subject_lectures(v_subject_id);

end;
/



-- =====================================
--                TRIGGERS
-- =====================================

-- Test of trg_class_group_student_biu -> insert student into class group which does not belong to student's class
-- It will raise exception because class_group:3 belongs to class:2 but student:1 is in class:1
-- Exception expected ⛔
declare
   v_student_id     number;
   v_class_group_id number;
begin
   v_student_id := 1;
   v_class_group_id := 3;
   dbms_output.put_line('Inserting student ID: '
                        || pkg_student.get_student_full_name_by_id(v_student_id)
                        || ' into class group ID: '
                        || pkg_class_group.get_class_group_name_by_id(v_class_group_id));

   insert into class_group_student (
      class_group_id,
      student_id
   ) values ( v_class_group_id,
              v_student_id );
   commit;
end;
/