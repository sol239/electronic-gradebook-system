/*
   File: 02_create_demo_data_new.sql
   Author: David Válek
   Created: 2025-08-16
   Description: Demo data for the new normalized structure with Person table
   Notes:
     - Creates demo data using the new packages
     - Uses the normalized structure with Person as central table
*/

-- Demo data using packages for the new structure

-- Add some teachers first
DECLARE
   v_teacher_id NUMBER;
BEGIN
   -- Teacher 1
   v_teacher_id := pkg_teacher.add_teacher(
      p_first_name => 'Jan',
      p_last_name => 'Novák',
      p_email => 'jan.novak@school.cz',
      p_password_hash => 'hashed_password_1',
      p_salt => 'salt1'
   );
   
   -- Teacher 2
   v_teacher_id := pkg_teacher.add_teacher(
      p_first_name => 'Marie',
      p_last_name => 'Svobodová',
      p_email => 'marie.svobodova@school.cz',
      p_password_hash => 'hashed_password_2',
      p_salt => 'salt2'
   );
   
   -- Teacher 3
   v_teacher_id := pkg_teacher.add_teacher(
      p_first_name => 'Petr',
      p_last_name => 'Dvořák',
      p_email => 'petr.dvorak@school.cz',
      p_password_hash => 'hashed_password_3',
      p_salt => 'salt3'
   );
   
   -- Teacher 4
   v_teacher_id := pkg_teacher.add_teacher(
      p_first_name => 'Anna',
      p_last_name => 'Nováková',
      p_email => 'anna.novakova@school.cz',
      p_password_hash => 'hashed_password_4',
      p_salt => 'salt4'
   );
   
   -- Teacher 5
   v_teacher_id := pkg_teacher.add_teacher(
      p_first_name => 'Karel',
      p_last_name => 'Procházka',
      p_email => 'karel.prochazka@school.cz',
      p_password_hash => 'hashed_password_5',
      p_salt => 'salt5'
   );
END;
/

-- Add some parents
DECLARE
   v_parent_id NUMBER;
BEGIN
   -- Parent 1
   v_parent_id := pkg_parent.add_parent(
      p_first_name => 'Zdeněk',
      p_last_name => 'Veselý',
      p_email => 'zdenek.vesely22@gmail.com',
      p_password_hash => 'hashed_password_p1',
      p_salt => 'saltp1'
   );
   
   -- Parent 2
   v_parent_id := pkg_parent.add_parent(
      p_first_name => 'Adam',
      p_last_name => 'Kolář',
      p_email => 'adam.kolar23@gmail.com',
      p_password_hash => 'hashed_password_p2',
      p_salt => 'saltp2'
   );
   
   -- Parent 3
   v_parent_id := pkg_parent.add_parent(
      p_first_name => 'Stanislav',
      p_last_name => 'Sedláček',
      p_email => 'stanislav.sedlacek24@centrum.cz',
      p_password_hash => 'hashed_password_p3',
      p_salt => 'saltp3'
   );
   
   -- Parent 4
   v_parent_id := pkg_parent.add_parent(
      p_first_name => 'Martin',
      p_last_name => 'Procházka',
      p_email => 'martin.prochazka25@centrum.cz',
      p_password_hash => 'hashed_password_p4',
      p_salt => 'saltp4'
   );
   
   -- Parent 5
   v_parent_id := pkg_parent.add_parent(
      p_first_name => 'Pavla',
      p_last_name => 'Růžičková',
      p_email => 'pavla.ruzickova48@centrum.cz',
      p_password_hash => 'hashed_password_p5',
      p_salt => 'saltp5'
   );
   
   -- Parent 6
   v_parent_id := pkg_parent.add_parent(
      p_first_name => 'Radka',
      p_last_name => 'Benešová',
      p_email => 'radka.benesova49@gmail.com',
      p_password_hash => 'hashed_password_p6',
      p_salt => 'saltp6'
   );
   
   -- Parent 7
   v_parent_id := pkg_parent.add_parent(
      p_first_name => 'Lenka',
      p_last_name => 'Křížová',
      p_email => 'lenka.krizova52@seznam.cz',
      p_password_hash => 'hashed_password_p7',
      p_salt => 'saltp7'
   );
   
   -- Parent 8
   v_parent_id := pkg_parent.add_parent(
      p_first_name => 'Hana',
      p_last_name => 'Šimková',
      p_email => 'hana.simkova53@seznam.cz',
      p_password_hash => 'hashed_password_p8',
      p_salt => 'saltp8'
   );
END;
/

-- Add some students
DECLARE
   v_student_id NUMBER;
BEGIN
   -- Student 1 - assuming class_id 1 exists
   v_student_id := pkg_student.add_student(
      p_first_name => 'Tomáš',
      p_last_name => 'Novák',
      p_email => 'tomas.novak@student.cz',
      p_password_hash => 'hashed_password_s1',
      p_salt => 'salts1',
      p_class_id => 1
   );
   
   -- Student 2
   v_student_id := pkg_student.add_student(
      p_first_name => 'Klára',
      p_last_name => 'Svobodová',
      p_email => 'klara.svobodova@student.cz',
      p_password_hash => 'hashed_password_s2',
      p_salt => 'salts2',
      p_class_id => 1
   );
   
   -- Student 3
   v_student_id := pkg_student.add_student(
      p_first_name => 'Jakub',
      p_last_name => 'Dvořák',
      p_email => 'jakub.dvorak@student.cz',
      p_password_hash => 'hashed_password_s3',
      p_salt => 'salts3',
      p_class_id => 2
   );
   
   -- Student 4
   v_student_id := pkg_student.add_student(
      p_first_name => 'Tereza',
      p_last_name => 'Nováková',
      p_email => 'tereza.novakova@student.cz',
      p_password_hash => 'hashed_password_s4',
      p_salt => 'salts4',
      p_class_id => 2
   );
   
   -- Student 5
   v_student_id := pkg_student.add_student(
      p_first_name => 'David',
      p_last_name => 'Procházka',
      p_email => 'david.prochazka@student.cz',
      p_password_hash => 'hashed_password_s5',
      p_salt => 'salts5',
      p_class_id => 3
   );
   
   -- Student 6
   v_student_id := pkg_student.add_student(
      p_first_name => 'Lucie',
      p_last_name => 'Veselá',
      p_email => 'lucie.vesela@student.cz',
      p_password_hash => 'hashed_password_s6',
      p_salt => 'salts6',
      p_class_id => 3
   );
   
   -- Student 7
   v_student_id := pkg_student.add_student(
      p_first_name => 'Martin',
      p_last_name => 'Kolář',
      p_email => 'martin.kolar@student.cz',
      p_password_hash => 'hashed_password_s7',
      p_salt => 'salts7',
      p_class_id => 1
   );
   
   -- Student 8
   v_student_id := pkg_student.add_student(
      p_first_name => 'Eliška',
      p_last_name => 'Sedláčková',
      p_email => 'eliska.sedlackova@student.cz',
      p_password_hash => 'hashed_password_s8',
      p_salt => 'salts8',
      p_class_id => 2
   );
END;
/

COMMIT;

-- Display some information about the created records
DBMS_OUTPUT.PUT_LINE('=== Demo Data Creation Complete ===');
DBMS_OUTPUT.PUT_LINE('Created teachers, parents, and students with normalized Person structure');
DBMS_OUTPUT.PUT_LINE('All personal information is stored in the Person table');
DBMS_OUTPUT.PUT_LINE('Role-specific tables only contain IDs and foreign keys');
