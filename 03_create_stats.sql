/*
   File: 03_create_stats.sql
   Author: David Válek
   Description: Gather table statistics for all tables in the VDA schema
   Created: 2025-08-16
*/

-- Gather statistics for all tables in schema
EXEC DBMS_STATS.GATHER_SCHEMA_STATS(USER);

-- stats for table PERSON
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'PERSON', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'PERSON';

-- stats for table PARENT
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'PARENT', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'PARENT';

-- stats for table TEACHER
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'TEACHER', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'TEACHER';

-- stats for table SUBJECT
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'SUBJECT', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'SUBJECT';

-- stats for table CLASS
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'CLASS', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'CLASS';

-- stats for table CLASS_GROUP
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'CLASS_GROUP', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'CLASS_GROUP';

-- stats for table STUDENT
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'STUDENT', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'STUDENT';

-- stats for table CLASS_GROUP_STUDENT
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'CLASS_GROUP_STUDENT', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'CLASS_GROUP_STUDENT';

-- stats for table CLASSROOM
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'CLASSROOM', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'CLASSROOM';

-- stats for table LECTURE
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'LECTURE', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'LECTURE';

-- stats for table GRADE_GROUP
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'GRADE_GROUP', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'GRADE_GROUP';

-- stats for table GRADE_GROUP_STUDENT
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'GRADE_GROUP_STUDENT', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'GRADE_GROUP_STUDENT';

-- stats for table student_subject_teacher
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'student_subject_teacher', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'student_subject_teacher';

-- stats for table SUBJECT_TEACHER
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'SUBJECT_TEACHER', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'SUBJECT_TEACHER';

-- stats for table STUDENT_PARENT
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'STUDENT_PARENT', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'STUDENT_PARENT';

-- stats for table LECTURE_STUDENT
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'LECTURE_STUDENT', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'LECTURE_STUDENT';

-- stats for table LECTURE_TEACHER
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'LECTURE_TEACHER', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'LECTURE_TEACHER';

-- stats for table CLASSROOM_LECTURE
EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 'CLASSROOM_LECTURE', cascade => TRUE);

SELECT column_name, nullable, num_distinct, num_nulls, density, histogram
FROM ALL_TAB_COLUMNS
WHERE table_name = 'CLASSROOM_LECTURE';

-- Final completion message
BEGIN
    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('Statistics gathering completed for all tables!');
    DBMS_OUTPUT.PUT_LINE('Run date: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('==================================================');
END;
/