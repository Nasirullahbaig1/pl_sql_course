--PROCEDURE IN PL/SQL
--PL/SQL  procedures are reusable code block that perform specific actions or logic within a database environment.
--Mainly it has two parts PROCEDURE HEADER and PROCEDURE BODY.

--There are two type of procedures
--LOCAL PROCEDURE(ANNOYMOUS OR UNNAMED):
    --As it local it execute in the same session due to which
        --Intialization of procedure
        --Calling of procedure
    --To be done in same program
    
--STORED PROCEDURE(NAMED PROCEDURE):
    --As it stored so it can be stored & can easily executes later on
        --Initilization of procedure
        --Calling of procedure
    --Can be done differently

--Example of Local procedure
SET SERVEROUT ON
DECLARE
    NUM1 NUMBER(2);
    NUM2 NUMBER(2);
    MUL NUMBER(4);
    
    PROCEDURE MULTIPLICATION (NUM1 IN NUMBER, NUM2 IN NUMBER, MUL OUT NUMBER) IS
BEGIN
    MUL:= NUM1 * NUM2;   
END MULTIPLICATION;
    
--CALLING PROCEDURE
BEGIN
    NUM1:=&NUM1;
    NUM2:=&NUM2;
    MULTIPLICATION (NUM1, NUM2, MUL);
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' * ' || NUM2 || ' = ' || MUL);
END;
/

--Example of Stored procedure
CREATE OR REPLACE PROCEDURE ADDITION (NUM1 IN NUMBER, NUM2 IN NUMBER, SUM1 OUT NUMBER) IS
BEGIN
SUM1:=NUM1 + NUM2;
END;
/
--CALLING THE PROCEDURE
DECLARE
    NUM1 NUMBER(2);
    NUM2 NUMBER(2);
    SUM1 NUMBER(4);
BEGIN
    NUM1:=&NUM1;
    NUM2:=&NUM2;
    ADDITION(NUM1, NUM2, SUM1);
DBMS_OUTPUT.PUT_LINE(NUM1 || ' + '|| NUM2 || ' = ' || SUM1);
END;
/
/
CREATE OR REPLACE PROCEDURE MY_FIRST_PROC
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END MY_FIRST_PROC;
/

SET SERVEROUT ON
BEGIN
    MY_FIRST_PROC;
END;
/

--METADATA & DROP PROCEDURE
--DATA DICTIONARY VIEWS OF THE PROCEDURE:
    --USER_PROCEDURE, ALL_PROCEDURE
    --USER_SOURCE, ALL_SOURCE, DBA_SOURCE
--To drop procedure, use DROP PROCEDURE procedure_name;
/
SELECT * FROM USER_PROCEDURES;
/
SELECT * FROM USER_SOURCE
WHERE TYPE LIKE '%PROCEDURE';
/


















