--EXCEPTOIN HANDELING
--When we have some error in the code we can handle that through exception block.

--Assignment:
--Create a plsql block to fatch employee having firstname 'nasir' and show its salary,
--> if not avalible then show the heighest salary using EXCEPTION BLOCK.
SELECT * FROM EMPLOYEES;

SET SERVEROUT ON;
DECLARE
    V_NAME EMPLOYEES.FIRST_NAME%TYPE;
    V_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT FIRST_NAME, SALARY INTO V_NAME, V_SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven';
    DBMS_OUTPUT.PUT_LINE('NAME --> ' ||V_NAME || ' SALARY --> '|| v_SALARY);
END;
/