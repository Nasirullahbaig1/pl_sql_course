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

CREATE OR REPLACE FUNCTION FN_MY_FIRST_FUNCTION(P_IN_NUMBER IN NUMBER) RETURN NUMBER
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
END;



















