
-- Drop  database IF EXISTS HUMAN_RESOURCE;
-- Create  database HUMAN_RESOURCE;
-- Use HUMAN_RESOURCE;

DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS DEPARTMENT;

CREATE TABLE DEPARTMENT (
   DEPT_ID INT AUTO_INCREMENT PRIMARY KEY,
   DEPT_NAME VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO DEPARTMENT (DEPT_NAME) VALUES ('Finance');
INSERT INTO DEPARTMENT (DEPT_NAME) VALUES ('Marketing');

CREATE TABLE EMPLOYEE(
   EMP_ID VARCHAR(10) PRIMARY KEY,
   FIRST_NAME VARCHAR(50) NOT NULL,
   LAST_NAME VARCHAR(50) NOT NULL,
   DEPT_ID INT,
   CONSTRAINT FK_DEPT_ID  
		FOREIGN KEY (DEPT_ID) 
        REFERENCES DEPARTMENT(DEPT_ID)
		ON UPDATE CASCADE
		ON DELETE SET NULL
);

INSERT INTO EMPLOYEE VALUES ('1234567891', 'Tina', 'Smith', 1);
INSERT INTO EMPLOYEE VALUES ('1234567892', 'Tony', 'Brown', 2);

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;



