/*
SELF JOIN example  -- it is a table joins to itself
- parent and child relationship: a parent is also a person record in the table
- suppervisor relationship: a supervisor is an employyee
*/

DROP TABLE IF EXISTS EMPLOYEE;
CREATE TABLE EMPLOYEE (
	ID INT NOT NULL PRIMARY KEY, 
    FIRST_NAME VARCHAR(50) NOT NULL,
    LAST_NAME VARCHAR(50) NOT NULL,
    SUPERVISOR_ID INT NOT NULL,
    START_DATE INT NOT NULL   /* Notice the start date is of INT and not DATE data type. Why?*/
);

INSERT INTO EMPLOYEE VALUES
(1, 'Kelly', 'Clark', 3, 20200912)
,(2, 'Hassan', 'Summer', 3, 20200501)
,(3, 'Helen', 'Park', 3, 20140120)  
,(4, 'Joe', 'Stones', 1, 20220115)
,(5, 'Mike', 'Younge', 1, 20230825)
;

-- 1) Select a list of employees together with their managers  (regular WHERE clause)
SELECT E.FIRST_NAME, E.LAST_NAME, S.FIRST_NAME AS MGR_FIRST_NAME, S.LAST_NAME AS MGR_LAST_NAME
FROM EMPLOYEE E, EMPLOYEE S 
WHERE E.SUPERVISOR_ID = S.ID;

-- 2) Select a list of managers together with their employees
SELECT E.FIRST_NAME AS MGR_FIRST_NAME, E.LAST_NAME AS MGR_LAST_NAME, S.FIRST_NAME, S.LAST_NAME 
FROM EMPLOYEE E, EMPLOYEE S 
WHERE E.ID = S.SUPERVISOR_ID;

-- 3) Select a list of employees together with their managers (SELF JOIN)
SELECT E.FIRST_NAME, E.LAST_NAME, S.FIRST_NAME AS MGR_FIRST_NAME, S.LAST_NAME AS MGR_LAST_NAME
FROM EMPLOYEE E 
JOIN EMPLOYEE S 
ON S.ID = E.SUPERVISOR_ID;

-- 4) who is on top of the hierarchy? 
SELECT E.FIRST_NAME, E.LAST_NAME, S.FIRST_NAME AS MGR_FIRST_NAME, S.LAST_NAME AS MGR_LAST_NAME
FROM EMPLOYEE E, EMPLOYEE S 
WHERE E.SUPERVISOR_ID = S.ID 
AND E.FIRST_NAME = S.FIRST_NAME 
AND E.FIRST_NAME = S.FIRST_NAME;

-- 5) Individual contributors 
SELECT * FROM  EMPLOYEE
WHERE ID NOT IN (SELECT DISTINCT (SUPERVISOR_ID) FROM EMPLOYEE);


