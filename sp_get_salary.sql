-----------------------------------------------------------------------
-- Name: Mike Powell
-- Date: 12/06/2021
-- Description: Script to create or alter stored proc sp_get_salary return an employee's salary
-- Version History
-- 1.0 - Initial script created
-- 
-- This could also be done as a function which would only take 1 input of id and return the salary with a return command.
-----------------------------------------------------------------------
CREATE OR REPLACE procedure sp_get_salary(id_in IN INT, salary_out OUT NUMBER) AS
    m_employee_count INT:= 0;
BEGIN
    SELECT COUNT(*) INTO m_employee_count FROM M_EMPLOYEES WHERE 1=1 AND EMPLOYEE_ID = id_in;
    IF (m_employee_count = 0) THEN
        raise_application_error(-20001,'Invalid Employee');
    END IF;

    SELECT SALARY INTO salary_out FROM M_EMPLOYEES WHERE 1=1 AND EMPLOYEE_ID = id_in;
END;

/*
DECLARE
    m_salary_out NUMBER:=0;
BEGIN
    sp_get_salary(90001, m_salary_out);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || m_salary_out);
END;
*/
--select * From M_EMPLOYEES ORDER BY 7, 1;