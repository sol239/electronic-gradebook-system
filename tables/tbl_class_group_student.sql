/*
   File: tbl_class_group_student.sql
   Author: David Válek
   Description: Table definition for Class_Grouppl_Student, which links students to their class groups
   Created: 2025-08-19
*/
create table class_group_student (
    class_group_id number not null,
    student_id     number not null,
    CONSTRAINT pk_class_group_student PRIMARY KEY ( class_group_id, student_id ),
    constraint fk_cgs_class_group foreign key ( class_group_id )
        references class_group ( class_group_id ),
    constraint fk_cgs_student foreign key ( student_id )
        references student ( student_id )
);