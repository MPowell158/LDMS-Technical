-----------------------------------------------------------------------
-- Name: Mike Powell
-- Date: 13/06/2021
-- Description: Script to return total salary for a department 
-- Version History
-- 1.0 - Initial script created
-- 
--  This could of been done with Oracle Reports or some Other method.
-----------------------------------------------------------------------
SELECT TD.DEPARTMENT_ID, SUM(ME.SALARY)
FROM M_EMPLOYEES ME, T_DEPARTMENTS TD
WHERE 1=1
AND ME.DEPARTMENT_ID = TD.DEPARTMENT_ID
AND TD.DEPARTMENT_ID = 1
GROUP BY TD.DEPARTMENT_ID;