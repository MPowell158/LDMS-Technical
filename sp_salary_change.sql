-----------------------------------------------------------------------
-- Name: Mike Powell
-- Date: 12/06/2021
-- Description: Script to create or alter stored proc sp_salary_change to change an employees salary by a %
-- Version History
-- 1.0 - Initial script created
-- 
-----------------------------------------------------------------------
CREATE OR REPLACE procedure sp_salary_change(id_in IN INT, salary_change_in IN NUMBER) AS
    m_salary number:= 0.0;
    m_employee_count INT:= 0;
BEGIN
    SELECT COUNT(*) INTO m_employee_count FROM M_EMPLOYEES WHERE 1=1 AND EMPLOYEE_ID = id_in;
    IF (m_employee_count = 0) THEN
        raise_application_error(-20001,'Invalid Employee');
    END IF;

    SELECT SALARY INTO m_salary FROM M_EMPLOYEES WHERE 1=1 AND EMPLOYEE_ID = id_in;

    m_salary:= m_salary + (m_salary * salary_change_in / 100);

    UPDATE M_EMPLOYEES
    SET SALARY = m_salary
    WHERE 1=1
    AND EMPLOYEE_ID = id_in;

    IF SQL%rowcount != 1 THEN
        ROLLBACK;
        raise_application_error(-20001,'More than 1 row updated');
    END IF;

END;

--CALL sp_salary_change(90001, 5.0);
--select * From M_EMPLOYEES ORDER BY 7, 1;