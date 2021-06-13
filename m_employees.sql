-----------------------------------------------------------------------
-- Name: Mike Powell
-- Date: 12/06/2021
-- Description: Script to Create m_employees to hold information about employees
-- Version History
-- 1.0 - Initial Create script created
--  Handful of index's added for future use
--  Additional fields can be added to allow maintaining of history (i.e. Date Fields / Status fields).
--  employee_id could be defined as a self increment
-----------------------------------------------------------------------
DECLARE
    m_count INT:= 0;

BEGIN
    DBMS_OUTPUT.DISABLE;
    DBMS_OUTPUT.ENABLE;

    SELECT COUNT(*) INTO m_count FROM USER_ALL_TABLES WHERE 1=1 AND UPPER(TABLE_NAME) LIKE 'M_EMPLOYEES';

    IF m_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Creating m_employees table');

        EXECUTE IMMEDIATE ('CREATE TABLE m_employees
                            (
                                employee_id INT GENERATED ALWAYS as IDENTITY(START with 90001 INCREMENT by 1),
                                employee_name VARCHAR2(50),
                                job_title VARCHAR2(50),
                                manager_id INT,
                                date_hired DATE,
                                salary NUMBER,
                                department_id INT,
                                CONSTRAINT pk_employee_id PRIMARY KEY(employee_id)
                            )');

        EXECUTE IMMEDIATE ('CREATE INDEX m_employees_name_idx on m_employees(employee_name)');
        EXECUTE IMMEDIATE ('CREATE INDEX m_employees_job_title_idx on m_employees(job_title)');
        EXECUTE IMMEDIATE ('CREATE INDEX m_employees_manager_id_idx on m_employees(manager_id)');
        EXECUTE IMMEDIATE ('CREATE INDEX m_employees_department_id_idx on m_employees(department_id)');

    END IF;
END;


--SELECT * FROM m_employees;
--drop table m_employees;