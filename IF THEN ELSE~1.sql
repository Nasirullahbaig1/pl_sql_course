--IF - THEN - ELSE STATMENTS

--Assignment:  IF Statments
--Declare one variable V_current_seconds. initilize it with current second(using current time).
--If v_current_seconds is above 30 then update all odd employee_ids salary by 299. < end of the question.

--Declare one variable v_current_seconds. Initialize it with current second(using current time)
--if v_current_seconds between 50-59 then print highest earning employee id and name.



SET SERVEROUT ON
DECLARE
    v_current_seconds NUMBER;
    
BEGIN
    v_current_seconds := TO_CHAR(SYSDATE,'SS');
    DBMS_OUTPUT.PUT_LINE('v_current_seconds = ' || v_current_seconds); 
    
    IF v_current_seconds > 30 THEN
        UPDATE EMPLOYEE 
        SET SALARY = SALARY+299
        WHERE MOD(EMP_ID,2)= 1;
    END IF;
END;
/

SELECT * FROM EMPLOYEE;






