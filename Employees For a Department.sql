-----------------------------------------------------------------------
-- Name: Mike Powell
-- Date: 13/06/2021
-- Description: Script to return employee's for a department 
-- Version History
-- 1.0 - Initial script created
-- 
--  This could of been done with Oracle Reports or some Other method.
-----------------------------------------------------------------------
SELECT ME.EMPLOYEE_ID, ME.EMPLOYEE_NAME, ME.JOB_TITLE, ME.MANAGER_ID, ME.DATE_HIRED, ME.SALARY, TD.DEPARTMENT_ID, TD.DEPARTMENT_NAME, TD.LOCATION 
FROM M_EMPLOYEES ME, T_DEPARTMENTS TD
WHERE 1=1
AND ME.DEPARTMENT_ID = TD.DEPARTMENT_ID
AND TD.DEPARTMENT_ID = 1
ORDER BY ME.EMPLOYEE_ID;