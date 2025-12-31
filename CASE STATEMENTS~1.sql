--CASE STATEMENTS
--Type of case statements

--SIMPLE CASE STATEMENT:
--      CASE EXPRESSION
--      WHEN VALUE THEN STATEMENT
--      WHEN VALUE THEN STATMENNT
--      ...
--      END;

SET SERVEROUT ON
DECLARE
    v_number number := 10;
BEGIN
    CASE MOD(v_number,2)
        WHEN 0 THEN DBMS_OUTPUT.PUT_LINE(v_number || ' IS AN EVEN NUMBER'); 
        ELSE DBMS_OUTPUT.PUT_LINE(v_number || ' IS AN ODD NUMBER');
    END CASE;
        
END;
/

--SEARCHED CASE STATEMENT:
--CASE
--WHEN EXPRESSION THEN STATMENT/EXPRESSION
--WHEN EXPRESSION THEN STATMENT/EXPRESSION
--....
--END;

DECLARE 
    v_number NUMBER := 11;
BEGIN
    CASE
    WHEN MOD(v_number,2)= 0 THEN 
        DBMS_OUTPUT.PUT_LINE(v_number || ' IS AN EVEN NUMBER');
    WHEN MOD(v_number,2)= -1 THEN
        DBMS_OUTPUT.PUT_LINE(v_number || ' INVALID DATA');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_number || ' IS AN ODD NUMBER'); 
    END CASE;
END;
/

--Multiple cases
DECLARE 
    v_number NUMBER := 8;
BEGIN
    CASE
    WHEN MOD(v_number,5)= 0 THEN 
        DBMS_OUTPUT.PUT_LINE(v_number || ' IS DIVISIBLE BY 5');
    WHEN MOD(v_number,4)= 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_number || ' IS DIVISIBLE BY 4');
    WHEN MOD(v_number,3)= 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_number || ' IS DIVISIBLE BY 3');
    WHEN MOD(v_number,2)= 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_number || ' IS DIVISIBLE BY 2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NOT DIVISIBLE BY ANY NUMBER LESS THEN 5'); 
    END CASE;
END;
/

--PRACTICAL WITH CASE STATEMETNS
--Assignment: CASE statement

--update statement to update employee/department
--take any one random employee. take emp_id as constant.
--update the salary of employee to 1000 if name of the employee is between  A-G.
--else if department id is odd then update its depaetment's city to karachi
--else update salary of that department's employee to 1500.

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

SET SERVEROUT ON
DECLARE
    V_EMP_ID CONSTANT employees.EMPLOYEE_ID%type :=100;
    V_EMP_NAME employees.FIRST_NAME%type;
    V_DEPARTMENT_ID employees.DEPARTMENT_ID%type;
BEGIN
    SELECT FIRST_NAME, DEPARTMENT_ID INTO V_EMP_NAME, V_DEPARTMENT_ID  FROM EMPLOYEES WHERE EMPLOYEE_ID = V_EMP_ID;
    CASE
        WHEN V_EMP_NAME BETWEEN 'A' AND 'G' THEN
        UPDATE EMPLOYEES SET SALARY = 1000 WHERE EMPLOYEE_ID = V_EMP_ID;
        DBMS_OUTPUT.PUT_LINE('UPDATED SALARY OF ' || V_EMP_NAME || ' 1000' );
        
        WHEN MOD(V_DEPARTMENT_ID,2) = 1 THEN
        UPDATE departments SET MANAGER_ID = 101 WHERE DEPARTMENT_ID = V_DEPARTMENT_ID;
        DBMS_OUTPUT.PUT_LINE('SET THE MANAGER ID TO 101' );
        
        ELSE
        UPDATE EMPLOYEES SET SALARY = 1500 WHERE DEPARTMENT_ID = V_DEPARTMENT_ID;
        DBMS_OUTPUT.PUT_LINE('ALL THE SALARIES ARE SET TO 15000');
    END CASE;
END;
/

--SECOND PROBLEM 

--take one number in variable
--add the following number to the variable
--4 if the number is two digit
--10 if the number is three digit
--23 if the number is four digit
--55 for all other
DECLARE
    V_NUM NUMBER := 1;
BEGIN
    CASE LENGTH(V_NUM)
        WHEN 2 THEN V_NUM := V_NUM + 4;
        WHEN 3 THEN V_NUM := V_NUM + 10;
        WHEN 4 THEN V_NUM := V_NUM + 23;
        ELSE V_NUM := V_NUM + 55;
    END CASE;
END;
/

































