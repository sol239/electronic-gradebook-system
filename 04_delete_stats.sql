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
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'PERSON',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for PERSON table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for PERSON: ' || SQLERRM);
END;
/

-- Delete statistics for Student table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'STUDENT',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for STUDENT table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for STUDENT: ' || SQLERRM);
END;
/

-- Delete statistics for Teacher table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'TEACHER',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for TEACHER table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for TEACHER: ' || SQLERRM);
END;
/

-- Delete statistics for Parent table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'PARENT',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for PARENT table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for PARENT: ' || SQLERRM);
END;
/

-- Delete statistics for Subject table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'SUBJECT',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for SUBJECT table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for SUBJECT: ' || SQLERRM);
END;
/

-- Delete statistics for Class table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'CLASS',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for CLASS table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for CLASS: ' || SQLERRM);
END;
/

-- Delete statistics for Classroom table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'CLASSROOM',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for CLASSROOM table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for CLASSROOM: ' || SQLERRM);
END;
/

-- Delete statistics for Lecture table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'LECTURE',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for LECTURE table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for LECTURE: ' || SQLERRM);
END;
/

-- Delete statistics for Grade table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'GRADE',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for GRADE table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for GRADE: ' || SQLERRM);
END;
/

-- Delete statistics for Student_Parent junction table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'STUDENT_PARENT',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for STUDENT_PARENT table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for STUDENT_PARENT: ' || SQLERRM);
END;
/

-- Delete statistics for Student_Subject junction table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'STUDENT_SUBJECT',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for STUDENT_SUBJECT table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for STUDENT_SUBJECT: ' || SQLERRM);
END;
/

-- Delete statistics for Subject_Teacher junction table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'SUBJECT_TEACHER',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for SUBJECT_TEACHER table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for SUBJECT_TEACHER: ' || SQLERRM);
END;
/

-- Delete statistics for Lecture_Student junction table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'LECTURE_STUDENT',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for LECTURE_STUDENT table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for LECTURE_STUDENT: ' || SQLERRM);
END;
/

-- Delete statistics for Lecture_Teacher junction table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'LECTURE_TEACHER',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for LECTURE_TEACHER table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for LECTURE_TEACHER: ' || SQLERRM);
END;
/

-- Delete statistics for Classroom_Lecture junction table
BEGIN
    DBMS_STATS.DELETE_TABLE_STATS(
        ownname => USER,
        tabname => 'CLASSROOM_LECTURE',
        cascade_indexes => TRUE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics deleted for CLASSROOM_LECTURE table');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting stats for CLASSROOM_LECTURE: ' || SQLERRM);
END;
/

-- Final completion message
BEGIN
    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('Statistics deletion completed for all tables!');
    DBMS_OUTPUT.PUT_LINE('Run date: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('Note: Consider running 03_create_stats.sql to gather fresh statistics');
    DBMS_OUTPUT.PUT_LINE('==================================================');
END;
/
