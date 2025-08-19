/*
   File: tbl_grade_group_student.sql
   Author: David Válek
   Description: Table definition for Grade_Group_Student, which links students to their grade groups. It is basically a many-to-many relationship between students and grade groups.
                It basically is personal evaluation of students within specific grade groups (= tests, quizzes, etc.).
   Created: 2025-08-10
*/
create table grade_group_student (
   grade_group_id number not null,
   student_id number not null,
   grade number null,
   message varchar2(255) null,
   grade_date timestamp default current_timestamp not null,

   CONSTRAINT pk_grade_group_student PRIMARY KEY ( grade_group_id,
                 student_id ),
   constraint fk_gs_grade_group foreign key ( grade_group_id )
      references grade_group ( grade_group_id ),
   constraint fk_gs_student foreign key ( student_id )
      references student ( student_id )
);