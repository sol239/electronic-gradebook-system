/*
   File: create_schema.sql
   Author: David Válek
   Description: Creates entire schema.
   Created: 2025-08-15
   TODO: Maybe it shall be in create_commands.sql...
*/
@create_commands/create_tables.sql
@create_commands/create_sequences.sql
@create_commands/create_packages.sql

BEGIN
	dbms_output.put_line('Schema created successfully.');
END;
/

