-----------------------------------------------------------------------
-- Name: Mike Powell
-- Date: 12/06/2021
-- Description: Script to populate m_employees
-- Version History
-- 1.0 - Initial insert script created
-- 
--  This could of been done by importing all Records from an Excel Sheet or some other datasource.
-----------------------------------------------------------------------
DECLARE
    m_iCommit INT:= 0;
BEGIN
    DBMS_OUTPUT.DISABLE;
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('Inserting Employee Data');

    INSERT INTO m_employees (employee_name, job_title, manager_id, date_hired, salary, department_id) values('John Smith', 'CEO',NULL,to_date('01/01/1995','dd/mm/yyyy'), 100000, 1);
    INSERT INTO m_employees (employee_name, job_title, manager_id, date_hired, salary, department_id) values('Jimmy Willis', 'Manager', 90001,to_date('23/09/2003','dd/mm/yyyy'), 52500, 4);
    INSERT INTO m_employees (employee_name, job_title, manager_id, date_hired, salary, department_id) values('Roxy Jones', 'Salesperson',90002,to_date('11/02/2017','dd/mm/yyyy'), 35000, 4);
    INSERT INTO m_employees (employee_name, job_title, manager_id, date_hired, salary, department_id) values('Selwyn Field', 'Salesperson',90003,to_date('20/05/2015','dd/mm/yyyy'), 32000, 4);
    INSERT INTO m_employees (employee_name, job_title, manager_id, date_hired, salary, department_id) values('David Hallett', 'Engineer',90006,to_date('17/04/2018','dd/mm/yyyy'), 40000, 2);
    INSERT INTO m_employees (employee_name, job_title, manager_id, date_hired, salary, department_id) values('Sarah Phelps', 'Manager',90001,to_date('21/03/2015','dd/mm/yyyy'), 45000, 2);
    INSERT INTO m_employees (employee_name, job_title, manager_id, date_hired, salary, department_id) values('Louise Harper', 'Engineer',90006,to_date('01/01/2013','dd/mm/yyyy'), 47000, 2);
    INSERT INTO m_employees (employee_name, job_title, manager_id, date_hired, salary, department_id) values('Tina Hart', 'Engineer',90009,to_date('28/07/2014','dd/mm/yyyy'), 45000, 3);
    INSERT INTO m_employees (employee_name, job_title, manager_id, date_hired, salary, department_id) values('Gus Jones', 'Manager',90001,to_date('15/05/2018','dd/mm/yyyy'), 50000, 3);
    INSERT INTO m_employees (employee_name, job_title, manager_id, date_hired, salary, department_id) values('Mildred Hall', 'Secretary',90001,to_date('12/10/1996','dd/mm/yyyy'), 35000, 1);

    IF m_iCommit = 1 THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END;

--select * from M_EMPLOYEES ORDER BY 7, 1;
--delete from M_EMPLOYEES;