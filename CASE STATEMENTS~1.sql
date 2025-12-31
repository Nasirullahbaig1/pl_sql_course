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
--take any one random 










