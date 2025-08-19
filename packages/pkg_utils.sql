/*
   File: pkg_utils.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Package for utility functions.
*/

-- Package specification
create or replace package pkg_utils as
    /*
       Returns the hashed value of the input password with salt.
       Parameters:
         p_pwd - the password to be hashed
         p_salt - the salt to be used for hashing
    */
   function hash_password (
      p_pwd varchar2,
      p_salt varchar2
   ) return varchar2;

    /*
       Returns a random salt of the specified length.
       Parameters:
         p_length - the length of the random salt
    */
   function random_salt (
      p_length number
   ) return varchar2;

    /*
       Returns a random password of the specified length.
       Parameters:
         p_length - the length of the random password
    */
   function random_password (
      p_length number
   ) return varchar2;

end pkg_utils;
/

-- Package body
create or replace package body pkg_utils as

   function hash_password (
      p_pwd  varchar2,
      p_salt varchar2
   ) return varchar2 is
   begin
      commit;
      return rawtohex(dbms_crypto.hash(
         utl_raw.cast_to_raw(p_pwd || p_salt),
         dbms_crypto.hash_sh256
      ));
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -21001,
            'Duplicate value error in hash_password.'
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -21002,
            'Type or length error in hash_password.'
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -21003,
            'Unexpected error in hash_password: ' || SQLERRM
         );
   end hash_password;

   function random_salt (
      p_length number
   ) return varchar2 is
   begin
      commit;
      return dbms_random.string(
         'X',
         p_length
      );
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -21004,
            'Duplicate value error in random_salt.'
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -21005,
            'Type or length error in random_salt.'
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -21006,
            'Unexpected error in random_salt: ' || SQLERRM
         );
   end random_salt;

   function random_password (
      p_length number
   ) return varchar2 is
   begin
      commit;
      return dbms_random.string(
         'X',
         p_length
      );
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -21007,
            'Duplicate value error in random_password.'
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -21008,
            'Type or length error in random_password.'
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -21009,
            'Unexpected error in random_password: ' || SQLERRM
         );
   end random_password;

end pkg_utils;
/