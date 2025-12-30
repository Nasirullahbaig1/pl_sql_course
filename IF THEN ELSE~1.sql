--IF - THEN - ELSE STATMENTS

--Assignment:  IF Statments
--Declare one variable V_current_seconds. initilize it with current second(using current time).
--If v_current_seconds is above 30 then update all odd employee_ids salary by 299. < end of the question.

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

--Declare one variable v_current_seconds. Initialize it with current second(using current time)
--if v_current_seconds between 50-59 then print highest earning employee id and name.
--if v_current_seconds between 40-49 then print 3rd highest earning employee id and name.
--if v_current_seconds between 30-39 then print 4th highest earning employee id and name.
--if v_current_seconds between 20-29 then print lowest earning employee id and name.

SET SERVEROUT ON
DECLARE
    v_current_seconds NUMBER;
    v_emp_id employee.emp_id%type;
    v_emp_name employee.emp_name%type;
    
BEGIN
    v_current_seconds := TO_CHAR(SYSDATE, 'SS');
    DBMS_OUTPUT.PUT_LINE('v_current_seconds = ' || v_current_seconds); 
    
    IF v_current_seconds BETWEEN 50 AND 59 THEN
        SELECT EMP_ID, EMP_NAME 
        INTO v_emp_id, v_emp_name 
        FROM EMPLOYEE ORDER BY SALARY DESC FETCH FIRST ROW ONLY;
    ELSIF v_current_seconds BETWEEN 40 AND 49 THEN
        SELECT EMP_ID, EMP_NAME 
        INTO v_emp_id, v_emp_name 
        FROM EMPLOYEE ORDER BY SALARY DESC OFFSET 2 ROWS FETCH FIRST ROW ONLY; 
    ELSIF v_current_seconds BETWEEN 30 AND 39 THEN
        SELECT EMP_ID, EMP_NAME 
        INTO v_emp_id, v_emp_name 
        FROM EMPLOYEE ORDER BY SALARY DESC OFFSET 3 ROWS FETCH FIRST ROW ONLY;
    ELSIF v_current_seconds BETWEEN 20 AND 29 THEN
        SELECT EMP_ID, EMP_NAME 
        INTO v_emp_id, v_emp_name 
        FROM EMPLOYEE ORDER BY SALARY FETCH FIRST ROW ONLY;
    END IF;
    
    IF v_emp_id IS NULL THEN 
        DBMS_OUTPUT.PUT_LINE('NO DATA');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_emp_id || ' - ' || v_emp_name);
    END IF;
END;
/







