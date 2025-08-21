/*
   File: 04_delete_stats.sql
   Author: David Válek
   Description: Delete table statistics for all tables in the VDA schema
   Created: 2025-08-16
   Notes: 
     - Removes optimizer statistics from all tables and their indexes
     - Use when you want to force Oracle to use dynamic sampling
     - Typically used for testing or when statistics become stale/misleading
     - After running this, consider gathering fresh statistics with 03_create_stats.sql
*/

-- Delete statistics for Person table (base table for all people)
exec dbms_stats.delete_table_stats(USER, 'PERSON');

-- Delete statistics for Student table
exec dbms_stats.delete_table_stats(USER, 'STUDENT');

-- Delete statistics for Teacher table
exec dbms_stats.delete_table_stats(USER, 'TEACHER');

-- Delete statistics for Parent table
exec dbms_stats.delete_table_stats(USER, 'PARENT');

-- Delete statistics for Subject table
exec dbms_stats.delete_table_stats(USER, 'SUBJECT');

-- Delete statistics for Class table
exec dbms_stats.delete_table_stats(USER, 'CLASS');

-- Delete statistics for Class_Group table
exec dbms_stats.delete_table_stats(USER, 'CLASS_GROUP');

-- Delete statistics for Classroom table
exec dbms_stats.delete_table_stats(USER, 'CLASSROOM');

-- Delete statistics for Lecture table
exec dbms_stats.delete_table_stats(USER, 'LECTURE');

-- Delete statistics for Grade_Group table
exec dbms_stats.delete_table_stats(USER, 'GRADE_GROUP');

-- Delete statistics for Grade_Group_Student junction table
exec dbms_stats.delete_table_stats(USER, 'GRADE_GROUP_STUDENT');

-- Delete statistics for Student_Parent junction table
exec dbms_stats.delete_table_stats(USER, 'STUDENT_PARENT');

-- Delete statistics for student_subject_teacher junction table
exec dbms_stats.delete_table_stats(USER, 'student_subject_teacher');

-- Delete statistics for Subject_Teacher junction table
exec dbms_stats.delete_table_stats(USER, 'SUBJECT_TEACHER');

-- Delete statistics for Lecture_Student junction table
exec dbms_stats.delete_table_stats(USER, 'LECTURE_STUDENT');

-- Delete statistics for Lecture_Teacher junction table
exec dbms_stats.delete_table_stats(USER, 'LECTURE_TEACHER');

-- Delete statistics for Classroom_Lecture junction table
exec dbms_stats.delete_table_stats(USER, 'CLASSROOM_LECTURE');


-- Final completion message
begin
   dbms_output.put_line('==================================================');
   dbms_output.put_line('Statistics deletion completed for all tables!');
   dbms_output.put_line('Run date: ' || to_char(
      sysdate,
      'YYYY-MM-DD HH24:MI:SS'
   ));
   dbms_output.put_line('Note: Consider running 03_create_stats.sql to gather fresh statistics');
   dbms_output.put_line('==================================================');
end;