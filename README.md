# Electronic gradebook system

## Overview

This project is designed to create an electronic gradebook system for primary and secondary schools using **Oracle SQL**. The system aims to manage student records, grades, schedules, and other related functionalities.

---

### Folder Structure

- `create_commands/`: Contains SQL scripts for creating database objects
- `packages/`: pkg_<package_name>.sql
- `tables/`: tbl_<table_name>.sql
- `triggers/`: trg_<trigger_name>_<trigger_type>.sql
- `views/`: vw_<view_name>.sql

---

### How to start Oracle DB locally

```shell
net start OracleOraDB21Home1TNSListener
sqlplus / as sysdba
startup;
```

---

### Scripts

- `01_create_schema.sql`: Creates the initial database schema, including tables, views, and other objects.
- `02_create_demo_data.sql`: Inserts demo data into the database for testing purposes.
- `03_create_stats.sql`: Creates database statistics for query optimization.
- `04_delete_stats.sql`: Deletes database statistics.
- `05_delete_schema.sql`: Deletes the database schema and all associated objects.
- `06_test_script.sql`: Contains demonstration of views and procedures/functions.
- `07_reset_schema.sql`: Resets the database schema to its initial state.

--- 

### Schema

You can find schema of the database in `./schema.png`.

---

## Contact

Feel free to reach me at [david.valek17@gmail.com](mailto:david.valek17@gmail.com).
