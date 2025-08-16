# Database Structure Changes - Summary

## Author: David Válek
## Date: 2025-08-16

### Overview
This document summarizes the major structural changes made to normalize the database schema using a central Person table with polymorphic associations.

### Key Changes Made

#### 1. Person Table (tbl_person.sql)
- **NEW FIELDS ADDED:**
  - `role_type` VARCHAR2(20) NOT NULL CHECK (role_type IN ('TEACHER', 'STUDENT', 'PARENT'))
  - `role_id` NUMBER NOT NULL
- **PURPOSE:** Central repository for all personal information with polymorphic association to role-specific tables

#### 2. Teacher Table (tbl_teacher.sql)
- **SIMPLIFIED STRUCTURE:**
  - Removed: `first_name`, `last_name`, `email`, `password_hash`, `salt`
  - Kept: `teacher_id` (PK), `person_id` (FK to Person table)
- **NEW CONSTRAINT:** Foreign key to Person table

#### 3. Student Table (tbl_student.sql)
- **SIMPLIFIED STRUCTURE:**
  - Removed: `first_name`, `last_name`, `date_of_birth`, `email`, `password_hash`, `salt`
  - Kept: `student_id` (PK), `person_id` (FK to Person table), `class_id` (FK)
- **NEW CONSTRAINT:** Foreign key to Person table

#### 4. Parent Table (tbl_parent.sql)
- **SIMPLIFIED STRUCTURE:**
  - Removed: `first_name`, `last_name`, `email`, `password_hash`, `salt`
  - Kept: `parent_id` (PK), `person_id` (FK to Person table)
- **NEW CONSTRAINT:** Foreign key to Person table

### Package Updates

#### 1. pkg_person.sql (NEW)
- **NEW PACKAGE:** Complete CRUD operations for Person table
- **KEY FEATURES:**
  - Handles role_type and role_id for polymorphic associations
  - Includes validation for role types

#### 2. pkg_student.sql (UPDATED)
- **NEW APPROACH:** Creates Person record first, then Student record
- **KEY CHANGES:**
  - `add_student()` now returns student_id and manages both tables
  - All personal info updates go through Person table
  - Maintains referential integrity between tables

#### 3. pkg_teacher.sql (UPDATED)
- **NEW APPROACH:** Creates Person record first, then Teacher record
- **KEY CHANGES:**
  - `add_teacher()` now returns teacher_id and manages both tables
  - All personal info updates go through Person table
  - Maintains referential integrity between tables

#### 4. pkg_parent.sql (UPDATED)
- **NEW APPROACH:** Creates Person record first, then Parent record
- **KEY CHANGES:**
  - `add_parent()` now returns parent_id and manages both tables
  - All personal info updates go through Person table
  - Maintains referential integrity between tables

### View Updates

#### 1. vw_teacher_subject.sql
- **UPDATED:** Now joins with Person table to get teacher information
- **ADDED:** Email field and role_type filter

#### 2. vw_student_grade.sql
- **UPDATED:** Now joins with Person table to get student information
- **ADDED:** Email field and role_type filter

#### 3. vw_class.sql
- **UPDATED:** Now joins with Person table to get teacher information
- **ADDED:** Email field and role_type filter

### Demo Data

#### 1. 02_create_demo_data_new.sql (NEW)
- **PURPOSE:** Demonstrates the new normalized structure
- **USES:** New package procedures for data creation
- **CREATES:** Sample teachers, parents, and students using the new approach

### Benefits of New Structure

1. **Data Normalization:** Eliminates redundancy by centralizing personal information
2. **Consistency:** Single source of truth for all personal data
3. **Referential Integrity:** Strong relationships between Person and role tables
4. **Flexibility:** Easy to add new role types without duplicating person fields
5. **Maintainability:** Changes to personal information structure only affect Person table

### Migration Considerations

1. **Existing Data:** Would need migration script to move data from role tables to Person table
2. **Applications:** Any direct queries to role tables for personal info need updating
3. **Constraints:** New foreign key constraints ensure data integrity
4. **Performance:** Joins required for personal info, but improved with proper indexing

### Next Steps

1. Test the new structure with the demo data
2. Create migration scripts for existing data (if needed)
3. Update any remaining database objects that reference the old structure
4. Consider adding indexes on Person.role_type and Person.role_id for performance
5. Update application code to use the new package procedures
