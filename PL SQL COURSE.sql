--Introduction to PL-SQL ORACLE
--Procedural launage in SQL

--PL/SQL Anonymous block 
--Decleration section
--Begin
--Execution sectoin
--Exception section
--END.

--Iteration (LOOP)
--Handeling exceptions
    --system defined exceptions
    --user defined exceptions
--Record type
--cursor
    --implicit cursor
    --explicit cursor

--procedure
--function
--package
--Trigger
--Collections
    --Nested tables
    --Variable sized array or VARRAYs
    --Associated Arrays

--Introduction to PL/SQL
--Anonymous PL/SQL block:
--DECLARE
--variable declaration goes here

SET SERVEROUTPUT ON;
DECLARE
    V_NUM_D NUMBER DEFAULT 10;
    V_NUM NUMBER;
    V_VARCAHR2 VARCHAR2(100) NOT NULL := 'THIS IS DEFALUT VALUE';
    V_EMP_ID employees.emp_id%TYPE;
    V_EMP_FIRSTNAME employees.firstname%TYPE;
BEGIN
    dbms_output.put_line('V_NUM_D);
END;
/
    




















