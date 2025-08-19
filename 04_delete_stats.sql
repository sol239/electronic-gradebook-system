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
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'PERSON',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for PERSON table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for PERSON: ' || sqlerrm);
end;
/

-- Delete statistics for Student table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'STUDENT',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for STUDENT table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for STUDENT: ' || sqlerrm);
end;
/

-- Delete statistics for Teacher table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'TEACHER',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for TEACHER table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for TEACHER: ' || sqlerrm);
end;
/

-- Delete statistics for Parent table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'PARENT',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for PARENT table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for PARENT: ' || sqlerrm);
end;
/

-- Delete statistics for Subject table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'SUBJECT',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for SUBJECT table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for SUBJECT: ' || sqlerrm);
end;
/

-- Delete statistics for Class table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'CLASS',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for CLASS table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for CLASS: ' || sqlerrm);
end;
/

-- Delete statistics for Classroom table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'CLASSROOM',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for CLASSROOM table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for CLASSROOM: ' || sqlerrm);
end;
/

-- Delete statistics for Lecture table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'LECTURE',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for LECTURE table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for LECTURE: ' || sqlerrm);
end;
/

-- Delete statistics for Grade_Group table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'GRADE_GROUP',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for GRADE_GROUP table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for GRADE_GROUP: ' || sqlerrm);
end;
/

-- Delete statistics for Grade_Group_Student junction table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'GRADE_GROUP',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for GRADE_GROUP table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for GRADE_GROUP: ' || sqlerrm);
end;
/


-- Delete statistics for Student_Parent junction table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'STUDENT_PARENT',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for STUDENT_PARENT table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for STUDENT_PARENT: ' || sqlerrm);
end;
/

-- Delete statistics for Student_Subject junction table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'STUDENT_SUBJECT',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for STUDENT_SUBJECT table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for STUDENT_SUBJECT: ' || sqlerrm);
end;
/

-- Delete statistics for Subject_Teacher junction table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'SUBJECT_TEACHER',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for SUBJECT_TEACHER table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for SUBJECT_TEACHER: ' || sqlerrm);
end;
/

-- Delete statistics for Lecture_Student junction table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'LECTURE_STUDENT',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for LECTURE_STUDENT table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for LECTURE_STUDENT: ' || sqlerrm);
end;
/

-- Delete statistics for Lecture_Teacher junction table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'LECTURE_TEACHER',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for LECTURE_TEACHER table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for LECTURE_TEACHER: ' || sqlerrm);
end;
/

-- Delete statistics for Classroom_Lecture junction table
begin
   dbms_stats.delete_table_stats(
      ownname         => user,
      tabname         => 'CLASSROOM_LECTURE',
      cascade_indexes => true
   );
   dbms_output.put_line('Statistics deleted for CLASSROOM_LECTURE table');
exception
   when others then
      dbms_output.put_line('Error deleting stats for CLASSROOM_LECTURE: ' || sqlerrm);
end;
/

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
/