--EXCEPTOIN HANDELING
--When we have some error in the code we can handle that through exception block.

--Assignment:
--Create a plsql block to fatch employee having firstname 'nasir' and show its salary,
--> if not avalible then show the heighest salary using EXCEPTION BLOCK.
SELECT * FROM EMPLOYEES;

SET SERVEROUT ON;
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


