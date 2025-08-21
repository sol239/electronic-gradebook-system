/*
   File: pkg_person.sql
   Author: David Válek
   Created: 2025-08-16
   Description: Package for CRUD operations on the Person table.
*/

-- Package specification
create or replace package pkg_person as

    /*
       Adds a new person to the Person table.
       Parameters:
         p_first_name    - first name of the person
         p_last_name     - last name of the person
         p_email         - email of the person (must be unique)
         p_password_hash - password hash for the person
         p_salt          - salt for password hashing
       Returns:
         person_id of the newly created person
    */
   function add_person (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) return number;

    /*
       Updates an existing person in the Person table.
       Parameters:
         p_person_id     - ID of the person to update
         p_first_name    - new first name
         p_last_name     - new last name
         p_email         - new email
         p_password_hash - new password hash
         p_salt          - new salt
    */
   procedure update_person (
      p_person_id     in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   );

   

    /*
       Deletes a person from the Person table.
       Parameters:
         p_person_id - ID of the person to delete
    */
   procedure delete_person (
      p_person_id in number
   );

    /*
       Type for return value of get_person_by_id function.
    */
   type person_rec is record (
         person_id     number,
         first_name    varchar2(50),
         last_name     varchar2(50),
         email         varchar2(100),
         password_hash varchar2(256),
         salt          varchar2(32)
   );

    /*
       Returns person details by ID.
       Parameters:
         p_person_id - ID of the person
       Returns:
         person_rec with person details, or NULL if not found.
    */
   function get_person_by_id (
      p_person_id in number
   ) return person_rec; 


   /*
       Type for return value of login function.
   */
   type response is record (
         success boolean,
         message varchar2(4000)
   );

   /*
      Returns whether the login was successful. 
      Parameters:
         p_email    - email of the person
         p_password  - password of the person
      Returns:
         response indicating success or failure
   */
   function login_person (
      p_email    in varchar2,
      p_password in varchar2
   ) return response;

    /*
       Returns person_id by email.
       Parameters:
         p_email - email of the person
       Returns:
         person_id if found, NULL otherwise.
    */
   function get_person_id_by_email (
      p_email in varchar2
   ) return number;

   /*
       Resets the password for a user. It is method which would be called from backend/frontend
       Parameters:
         p_email        - email of the user
         p_old_password  - old password of the user
         p_new_password  - new password for the user
       Returns:
         response indicating success or failure
   */
   function user_password_reset (
      p_email        in varchar2,
      p_old_password in varchar2,
      p_new_password in varchar2
   ) return response;

    /*
       Resets the user's password. This is internal method which can be used by admin. It does not require auth.
       Parameters:
         p_email       - email of the user
         p_new_password - new password for the user
   */
   procedure password_reset (
      p_id           in number,
      p_new_password in varchar2
   );


end pkg_person;
/

-- Package body
create or replace package body pkg_person as

   function add_person (
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) return number as
      v_person_id number;
   begin
      insert into person (
         first_name,
         last_name,
         email,
         password_hash,
         salt
      ) values ( p_first_name,
                 p_last_name,
                 p_email,
                 p_password_hash,
                 p_salt ) returning person_id into v_person_id;

      dbms_output.put_line('Person added: '
                           || p_first_name
                           || ' '
                           || p_last_name
                           || ' (ID: '
                           || v_person_id
                           || ')');
      commit;
      return v_person_id;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20141,
            'Person with this email already exists: ' || p_email
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20142,
            'Invalid value or data type for Person: ' || p_first_name || ' ' || p_last_name
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20143,
            'Other error when adding Person: ' || p_first_name || ' ' || p_last_name || '. Error: ' || SQLERRM
         );
   end add_person;

   procedure update_person (
      p_person_id     in number,
      p_first_name    in varchar2,
      p_last_name     in varchar2,
      p_email         in varchar2,
      p_password_hash in varchar2,
      p_salt          in varchar2
   ) as
      v_updated number;
   begin
      update person
         set first_name = p_first_name,
             last_name = p_last_name,
             email = p_email,
             password_hash = p_password_hash,
             salt = p_salt
       where person_id = p_person_id
       returning 1 into v_updated;
      dbms_output.put_line('Person updated: ID ' || p_person_id);
      commit;
   exception
      when DUP_VAL_ON_INDEX then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20144,
            'Person with this email already exists: ' || p_email
         );
      when VALUE_ERROR then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20145,
            'Invalid value or data type for Person update: ' || p_first_name || ' ' || p_last_name
         );
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20146,
            'No person found with ID ' || p_person_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20147,
            'Other error when updating Person: ID ' || p_person_id || '. Error: ' || SQLERRM
         );
   end update_person;

   procedure delete_person (
      p_person_id in number
   ) as
      v_deleted number;
   begin
      delete from person
       where person_id = p_person_id
       returning 1 into v_deleted;
      dbms_output.put_line('Person deleted: ID ' || p_person_id);
      commit;
   exception
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20148,
            'No person found with ID ' || p_person_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20149,
            'Other error when deleting Person: ID ' || p_person_id || '. Error: ' || SQLERRM
         );
   end delete_person;

   function get_person_by_id (
      p_person_id in number
   ) return person_rec as
      v_person person_rec;
   begin
      select person_id,
             first_name,
             last_name,
             email,
             password_hash,
             salt
        into v_person
        from person
       where person_id = p_person_id;

      return v_person;
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20150,
            'No person found with ID ' || p_person_id
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20151,
            'Multiple persons found with ID ' || p_person_id
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20152,
            'Other error when reading Person: ID ' || p_person_id || '. Error: ' || SQLERRM
         );
   end get_person_by_id;

   function login_person (
      p_email    in varchar2,
      p_password in varchar2
   ) return response as
      v_person_id             number;
      v_person                person_rec;
      v_input_hashed_password varchar2(256);
      v_response              response;
   begin
      v_person_id := get_person_id_by_email(p_email);
      v_person := get_person_by_id(v_person_id);
      v_input_hashed_password := pkg_utils.hash_password(
         p_password,
         v_person.salt
      );
      
      if v_input_hashed_password = v_person.password_hash then
         v_response.success := true;
         v_response.message := 'Login successful.';
      else
         v_response.success := false;
         v_response.message := 'Invalid email or password.';
      end if;

      return v_response;
   exception
      when OTHERS then
         v_response.success := false;
         v_response.message := 'Unexpected error during login: ' || SQLERRM;
         return v_response;
   end login_person;

   function get_person_id_by_email (
      p_email in varchar2
   ) return number as
      v_person_id number;
   begin
      select person_id
        into v_person_id
        from person
       where email = p_email;
      return v_person_id;
   exception
      when NO_DATA_FOUND then
         RAISE_APPLICATION_ERROR(
            -20153,
            'No person found with email ' || p_email
         );
      when TOO_MANY_ROWS then
         RAISE_APPLICATION_ERROR(
            -20154,
            'Multiple persons found with email ' || p_email
         );
      when OTHERS then
         RAISE_APPLICATION_ERROR(
            -20155,
            'Other error when reading person by email: ' || p_email || '. Error: ' || SQLERRM
         );
   end get_person_id_by_email;

   function user_password_reset (
      p_email        in varchar2,
      p_old_password in varchar2,
      p_new_password in varchar2
   ) return response as
      v_person_id number;
      v_person person_rec;
      v_old_hashed varchar2(256);
      v_new_hashed varchar2(256);
      v_response response;
   begin
      v_person_id := get_person_id_by_email(p_email);
      if v_person_id is null then
         v_response.success := false;
         v_response.message := 'User not found.';
         return v_response;
      end if;

      v_person := get_person_by_id(v_person_id);
      v_old_hashed := pkg_utils.hash_password(p_old_password, v_person.salt);

      if v_old_hashed != v_person.password_hash then
         v_response.success := false;
         v_response.message := 'Old password is incorrect.';
         return v_response;
      end if;

      v_new_hashed := pkg_utils.hash_password(p_new_password, v_person.salt);

      update person
         set password_hash = v_new_hashed
       where person_id = v_person_id
       returning 1 into v_person_id;
      commit;

      v_response.success := true;
      v_response.message := 'Password reset successful.';
      return v_response;
   exception
      when NO_DATA_FOUND then
         rollback;
         v_response.success := false;
         v_response.message := 'No person found with email ' || p_email;
         return v_response;
      when OTHERS then
         rollback;
         v_response.success := false;
         v_response.message := 'Unexpected error during password reset: ' || SQLERRM;
         return v_response;
   end user_password_reset;

   procedure password_reset (
      p_id           in number,
      p_new_password in varchar2
   ) as
      v_person person_rec;
      v_new_hashed varchar2(256);
      v_updated number;
   begin
      begin
         v_person := get_person_by_id(p_id);
         if v_person.person_id is null then
            dbms_output.put_line('No person found with ID ' || p_id);
            return;
         end if;
      exception
         when OTHERS then
            dbms_output.put_line('No person found with ID ' || p_id);
            return;
      end;

      v_new_hashed := pkg_utils.hash_password(p_new_password, v_person.salt);

      update person
         set password_hash = v_new_hashed
       where person_id = p_id
       returning 1 into v_updated;
      dbms_output.put_line('Password reset for person ID ' || p_id);
      commit;
   exception
      when NO_DATA_FOUND then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20156,
            'No person found with ID ' || p_id
         );
      when OTHERS then
         rollback;
         RAISE_APPLICATION_ERROR(
            -20157,
            'Unexpected error during password reset for person ID ' || p_id || '. Error: ' || SQLERRM
         );
   end password_reset;

end pkg_person;
/