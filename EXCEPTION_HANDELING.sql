--EXCEPTOIN HANDELING
--When we have some error in the code we can handle that through exception block.

--Assignment:
--Create a plsql block to fatch employee having firstname 'nasir' and show its salary,
--> if not avalible then show the heighest salary using EXCEPTION BLOCK.
SELECT * FROM EMPLOYEES;

SET SERVEROUTPUT ON;
DECLARE
    V_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT SALARY INTO V_SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven';
    DBMS_OUTPUT.PUT_LINE('SALARY --> '|| v_SALARY);
EXCEPTION
    WHEN no_data_found then
        select max(salary) into V_SALARY from EMPLOYEES;
        DBMS_OUTPUT.PUT_LINE('MAX SALARY --> '|| v_SALARY);
    WHEN others then
        DBMS_OUTPUT.PUT_LINE('OTHER ERROR');
END;
/

--Create a pl/sql block to:
--Fetch the highest salaried employe of department id 4 --> first name only.
--if no employe for dep 4 exist then
--display the dep name of dep_id = 4
--if the dep not exist then create a dep_id = 4 department having name = 'production' and city = 'lahore'.

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
DECLARE
    V_FIRSTNAME EMPLOYEES.FIRST_NAME%TYPE;
    V_DEP_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME INTO V_FIRSTNAME FROM EMPLOYEES WHERE DEPARTMENT_ID = 300 
    ORDER BY SALARY DESC FETCH FIRST ROW ONLY;
    DBMS_OUTPUT.PUT_LINE('NAME: ' || V_FIRSTNAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        BEGIN
            SELECT DEPARTMENT_NAME INTO V_DEP_NAME FROM DEPARTMENTS WHERE DEPARTMENT_ID = 300;
            DBMS_OUTPUT.PUT_LINE('DEPARTMENT_NAME : ' || V_DEP_NAME);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                INSERT INTO DEPARTMENTS VALUES (300, 'PRODUCTION', NULL, 1700);
                DBMS_OUTPUT.PUT_LINE('NEW DEPARTMENT ADDED SUCCESFULLY.');
        END;
END;
/

--RAISE STATEMENTS
--Raise statements are the user defined exceptions 
--The job is to catch the user defined exception in EXCEPTION block is similer to the internal block.
--For example we want our user to insert 500 records and not more then that so we add a 
--Raise condition there to through an error if he try to add more then that.

--Practical with RAISE EXCEPTIONS:
--Assignment

--Create user defined exception too_much_cost and assign -20333 erroe code to it
--If total salary of dept 'Admin' is greater then 30,000 then rise the too_much_cost exception and print subtitle 
--messge to handle the exception.
SET SERVEROUT ON
DECLARE
    too_much_cost exception;
    pragma exception_init('too_much_cost', -20333);
    
BEGIN
    select SUM(E.SALARY) from departments D join EMPLOYEES E ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE D.DEPARTMENT_NAME = 'Administration';
EXCEPTION

END;
/

select * from departments;


--If the total employees having salary > 8000 are more then 10 then rise too_many_rows system exception and 
--print a suitable message to handle that.
--In continuation to it, if above exception is not thrown then only check for employees salary > 5000.
--If its greater then 8 then rise a user defined exception to handle that.











