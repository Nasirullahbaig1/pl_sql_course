--CURSOR
--cursor is the work area where the result of a SQL query is stored at server side.
--CURSOR IS A POINTER TO THE QUERRY.
--There are two type of Cursor

--Implicit Cursor:
--Implicit cursor is created and used by Oracle.
--it also throws NO_DATA_FOUND and TOO_MANY_ROWS as oracle handle implicit cursor in the standard way.

--Explicit Cursor:
--we can declare the cursor as follows
--DECLARE
--  CURSOR <cursor_name> IS <query>

--cursor should be opened before using it. When we openthe cursor it execte the querry assosiated with it. 
-- OPEN <cursor_name>

-- after the cursor is opened we use fetch statement to fetch the data of the cursor and store it in a varaible.
--FETCH <cursor_name> INTO <variable>;

--Corsor should be closed as well so it wont perform any background activities.
--syntax:
    --CLOSE <cursor_name>

--There are few errors like when the cursor is not open and we try to fetch or close that 
--it will give us error like 'INVALID CURSOR TYPE'.

--Cursor Attributes
--ISOPEN:
    --return TRUE if cursor is open else FALSE.
--FOUND:
    --Return TRUE if record fetched successfully,
    --FALSE if record not fetched,
    --NULL before first fetch,
    --INVALID_CURSOR if cursor is not opened.
--NOTFOUND:
    --It returns exact opposite to %FOUND.
--ROWCOUNT:
    --Returns number of records returned by cursor.
SET SERVEROUT ON  
DECLARE
    CURSOR C_DEPT IS SELECT * FROM DEPARTMENTS ORDER BY DEPARTMENT_ID;
    C_DATA C_DEPT%ROWTYPE; 
BEGIN
    OPEN C_DEPT;
    LOOP
        FETCH C_DEPT INTO C_DATA;
        EXIT WHEN C_DEPT%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('DEP_NAME --> ' || C_DATA.DEPARTMENT_NAME);
    END LOOP;     
END;
/
SELECT * FROM DEPARTMENTS;

--Assignment on Cursor

--Fetch all the employees with salary in odd number and print them in desc order of the salary using cursor.
SET SERVEROUT ON
DECLARE
    CURSOR C_EMP IS 
        SELECT * FROM EMPLOYEES 
        WHERE MOD (SALARY, 2) = 1
        ORDER BY SALARY DESC;
    V_EMP_DATA C_EMP%ROWTYPE;
BEGIN
    OPEN C_EMP;
    LOOP
        FETCH C_EMP INTO V_EMP_DATA;
        EXIT WHEN C_EMP%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('EMP_ID: ' || V_EMP_DATA.EMPLOYEE_ID);
        DBMS_OUTPUT.PUT_LINE('NAME: ' || V_EMP_DATA.FIRST_NAME);
        DBMS_OUTPUT.PUT_LINE('SALARY: ' || V_EMP_DATA.SALARY);
    END LOOP;
    CLOSE C_EMP;
END;
/
SELECT * FROM EMPLOYEES;

--Print the details of all the employees with salary in ascending order and stop printing the data when 2nd odd
--salaried cursor in encountered.
DECLARE
    CURSOR C_EMP2 IS
        SELECT * FROM EMPLOYEES
        ORDER BY SALARY NULLS LAST;
    V_EMP_DATA2 C_EMP2%ROWTYPE;
    V_ODD_SALARY_FLAG NUMBER := 0;
BEGIN
    OPEN C_EMP2;
    LOOP
        FETCH C_EMP2 INTO V_EMP_DATA2;
        IF MOD(V_EMP_DATA2.SALARY, 2) = 1 THEN
            V_ODD_SALARY_FLAG := V_ODD_SALARY_FLAG + 1;
        END IF;
        EXIT WHEN (C_EMP2%NOTFOUND OR V_ODD_SALARY_FLAG >= 2);
        DBMS_OUTPUT.PUT_LINE('EMP_ID: ' || V_EMP_DATA2.EMPLOYEE_ID);
        DBMS_OUTPUT.PUT_LINE('NAME: ' || V_EMP_DATA2.FIRST_NAME);
        DBMS_OUTPUT.PUT_LINE('SALARY: ' || V_EMP_DATA2.SALARY);
        DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
    END LOOP;

END;
/


--loop through all the departments one by one and print name of all the employees per department 
--separated by ">" in single line.
DECLARE
    CURSOR C_DEPT IS
        SELECT * FROM DEPARTMENTS ORDER BY DEPARTMENT_ID;
    V_DEPT_DATA C_DEPT%ROWTYPE;
    V_EMP VARCHAR2(3200);
BEGIN
    OPEN C_DEPT;
    LOOP
        FETCH C_DEPT INTO V_DEPT_DATA;
        EXIT WHEN C_DEPT%NOTFOUND;
        SELECT LISTAGG(FIRST_NAME, ' > ') WITHIN GROUP (ORDER BY FIRST_NAME)
        INTO V_EMP
        FROM EMPLOYEES  
        WHERE DEPARTMENT_ID = V_DEPT_DATA.DEPARTMENT_ID; 
        DBMS_OUTPUT.PUT_LINE(V_DEPT_DATA.DEPARTMENT_ID || ' --> '|| V_DEPT_DATA.DEPARTMENT_NAME || ' --> ' || V_EMP);
    END LOOP;
END;
/

--Loop through all the departments and print the total salary of the employees of that departments.
DECLARE 
    CURSOR C_DEPT IS 
        SELECT * FROM DEPARTMENTS;
    V_DEPT_DATA C_DEPT%ROWTYPE;
    V_TOTAL NUMBER;
BEGIN
    OPEN C_DEPT;
    LOOP
        FETCH C_DEPT INTO V_DEPT_DATA;
        EXIT WHEN C_DEPT%NOTFOUND;
        SELECT SUM(SALARY) INTO V_TOTAL
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = V_DEPT_DATA.DEPARTMENT_ID;
        DBMS_OUTPUT.PUT_LINE(V_DEPT_DATA.DEPARTMENT_ID || ' --> ' || V_TOTAL);
    END LOOP;
END;
/
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 20;

--PARAMETERIZED CURSOR
--cursor can accept the parameters and that parameters can be used in the cursor query.
--DECLARE
    --CURSOR cursor_name (parameter1, parameter2,...)
    --is
    --<SELECT query, Use the parameters in the query by thir name>;
    --..
--BEGIN
    --..
    --OPEN cursor_name (parameter_value,...);
    --...
    --...
DECLARE
    CURSOR CL (LOWER_RANGE NUMBER, HIGHER_RANGE NUMBER) IS
        SELECT EMPLOYEE_ID, FIRST_NAME, SALARY FROM EMPLOYEES
        WHERE SALARY BETWEEN LOWER_RANGE AND HIGHER_RANGE;
        V_EMP_ID NUMBER;
        FIRSTNAME VARCHAR2(100);
        SALARY NUMBER;
BEGIN
    OPEN CL (13000, 15000);
    LOOP
        FETCH CL INTO V_EMP_ID, FIRSTNAME, SALARY;
        EXIT WHEN CL%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_EMP_ID || ' --> ' || FIRSTNAME || ' --> ' || SALARY);
    END LOOP;
    CLOSE CL;
END;
/

--CURSOR WITH FOR LOOP
--
 


















