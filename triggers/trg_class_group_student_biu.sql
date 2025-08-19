CREATE OR REPLACE TRIGGER trg_class_group_student
BEFORE INSERT OR UPDATE ON class_group_student
FOR EACH ROW
DECLARE
    v_class_id_group NUMBER;
    v_class_id_student NUMBER;
BEGIN
    -- Get class_id from class_group
    SELECT class_id INTO v_class_id_group
    FROM class_group
    WHERE class_group_id = :NEW.class_group_id;

    -- Get class_id from student
    SELECT class_id INTO v_class_id_student
    FROM student
    WHERE student_id = :NEW.student_id;

    -- Compare class IDs0
    IF v_class_id_group != v_class_id_student THEN
        RAISE_APPLICATION_ERROR(-20004, 'Class group belongs to different class than is the student one');
    END IF;
END;
/