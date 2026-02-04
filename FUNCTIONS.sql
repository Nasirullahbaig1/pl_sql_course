--FUNCTIONS IN PL/SQL

--Function is the stored pl/sql block which can accept and return the values to the calling code same as procedure.
--Function syntax:
--CREATE [OR REPLACE] FUNCTION function_name
--(input/output parameter list) RETURN data_type     
--IS 
--  variable declaration;
--BEGIN
--  execute code;
--  RETURN value/expression;
--EXCEPTION
--  exception hadeling login;
--  RETURN value/expression;
--END;

--FUNCTION PARAMETERS
--Function parameters and its mode are same as procedure.
--IN --> default
--OUT
--IN OUT
--The only difference in term of parameter between procedure and function is the return paremeter.
--There is one default return value which can be used by calling code directly.

--CALLING THE FUNCTION
--Function can be called form almost anywhere, While calling of procedure is restricted.
--Calling the function in assignment:
--variable_name := function name(....);
--Calling the function from any clause of the querry:
--select function_name(..), ...from table_clause
--WHERE some_value/expression/column_value = function_name(..)

--calling the function as boolean expression:
--IF function_name(..) operator value THEN
--END IF

CREATE OR REPLACE FUNCTION FN_MY_FIRST_FUNCTION(P_IN_NUMBER IN NUMBER, P_OUT_NUMBER OUT NUMBER) RETURN NUMBER
IS
BEGIN
    RETURN (P_IN_NUMBER*P_IN_NUMBER) + 5;
END FN_MY_FIRST_FUNCTION;
/
SELECT FN_MY_FIRST_FUNCTION(10) FROM DUAL WHERE 120 > FN_MY_FIRST_FUNCTION(9);
/
SET SERVEROUT ON;
DECLARE
    V_FN_RETURNED_VALUE NUMBER := 0;
BEGIN
    V_FN_RETURNED_VALUE := FN_MY_FIRST_FUNCTION(6);
    DBMS_OUTPUT.PUT_LINE(V_FN_RETURNED_VALUE);
    IF FN_MY_FIRST_FUNCTION(20) > 300 THEN
        DBMS_OUTPUT.PUT_LINE(FN_MY_FIRST_FUNCTION(20));
    END IF;
END;
/
CREATE OR REPLACE FUNCTION FN_MY_FIRST_FUNCTION(P_IN_NUMBER IN NUMBER, P_OUT_NUMBER OUT NUMBER) RETURN NUMBER
IS
BEGIN
    P_OUT_NUMBER :=1;
    RETURN (P_IN_NUMBER*P_IN_NUMBER) +5;
    INSERT INTO DEPARTMENTS VALUES (P_IN_NUMBER*P_IN_NUMBER);
END FN_MY_FIRST_FUNCTION;
/
--METADATA AND DROP FUNCTION
--Data dictionary views of the procedure:
--USER_PROCEDURE, ALL_PROCEDURE --> OBJECT_TYPE = 'FUNCTION'
--USER_SOURCE, ALL_SOURCE, DBA_SOURCE
--To drop function, use DROP FUNCTION function_name;

select * from USER_PROCEDURES WHERE OBJECT_TYPE = 'FUNCTION';
select * from user_objects where object_type = 'FUNCTION';
/
--ASSIGNMENT PART-1: FUNCTION
--1. Create the function to return the avarage salary of the passed department and use it in the query.
CREATE OR REPLACE
FUNCTION FU_DEP_AVG_SALARY(P_IN_DEPT_ID IN DEPARTMENTS.DEPARTMENT_ID%TYPE)
RETURN NUMBER
AS 
    V_AVG_SALARY NUMBER := 0;
    V_COUNT NUMBER :=0;
BEGIN
    SELECT COUNT(1) INTO V_COUNT FROM DEPARTMENTS WHERE DEPARTMENT_ID = P_IN_DEPT_ID;
    IF V_COUNT = 0 THEN
        RETURN -1;
    ELSE
        SELECT AVG(SALARY) INTO V_AVG_SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = P_IN_DEPT_ID;
        RETURN V_AVG_SALARY;
    END IF;
END FU_DEP_AVG_SALARY;
/
SELECT * FROM EMPLOYEES;
/
SELECT D.*, FU_DEP_AVG_SALARY(D.DEPARTMENT_ID) FROM DEPARTMENTS D;
SELECT D.*, ROUND(FU_DEP_AVG_SALARY(D.DEPARTMENT_ID)) FROM DEPARTMENTS D where FU_DEP_AVG_SALARY(DEPARTMENT_ID) <> -1;
SELECT * FROM EMPLOYEES WHERE FU_DEP_AVG_SALARY(DEPARTMENT_ID) < 5000 AND FU_DEP_AVG_SALARY(DEPARTMENT_ID) <> -1;

--2. Enhance the function create in assignment #1. to accept the emplyee_id also.
    --one of the input pareameter should be null and other should be not null
    --function should return average salary of department of passed department_id or department of the passed employee_id.
    
--3. Create a function to insert the data into logs table and check the outcome by calling/compiling the function.


















