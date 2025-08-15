/*
   File: tbl_subject_teacher.sql
   Author: David Válek
   Description: Table definition for Subject_Teacher, which links subjects to their teachers
   Created: 2025-08-15
*/
create table subject_teacher (
   subject_id number not null,
   teacher_id number not null,
   primary key ( subject_id,
                 teacher_id ),
   constraint fk_st_subject foreign key ( subject_id )
      references subject ( subject_id ),
   constraint fk_st_teacher foreign key ( teacher_id )
      references teacher ( teacher_id )
);