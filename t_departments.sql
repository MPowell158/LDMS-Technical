-----------------------------------------------------------------------
-- Name: Mike Powell
-- Date: 12/06/2021
-- Description: Script to Create t_departments to hold information about departments
-- Version History
-- 1.0 - Initial Create script created
--  Handful of index's added for future use
--  Additional fields can be added to allow maintaining of history (i.e. Date Fields / Status fields).
-----------------------------------------------------------------------
DECLARE
    m_count INT:= 0;

BEGIN
    DBMS_OUTPUT.DISABLE;
    DBMS_OUTPUT.ENABLE;

    SELECT COUNT(*) INTO m_count FROM USER_ALL_TABLES WHERE 1=1 AND UPPER(TABLE_NAME) LIKE 'T_DEPARTMENTS';

    IF m_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Creating t_departments table');

        EXECUTE IMMEDIATE ('CREATE TABLE t_departments
                            (
                                department_id INT GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
                                department_name VARCHAR2(50) NOT NULL,
                                location VARCHAR2(50) NOT NULL,
                                CONSTRAINT pk_department_id PRIMARY KEY(department_id)
                            )');

        EXECUTE IMMEDIATE ('CREATE INDEX m_departments_name_idx on t_departments(department_name)');
        EXECUTE IMMEDIATE ('CREATE INDEX m_departments_location_idx on t_departments(location)');

    END IF;
END;


--SELECT * FROM t_departments;
--drop table t_departments;