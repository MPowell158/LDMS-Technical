-----------------------------------------------------------------------
-- Name: Mike Powell
-- Date: 12/06/2021
-- Description: Script to create or alter stored proc sp_transfer_department to change an employees department
-- Version History
-- 1.0 - Initial script created
-- 
-----------------------------------------------------------------------
CREATE OR REPLACE procedure sp_transfer_department(id_in IN INT, department_in IN INT) AS
    m_employee_count INT:= 0;
    m_department_count INT:= 0;
BEGIN
    SELECT COUNT(*) INTO m_employee_count FROM M_EMPLOYEES WHERE 1=1 AND EMPLOYEE_ID = id_in;
    IF (m_employee_count = 0) THEN
        raise_application_error(-20001,'Invalid Employee');
    END IF;

    SELECT COUNT(*) INTO m_department_count FROM T_DEPARTMENTS WHERE 1=1 AND DEPARTMENT_ID = department_in;
    IF (m_department_count = 0) THEN
        raise_application_error(-20001,'Invalid Department');
    END IF;

    UPDATE M_EMPLOYEES
    SET DEPARTMENT_ID = department_in
    WHERE 1=1
    AND EMPLOYEE_ID = id_in;

    IF SQL%rowcount != 1 THEN
        ROLLBACK;
        raise_application_error(-20001,'More than 1 row updated');
    END IF;
END;

--CALL sp_transfer_department(90001, 1);
--select * From M_EMPLOYEES ORDER BY 7, 1;