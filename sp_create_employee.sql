-----------------------------------------------------------------------
-- Name: Mike Powell
-- Date: 12/06/2021
-- Description: Script to create or alter stored proc sp_create_employee to create a new employee
-- Version History
-- 1.0 - Initial script created
-- 
-----------------------------------------------------------------------
CREATE OR REPLACE procedure sp_create_employee(name_in IN VARCHAR2, title_in IN VARCHAR2, manager_in IN INT, salary_in IN NUMBER, department_in IN INT) AS
    m_department_count INT:= 0;
BEGIN

    SELECT COUNT(*) INTO m_department_count FROM T_DEPARTMENTS WHERE 1=1 AND DEPARTMENT_ID = department_in;
    IF (m_department_count = 0) THEN
        raise_application_error(-20001,'Invalid Department');
    END IF;

    IF (salary_in < 0) THEN
        raise_application_error(-20001,'Invalid Salary');
    END IF;

    INSERT INTO m_employees (employee_name, job_title, manager_id, date_hired, salary, department_id) values(name_in, title_in, manager_in,to_date(SYSDATE,'dd/mm/yyyy'), salary_in, department_in);
END;

--CALL sp_create_employee('TestName', 'TestTitle', 90001, 50000, 4);
--select * From M_EMPLOYEES ORDER BY 7, 1;