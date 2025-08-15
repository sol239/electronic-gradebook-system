/*
   File: trg_parent_password.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Trigger to automatically hash parent passwords on insert/update with salt
*/

create or replace trigger trg_parent_biur before
   insert or update of password on parent
   for each row
begin
    -- If the new password is not null
   if :new.password is not null then
        -- Generate a new random salt
      :new.salt := pkg_utils.random_salt(16);

        -- Hash the password together with the salt
      :new.password := pkg_utils.hash_password(
         :new.password,
         :new.salt
      );
   end if;
end trg_parent_biur;
/