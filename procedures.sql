CREATE OR REPLACE PACKAGE Student_pkg AS
    PROCEDURE add_student(
        p_first_name   VARCHAR2,
        p_last_name    VARCHAR2,
        p_date_of_birth DATE,
        p_email        VARCHAR2,
        p_class_id     NUMBER DEFAULT NULL
    );

    PROCEDURE update_student(
        p_student_id   NUMBER,
        p_first_name   VARCHAR2,
        p_last_name    VARCHAR2,
        p_date_of_birth DATE,
        p_email        VARCHAR2,
        p_class_id     NUMBER
    );

    PROCEDURE delete_student(p_student_id NUMBER);

    PROCEDURE assign_class(p_student_id NUMBER, p_class_id NUMBER);

    PROCEDURE remove_from_class(p_student_id NUMBER);

    PROCEDURE get_student_by_id(p_student_id NUMBER);
END Student_pkg;
/
