--User defined record type
--create a user defined record type and take three rows and find the heighest salary and store it in the record.
SET SERVEROUT ON
DECLARE
    TYPE  TYPE_EMP  IS RECORD
        (EMP_ID     EMPLOYEES.EMPLOYEE_ID%TYPE,
        MANAGER_ID  EMPLOYEES.MANAGER_ID%TYPE,
        FIRST_NAME  EMPLOYEES.FIRST_NAME%TYPE,
        SALARY      EMPLOYEES.SALARY%TYPE
        );
    V_UDRT_EMP TYPE_EMP;
BEGIN
    SELECT EMPLOYEE_ID, MANAGER_ID, FIRST_NAME,SALARY 
    INTO V_UDRT_EMP 
    FROM EMPLOYEES 
    ORDER BY SALARY DESC NULLS LAST FETCH FIRST ROW ONLY;
    
    DBMS_OUTPUT.PUT_LINE ('EMP_ID: ' || V_UDRT_EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE ('MANAGER_ID: ' || V_UDRT_EMP.MANAGER_ID);
    DBMS_OUTPUT.PUT_LINE ('FIRST_NAME: ' || V_UDRT_EMP.FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE ('SALARY: ' || V_UDRT_EMP.SALARY);
END;
/

--Using the user defined record type 
--fetch the detail of the highest salaried employe and update the salary, manager, department of it into 
--lowest salaried
DECLARE
    TYPE  TYPE_EMP  IS RECORD
        (
        MANAGER_ID  EMPLOYEES.MANAGER_ID%TYPE,
        SALARY      EMPLOYEES.SALARY%TYPE,
        DEPT_ID     EMPLOYEES.DEPARTMENT_ID%TYPE
        );
    V_UDRT_EMP TYPE_EMP;
BEGIN
    SELECT MANAGER_ID, SALARY, DEPARTMENT_ID
    INTO V_UDRT_EMP 
    FROM EMPLOYEES 
    ORDER BY SALARY DESC NULLS LAST FETCH FIRST ROW ONLY;
    
    DBMS_OUTPUT.PUT_LINE ('MANAGER_ID: ' || V_UDRT_EMP.MANAGER_ID);
    DBMS_OUTPUT.PUT_LINE ('SALARY: ' || V_UDRT_EMP.SALARY);
    DBMS_OUTPUT.PUT_LINE ('DEPARTMENT_ID: ' || V_UDRT_EMP.DEPT_ID);
    
    UPDATE EMPLOYEES
    SET MANAGER_ID = V_UDRT_EMP.MANAGER_ID, SALARY = V_UDRT_EMP.SALARY, DEPARTMENT_ID = V_UDRT_EMP.DEPT_ID
    WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES);
END;
/

SELECT * FROM EMPLOYEES;
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'TJ';

--RECORD TYPE BASED ON TABLE
--We can create record type with same structure as Table/Curser.
--To declare such type of record, we can use %ROWTYPE after table/cursor name as its datatype.

DECLARE
    V_EMP_RECORD EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO V_EMP_RECORD FROM EMPLOYEES
    WHERE FIRST_NAME = 'Lex';
    dbms_output.put_line('emp_id --> ' || V_EMP_RECORD.employee_id);
    dbms_output.put_line('Name --> ' || V_EMP_RECORD.first_name);
    dbms_output.put_line('Salary --> ' || V_EMP_RECORD.salary);
    dbms_output.put_line('job_id --> ' || V_EMP_RECORD.job_id);
END;
/





















