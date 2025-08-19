/*
   File: grade_group_student.sql
   Author: David Válek
    Created: 2025-08-15
    Description: Trigger for checking student enrollment in grade groups.
    */
CREATE OR REPLACE TRIGGER trg_grade_group_student_biu
BEFORE INSERT OR UPDATE ON grade_group_student
FOR EACH ROW
DECLARE
    v_subject_id NUMBER;
    v_count INTEGER;
BEGIN
    -- Get subject_id for the grade_group
    SELECT subject_id INTO v_subject_id
    FROM grade_group
    WHERE grade_group_id = :NEW.grade_group_id;

    -- print grade_group subject_id
    dbms_output.put_line('Grade Group Subject ID: ' || v_subject_id);
    
    -- Check if student is enrolled in the subject
    SELECT COUNT(*) INTO v_count
    FROM student_subject
    WHERE student_id = :NEW.student_id
      AND subject_id = v_subject_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Student is not enrolled in the subject for this grade group.');
    END IF;
END;
/