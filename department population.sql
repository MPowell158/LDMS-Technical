-----------------------------------------------------------------------
-- Name: Mike Powell
-- Date: 12/06/2021
-- Description: Script to populate t_departments
-- Version History
-- 1.0 - Initial insert script created
-- 
-- This could of been done by importing all Records from an Excel Sheet or some other datasource.
-----------------------------------------------------------------------
SET define OFF;
DECLARE
    m_iCommit INT:= 0;
BEGIN
    INSERT INTO t_departments (department_name, location) values('Management', 'London');
    INSERT INTO t_departments (department_name, location) values('Engineering', 'Cardiff');
    INSERT INTO t_departments (department_name, location) values('Research & Development', 'Edinburgh');
    INSERT INTO t_departments (department_name, location) values('Sales', 'Belfast');

    IF m_iCommit = 1 THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END;

--SELECT * FROM T_DEPARTMENTS;
--DELETE FROM T_DEPARTMENTS;