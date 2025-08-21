/*
    File: 07_reset_schema.sql
    Author: David Válek
    Created: 2025-08-15
    Description: Script for resetting the schema = Deleting schema with data -> Recreating schema with fresh demo data
*/

@05_delete_schema.sql
@04_delete_stats.sql
@01_create_schema.sql
@03_create_stats.sql
@02_create_demo_data.sql


