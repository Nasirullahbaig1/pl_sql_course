--PROCEDURE IN PL/SQL
--PL/SQL  procedures are reusable code block that perform specific actions or logic within a database environment.
--Mainly it has two parts PROCEDURE HEADER and PROCEDURE BODY.

--There are two type of procedures
--LOCAL PROCEDURE(ANNOYMOUS OR UNNAMED):
    --As it local it execute in the same session due to which
        --Intialization of procedure
        --Calling of procedure
    --To be done in same program
    
--STORED PROCEDURE(NAMED PROCEDURE):
    --As it stored so it can be stored & can easily executes later on
        --Initilization of procedure
        --Calling of procedure
    --Can be done differently

--Example of Local procedure
SET SERVEROUT ON
DECLARE
    NUM1 NUMBER(2);
    NUM2 NUMBER(2);
    MUL NUMBER(4);
    
    PROCEDURE MULTIPLICATION (NUM1 IN NUMBER, NUM2 IN NUMBER, MUL OUT NUMBER) IS
BEGIN
    MUL:= NUM1 * NUM2;   
END MULTIPLICATION;
    
--CALLING PROCEDURE
BEGIN
    NUM1:=&NUM1;
    NUM2:=&NUM2;
    MULTIPLICATION (NUM1, NUM2, MUL);
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' * ' || NUM2 || ' = ' || MUL);
END;
/

--Example of Stored procedure
CREATE OR REPLACE PROCEDURE ADDITION (NUM1 IN NUMBER, NUM2 IN NUMBER, SUM1 OUT NUMBER) IS
BEGIN
SUM1:=NUM1 + NUM2;
END;
/
--CALLING THE PROCEDURE
DECLARE
    NUM1 NUMBER(2);
    NUM2 NUMBER(2);
    SUM1 NUMBER(4);
BEGIN
    NUM1:=&NUM1;
    NUM2:=&NUM2;
    ADDITION(NUM1, NUM2, SUM1);
DBMS_OUTPUT.PUT_LINE(NUM1 || ' + '|| NUM2 || ' = ' || SUM1);
END;
/
/
CREATE OR REPLACE PROCEDURE MY_FIRST_PROC
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END MY_FIRST_PROC;
/

SET SERVEROUT ON
BEGIN
    MY_FIRST_PROC;
END;
/

--METADATA & DROP PROCEDURE
--DATA DICTIONARY VIEWS OF THE PROCEDURE:
    --USER_PROCEDURE, ALL_PROCEDURE
    --USER_SOURCE, ALL_SOURCE, DBA_SOURCE
--To drop procedure, use DROP PROCEDURE procedure_name;
/
SELECT * FROM USER_PROCEDURES;
/
SELECT * FROM USER_SOURCE WHERE TYPE LIKE '%PROCEDURE';
/
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE = 'PROCEDURE';
/
DROP PROCEDURE MY_FIRST_PROC;
/
DROP PROCEDURE MY_SECOND_PROC;
/

--Assignment part-1 : PROCEDURE
--Create one table to store logs(log_id, log_ts, action_taken)
--1.Create the procedure to update the salary of the employee by given percentage. (emp_id, dep_id, incerement_percentage as input).
    --log the details into logs table if provided data is incorrect.

CREATE TABLE LOGS(
    LOG_ID NUMBER(4),
    LOG_TS TIMESTAMP,
    ACTION_TAKEN VARCHAR2(4000)
);
/
CREATE SEQUENCE LOG_SEQ;
/
DROP TABLE LOGS;
/
/
CREATE OR REPLACE PROCEDURE P_INCREASE_SALARY
(
    P_IN_EMP_ID IN NUMBER,
    P_IN_DEPT_ID IN DEPARTMENTS.DEPARTMENT_ID%TYPE,
    P_IN_INCEREMENT_PERCENTAGE IN NUMBER,
    P_OUT_MESSAGE OUT VARCHAR2
)
AS
V_DEPT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
    P_OUT_MESSAGE := 'SUCESS';
    BEGIN
        SELECT DEPARTMENT_ID INTO V_DEPT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = P_IN_EMP_ID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            INSERT INTO LOGS VALUES (LOG_SEQ.NEXTVAL, SYSTIMESTAMP, 'GIVEN EMPLOYEE ID: ' || P_IN_EMP_ID || ' IS NOT VALID.');
            P_OUT_MESSAGE := 'FAILED';
        RETURN;
    END;
    
    IF V_DEPT_ID <> P_IN_DEPT_ID THEN
        INSERT INTO LOGS VALUES (LOG_SEQ.NEXTVAL, SYSTIMESTAMP, 'GIVEN DEPARTMENT ID: ' || P_IN_DEPT_ID || ' IS NOT VALID.');
        P_OUT_MESSAGE := 'FAILED';
        RETURN;
    END IF;
    
    UPDATE EMPLOYEES SET SALARY = SALARY +(SALARY * P_IN_INCEREMENT_PERCENTAGE/100)
    WHERE EMPLOYEE_ID = P_IN_EMP_ID;
    
END P_INCREASE_SALARY;
/
/
SELECT * FROM EMPLOYEES;
SELECT * FROM LOGS;

DECLARE
    V_OUT_MESSAGE VARCHAR2(100);
BEGIN
    P_INCREASE_SALARY(101, 90, 10, V_OUT_MESSAGE); -- 24000
    DBMS_OUTPUT.PUT_LINE(V_OUT_MESSAGE);
END;
/    
    
--2. Create the procedure which can be used for login flow. It should accept username(firstname), password(lastname@emp_id)
    --validtes the data, returns success/failed as an output and make an entry in logs table if failed.
    
    

















