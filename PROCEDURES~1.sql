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
    p_in_lastname VARCHAR2,
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
        first_name = p_in_username AND LAST_NAME = p_in_lastname;

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
SET SERVEROUT ON;
--calling the procedure
DECLARE
    v_out_message VARCHAR2(100);
BEGIN
    p_validate_login('Alexander', 'Hunold', 'Hunold@103', v_out_message);
    dbms_output.put_line(v_out_message);
END;
/ 
SELECT * FROM EMPLOYEES;
SELECT * FROM LOGS;
/

--PRACTICAL ASSIGNMENT IN PL/SQL PART-2

--1. Create the procedure to update the department of the lowest salaried employee of the department of the passed (input) employee
--   to the next highest avarage salaried department. Insert the logs into log table (assigment_logs).
CREATE TABLE assignment_logs (
    log_id       NUMBER(4),
    log_ts       TIMESTAMP,
    action_taken VARCHAR2(4000)
);
/
CREATE SEQUENCE assignment_logs_seq;
/
/
create or replace PROCEDURE p_department_update (
    p_emp_id          IN employees.employee_id%TYPE,
    p_out_status_code OUT NUMBER
) AS
    v_dept_id    department.department_id%TYPE;
    v_emp_id     employees.employee_id%TYPE;
    v_avg_salary NUMBER;
BEGIN
    p_out_status_code := 0;
    BEGIN
        SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = P_EMP_ID;
    EXCEPTION
        WHEN DATA_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('EMPLOYEE ID: 'P_EMP_ID || ' NOT FOUND!!');
p_out_status_code := -1;

ROLLBACK;

INSERT INTO assignment_logs VALUES ( assignment_logs_seq.NEXTVAL,
                                     systimestamp,
                                     'INVALID EMPLOYEE ID' );

COMMIT;

RETURN;

end;

IF v_dept_id IS NULL THEN
    p_out_status_code := -1;
    dbms_output.put_line('DEPARTMENT OF EMPLOYEE ID: '
                         || p_emp_id
                         || ' IS NULL..');
    ROLLBACK;
    INSERT INTO assignment_logs VALUES ( assignment_logs_seq.NEXTVAL,
                                         systimestamp,
                                         'DEPARTMENT ID IS NULL' );

    COMMIT;
    RETURN;
END IF;

SELECT
    employee_id
INTO v_emp_id
FROM
    employees
WHERE
    department_id = v_dept_id
ORDER BY
    salary,
    employee_id
FETCH first ROW ONLY;

SELECT
    AVG(salary)
INTO v_avg_salary
FROM
    employees
WHERE
    department_id = v_dept_id;

BEGIN
    SELECT
        department_id
    INTO v_dept_id
    FROM
        employees
    WHERE
        department_id IS NOT NULL
    GROUP BY
        department_id
    HAVING
        AVG(salary) > v_avg_salary
    ORDER BY
        AVG(salary)
    FETCH first ROW ONLY;

EXCEPTION
    WHEN no_data_found THEN
        p_out_status_code := -1;
        dbms_output.put_line('DEPARTMENT OF EMPLOYEE ID: '
                             || p_emp_id
                             || ' IS THE HEIGHEST AVAARAGE SALARY DEPARTMENT');
        ROLLBACK;
        INSERT INTO assignment_logs VALUES ( assignment_logs_seq.NEXTVAL,
                                             systimestamp,
                                             'DEPARTMENT ID IS FROM HEIGHEST AVG SALARY' );

        end;
        UPDATE employees
        SET
            department_id = v_dept_id
        WHERE
            employee_id = v_emp_id;

END p_department_update;
/



--2. Create the procedure to devide the salary decerements among all the employees of the department using thir salaryt ratio.
--   department name and total salary decrement for department as an input. log the details into log tabel(assignemt_logs).













