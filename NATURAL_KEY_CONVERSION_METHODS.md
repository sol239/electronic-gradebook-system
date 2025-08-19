# Natural Key to Artificial ID Conversion Methods

This document summarizes the conversion methods added to package files to translate natural keys to artificial IDs for tables that have both artificial and natural keys.

## Overview

When a table has both an artificial key (auto-incrementing identity column) and a natural key (unique constraint), these methods allow you to convert from the natural key to the artificial ID.

## Added Methods

### 1. Person Package (`pkg_person.sql`)
**Method:** `get_person_id_by_email(p_email in varchar2) return number`
- **Natural Key:** `email` (unique constraint: `uq_person_email`)
- **Artificial Key:** `person_id`
- **Usage:** Convert email address to person ID
- **Returns:** `person_id` if found, `NULL` otherwise

### 2. Subject Package (`pkg_subject.sql`)
**Method:** `get_subject_id_by_name(p_name in varchar2) return number`
- **Natural Key:** `name` (unique constraint: `uq_subject_name`)
- **Artificial Key:** `subject_id`
- **Usage:** Convert subject name to subject ID
- **Returns:** `subject_id` if found, `NULL` otherwise

### 3. Class Package (`pkg_class.sql`)
**Method:** `get_class_id_by_name(p_name in varchar2) return number`
- **Natural Key:** `name` (unique constraint: `uq_class_name`)
- **Artificial Key:** `class_id`
- **Usage:** Convert class name to class ID
- **Returns:** `class_id` if found, `NULL` otherwise

### 4. Classroom Package (`pkg_classroom.sql`)
**Method:** `get_classroom_id_by_name(p_name in varchar2) return number`
- **Natural Key:** `name` (unique constraint: `uq_classroom_name`)
- **Artificial Key:** `classroom_id`
- **Usage:** Convert classroom name to classroom ID
- **Returns:** `classroom_id` if found, `NULL` otherwise

### 5. Grade Group Package (`pkg_grade_group.sql`)
**Method:** `get_grade_group_id_by_natural_key(p_subject_id in number, p_teacher_id in number, p_grade_group_date in timestamp, p_name in varchar2) return number`
- **Natural Key:** `(subject_id, teacher_id, grade_group_date, name)` (composite unique constraint: `uq_grade_group`)
- **Artificial Key:** `grade_group_id`
- **Usage:** Convert natural key components to grade group ID
- **Returns:** `grade_group_id` if found, `NULL` otherwise

### 6. Lecture Package (`pkg_lecture.sql`)
**Method:** `get_lecture_id_by_natural_key(p_subject_id in number, p_classroom_id in number, p_start_time in timestamp) return number`
- **Natural Key:** `(subject_id, classroom_id, start_time)` (composite unique constraint: `uq_lecture_subject_id_classroom_id_start_time`)
- **Artificial Key:** `lecture_id`
- **Usage:** Convert natural key components to lecture ID
- **Returns:** `lecture_id` if found, `NULL` otherwise

### 7. Class Group Package (`pkg_class_group.sql`)
**Method:** `get_class_group_id_by_natural_key(p_class_id in number, p_group_name in varchar2) return number`
- **Natural Key:** `(class_id, group_name)` (composite unique constraint: `uq_class_group`)
- **Artificial Key:** `class_group_id`
- **Usage:** Convert natural key components to class group ID
- **Returns:** `class_group_id` if found, `NULL` otherwise

## Implementation Details

All methods follow a consistent pattern:
1. **Input Parameters:** Natural key components (single value for simple constraints, multiple values for composite constraints)
2. **Return Value:** Artificial ID (primary key) if found, `NULL` if not found
3. **Error Handling:** Proper exception handling with meaningful error messages
4. **Performance:** Direct SELECT queries using the unique constraint indexes

## Usage Examples

```sql
-- Get person ID by email
DECLARE
    v_person_id NUMBER;
BEGIN
    v_person_id := pkg_person.get_person_id_by_email('john.doe@example.com');
    IF v_person_id IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Person ID: ' || v_person_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Person not found');
    END IF;
END;
/

-- Get subject ID by name
DECLARE
    v_subject_id NUMBER;
BEGIN
    v_subject_id := pkg_subject.get_subject_id_by_name('Mathematics');
    IF v_subject_id IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Subject ID: ' || v_subject_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Subject not found');
    END IF;
END;
/

-- Get grade group ID by natural key components
DECLARE
    v_grade_group_id NUMBER;
BEGIN
    v_grade_group_id := pkg_grade_group.get_grade_group_id_by_natural_key(
        1, -- subject_id
        2, -- teacher_id
        TIMESTAMP '2025-01-15 09:00:00', -- grade_group_date
        'Midterm Exam' -- name
    );
    IF v_grade_group_id IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Grade Group ID: ' || v_grade_group_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Grade Group not found');
    END IF;
END;
/
```

## Benefits

1. **Data Integrity:** Ensures referential integrity when working with natural keys
2. **Performance:** Leverages unique constraint indexes for fast lookups
3. **Consistency:** Standardized approach across all packages
4. **Error Handling:** Proper exception handling with meaningful error messages
5. **Maintainability:** Centralized logic for key conversions

## Notes

- All methods return `NULL` when no matching record is found (instead of raising exceptions)
- Error codes are unique across packages to avoid conflicts
- Methods are designed to be efficient and use existing database indexes
- The person package already had the `get_person_id_by_email` method, so no changes were needed there
