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
        DBMS_OUTPUT.PUT_LINE('DEP_ID --> ' || C_DATA.DEPARTMENT_ID);
        DBMS_OUTPUT.PUT_LINE('DEP_NAME --> ' || C_DATA.DEPARTMENT_NAME);
    END LOOP;
    
    
    
END;
/
SELECT * FROM DEPARTMENTS;




















