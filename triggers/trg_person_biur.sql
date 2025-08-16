/*
   File: trg_person_biur.sql
   Author: David Válek
   Created: 2025-08-16
   Description: Trigger to automatically hash person passwords on insert/update with salt
*/

create or replace trigger trg_person_biur before
   insert or update of password_hash on person
   for each row
begin
    -- If the new password is not null
   if :new.password_hash is not null then
        -- Generate a new random salt
      :new.salt := pkg_utils.random_salt(16);

        -- Hash the password together with the salt
      :new.password_hash := pkg_utils.hash_password(
         :new.password_hash,
         :new.salt
      );
   end if;
end trg_person_biur;
/
