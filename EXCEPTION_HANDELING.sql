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













