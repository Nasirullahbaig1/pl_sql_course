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
SELECT * FROM USER_SOURCE WHERE TYPE LIKE '%PROCEDURE';
/
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE = 'PROCEDURE';
/
DROP PROCEDURE MY_FIRST_PROC;
/
DROP PROCEDURE MY_SECOND_PROC;
/

--Assignment part-1 : PROCEDURE
--Create one table to store logs(log_id, log_ts, action_taken)
--1.Create the procedure to update the salary of the employee by given percentage. (emp_id, dep_id, incerement_percentage as input).
    --log the details into logs table if provided data is incorrect.

CREATE TABLE logs (
    log_id       NUMBER(4),
    log_ts       TIMESTAMP,
    action_taken VARCHAR2(4000)
);
/
CREATE SEQUENCE LOG_SEQ;
/
DROP TABLE LOGS;
/
/
CREATE OR REPLACE PROCEDURE p_increase_salary (
    p_in_emp_id                IN NUMBER,
    p_in_dept_id               IN departments.department_id%TYPE,
    p_in_incerement_percentage IN NUMBER,
    p_out_message              OUT VARCHAR2
) AS
    v_dept_id departments.department_id%TYPE;
BEGIN
    p_out_message := 'SUCESS';
    BEGIN
        SELECT
            department_id
        INTO v_dept_id
        FROM
            employees
        WHERE
            employee_id = p_in_emp_id;

    EXCEPTION
        WHEN no_data_found THEN
            INSERT INTO logs VALUES ( log_seq.NEXTVAL,
                                      systimestamp,
                                      'GIVEN EMPLOYEE ID: '
                                      || p_in_emp_id
                                      || ' IS NOT VALID.' );

            p_out_message := 'FAILED';
            COMMIT;
            RETURN;
    END;

    IF v_dept_id <> p_in_dept_id THEN
        INSERT INTO logs VALUES ( log_seq.NEXTVAL,
                                  systimestamp,
                                  'GIVEN DEPARTMENT ID: '
                                  || p_in_dept_id
                                  || ' IS NOT VALID.' );

        p_out_message := 'FAILED';
        COMMIT;
        RETURN;
    END IF;

    UPDATE employees
    SET
        salary = salary + ( salary * p_in_incerement_percentage / 100 )
    WHERE
        employee_id = p_in_emp_id;

    COMMIT;
END p_increase_salary;
/
/
SELECT * FROM EMPLOYEES;
SELECT * FROM LOGS;

--calling the procedure
DECLARE
    v_out_message VARCHAR2(100);
BEGIN
    p_increase_salary(101, 90, 10, v_out_message); -- 24000
    dbms_output.put_line(v_out_message);
END;
/   
/    
--2. Create the procedure which can be used for login flow. It should accept username(firstname), password(lastname@emp_id)
    --validtes the data, returns success/failed as an output and make an entry in logs table if failed.
    
CREATE OR REPLACE PROCEDURE p_validate_login (
    p_in_username VARCHAR2,
    p_in_password VARCHAR2,
    p_out_result  OUT VARCHAR2
) AS
    v_password VARCHAR2(100);
BEGIN
    p_out_result := 'success';
    SELECT
        last_name
        || '@'
        || employee_id
    INTO v_password
    FROM
        employees
    WHERE
        first_name = p_in_username;

    IF v_password <> p_in_password THEN
        p_out_result := 'failed';
        ROLLBACK;
        INSERT INTO logs VALUES ( log_seq.NEXTVAL,
                                  systimestamp,
                                  'p_validate_login --> password incorrct: ' || p_in_username );

        COMMIT;
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        p_out_result := 'failed';
        ROLLBACK;
        INSERT INTO logs VALUES ( log_seq.NEXTVAL,
                                  systimestamp,
                                  'p_validate_login --> firstname: '
                                  || p_in_username
                                  || ' invalid.' );

        COMMIT;
END;
/
/
--calling the procedure
DECLARE
    v_out_message VARCHAR2(100);
BEGIN
    p_validate_login('Steven', 'King@100', v_out_message);
    dbms_output.put_line(v_out_message);
END;
/ 
SELECT * FROM EMPLOYEES;
/














