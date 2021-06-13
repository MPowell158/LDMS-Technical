-----------------------------------------------------------------------
-- Name: Mike Powell
-- Date: 13/06/2021
-- Description: Script to Create and populate all tables and stored procedures.
-- Version History
-- 1.0 - Initial script created
--  
--  
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
/
SET define OFF;
BEGIN
    INSERT INTO t_departments (department_name, location) values('Management', 'London');
    INSERT INTO t_departments (department_name, location) values('Engineering', 'Cardiff');
    INSERT INTO t_departments (department_name, location) values('Research & Development', 'Edinburgh');
    INSERT INTO t_departments (department_name, location) values('Sales', 'Belfast');
END;
/
SET define ON;
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
/
DECLARE
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
END;
/
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
/
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
/
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
/
CREATE OR REPLACE procedure sp_get_salary(id_in IN INT, salary_out OUT NUMBER) AS
    m_employee_count INT:= 0;
BEGIN
    SELECT COUNT(*) INTO m_employee_count FROM M_EMPLOYEES WHERE 1=1 AND EMPLOYEE_ID = id_in;
    IF (m_employee_count = 0) THEN
        raise_application_error(-20001,'Invalid Employee');
    END IF;

    SELECT SALARY INTO salary_out FROM M_EMPLOYEES WHERE 1=1 AND EMPLOYEE_ID = id_in;
END;