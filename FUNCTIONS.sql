--FUNCTIONS IN PL/SQL

--Function is the stored pl/sql block which can accept and return the values to the calling code same as procedure.
--Function syntax:
--CREATE [OR REPLACE] FUNCTION function_name
--(input/output parameter list) RETURN data_type     
--IS 
--  variable declaration;
--BEGIN
--  execute code;
--  RETURN value/expression;
--EXCEPTION
--  exception hadeling login;
--  RETURN value/expression;
--END;

--FUNCTION PARAMETERS
--Function parameters and its mode are same as procedure.
--IN --> default
--OUT
--IN OUT
--The only difference in term of parameter between procedure and function is the return paremeter.
--There is one default return value which can be used by calling code directly.

--CALLING THE FUNCTION
--Function can be called form almost anywhere, While calling of procedure is restricted.
--Calling the function in assignment:
--variable_name := function name(....);
--Calling the function from any clause of the querry:
--select function_name(..), ...from table_clause
--WHERE some_value/expression/column_value = function_name(..)

--calling the function as boolean expression:
--IF function_name(..) operator value THEN
--END IF

CREATE OR REPLACE FUNCTION FN_MY_FIRST_FUNCTION(P_IN_NUMBER IN NUMBER, P_OUT_NUMBER OUT NUMBER) RETURN NUMBER
IS
BEGIN
    RETURN (P_IN_NUMBER*P_IN_NUMBER) + 5;
END FN_MY_FIRST_FUNCTION;
/
SELECT FN_MY_FIRST_FUNCTION(10) FROM DUAL WHERE 120 > FN_MY_FIRST_FUNCTION(9);
/
SET SERVEROUT ON;
DECLARE
    V_FN_RETURNED_VALUE NUMBER := 0;
BEGIN
    V_FN_RETURNED_VALUE := FN_MY_FIRST_FUNCTION(6);
    DBMS_OUTPUT.PUT_LINE(V_FN_RETURNED_VALUE);
    IF FN_MY_FIRST_FUNCTION(20) > 300 THEN
        DBMS_OUTPUT.PUT_LINE(FN_MY_FIRST_FUNCTION(20));
    END IF;
END;
/
CREATE OR REPLACE FUNCTION FN_MY_FIRST_FUNCTION(P_IN_NUMBER IN NUMBER, P_OUT_NUMBER OUT NUMBER) RETURN NUMBER
IS
BEGIN
    P_OUT_NUMBER :=1;
    RETURN (P_IN_NUMBER*P_IN_NUMBER) +5;
    INSERT INTO DEPARTMENTS VALUES (P_IN_NUMBER*P_IN_NUMBER);
END FN_MY_FIRST_FUNCTION;
/
--METADATA AND DROP FUNCTION
--Data dictionary views of the procedure:
--USER_PROCEDURE, ALL_PROCEDURE --> OBJECT_TYPE = 'FUNCTION'
--USER_SOURCE, ALL_SOURCE, DBA_SOURCE
--To drop function, use DROP FUNCTION function_name;

select * from USER_PROCEDURES WHERE OBJECT_TYPE = 'FUNCTION';
select * from user_objects where object_type = 'FUNCTION';




















