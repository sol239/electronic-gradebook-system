/*
   File: 03_create_stats.sql
   Author: David Válek
   Description: Gather table statistics for all tables in the VDA schema
   Created: 2025-08-16
   Notes: 
     - Statistics help the Oracle optimizer choose the best execution plans
     - Should be run after data is loaded or when significant data changes occur
     - Using ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE for automatic sampling
*/

-- Gather statistics for Person table (base table for all people)
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'PERSON',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for PERSON table');
END;
/

-- Gather statistics for Student table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'STUDENT',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for STUDENT table');
END;
/

-- Gather statistics for Teacher table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'TEACHER',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for TEACHER table');
END;
/

-- Gather statistics for Parent table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'PARENT',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for PARENT table');
END;
/

-- Gather statistics for Subject table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'SUBJECT',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for SUBJECT table');
END;
/

-- Gather statistics for Class table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'CLASS',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for CLASS table');
END;
/

-- Gather statistics for Classroom table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'CLASSROOM',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for CLASSROOM table');
END;
/

-- Gather statistics for Lecture table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'LECTURE',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for LECTURE table');
END;
/

-- Gather statistics for Grade table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'GRADE_GROUP',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for GRADE_GROUP table');
END;
/

-- Gather statistics for Grade table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'GRADE_GROUP_STUDENT',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for GRADE_GROUP_STUDENT table');
END;
/

-- Gather statistics for Student_Parent junction table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'STUDENT_PARENT',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for STUDENT_PARENT table');
END;
/

-- Gather statistics for Student_Subject junction table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'STUDENT_SUBJECT',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for STUDENT_SUBJECT table');
END;
/

-- Gather statistics for Subject_Teacher junction table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'SUBJECT_TEACHER',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for SUBJECT_TEACHER table');
END;
/

-- Gather statistics for Lecture_Student junction table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'LECTURE_STUDENT',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for LECTURE_STUDENT table');
END;
/

-- Gather statistics for Lecture_Teacher junction table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'LECTURE_TEACHER',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for LECTURE_TEACHER table');
END;
/

-- Gather statistics for Classroom_Lecture junction table
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'CLASSROOM_LECTURE',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        cascade => TRUE,
        degree => DBMS_STATS.AUTO_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Statistics gathered for CLASSROOM_LECTURE table');
END;
/

-- Final completion message
BEGIN
    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('Statistics gathering completed for all tables!');
    DBMS_OUTPUT.PUT_LINE('Run date: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('==================================================');
END;
/