/*
   File: trg_parent_password.sql
   Author: David Válek
   Created: 2025-08-15
   Description: Trigger to automatically hash parent passwords on insert/update with salt
*/

CREATE OR REPLACE TRIGGER TRG_PARENT_BIUR
    BEFORE INSERT OR UPDATE OF password ON parent
    FOR EACH ROW
BEGIN
    -- If the new password is not null
    IF :NEW.password IS NOT NULL THEN
        -- Generate a new random salt
        :NEW.salt := pkg_utils.random_salt(16);

        -- Hash the password together with the salt
        :NEW.password := pkg_utils.hash_password(:NEW.password, :NEW.salt);
    END IF;
END TRG_PARENT_BIUR;
/
