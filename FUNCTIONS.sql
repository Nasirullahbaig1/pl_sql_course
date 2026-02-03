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

