--TRIGGER IN PL/SQL

--What is trigger?
--Trigger is stored in pl/sql block which is executed when some event occurs.
--There can be multiple events on which trigger can be created.
--DML on table
    --INSERT
    --UPDATE
    --DELETE
--DDL on table
    --CREATE
    --ALTER
--SYSTEM EVENTS
    --SHOTDOWN OR STARTUP
--USER EVENTS
    --LOGIN OR LOGOUT
--Triggers are generally used to implement complex login, complex restriction, audits,generate column values automatically.

--SYNTAX:

--CREATE [OR REPLACE] TRIGGER trigger_name
--[BEFORE | AFTER] triggering_event ON table_name
--[FOR EACH ROW]
--[WHEN condition]
--DECLARE
--      .....
--BEGIN
--      .....
--EXCEPTION
--      .....
--END;

--BEFORE or AFTER keyword specifies when to execute the trigger, before the triggering event or after.
--FOR EACH ROW specifies that trigger is row level trigger. row level trigger executed once for each row changed/inserted/deleted.
--statement level trigger is the default trigger type and it is executed per statemnt regardless of number of records affected.
--FOLLOWS or PRECEDES another trigger is used to define the sequaence of trigger in case multiple trigger is created on the same event.
--WHEN clause is used to define the condition on which trigger should be executed.

--ROW LEVEL TRIGGERS
--row level trigger executes for each row affected. ie If one statement update 50 records then trigger will be executed 50 times
--row level trigger mostly needed when we want to work on data level activity.
--:OLD and :NEW is used to find the old and new values of the data as :OLD.column_name respectively.
--Colon is used before OLD and NEW as they are external varaible references.
--:OLD .column_name is null for INSERT event and :NEW.column_name is null for delecte event.
--Using REFERENCING keyword OLD and NEW keyword can be override with another names.
--Exceptions are used to ristrict the event in trigger based on condition.
--RAISE_APPLICATION_ERROR is mostly used to proveide the proper information and it automatically rollback the transaction.

select * from departments;
alter table departments add is_active number(1) default 1 not null;
update departments set is_active = 0 where department_id = 60 or department_id =90;
commit;
select * from employees;
/
CREATE OR REPLACE TRIGGER trg_employee_dept_id_active BEFORE
    INSERT OR UPDATE ON employees
    FOR EACH ROW
    WHEN ( new.department_id IS NOT NULL )
DECLARE
    v_cnt NUMBER := 0;
BEGIN
    SELECT
        COUNT(1)
    INTO v_cnt
    FROM
        departments
    WHERE
            department_id = :new.department_id
        AND is_active = 1;

    IF v_cnt = 0 THEN
        raise_application_error(-20011,
                                'YOU CAN NOT ADD EMPLOYEE IN DEPARTMENT' || :new.department_id);
    END IF;

END;
/
--Assignment: Row level trigger
--1. Create trigger on employees table to fill emp_id using employees_seq and ignore any emp_id set in INSERT/UPDATE statemnet.
CREATE OR REPLACE TRIGGER TRG_EMPLOYEES_BIU_EMP_ID
BEFORE INSERT OR UPDATE OF EMPLOYEE_ID ON EMPLOYEES
FOR EACH ROW
BEGIN
    :NEW.EMPLOYEE_ID := EMPLOYEES_SEQ.NEXTVAL;
END TRG_EMPLOYEES_BIU_EMP_ID;
/

--2. Create trigger on departments table to audit new department addition, department name/city change and department delection.
--      audit data should go into assignment_logs table.
CREATE OR REPLACE TRIGGER TRG_DEPARTMENT_BIUD_LOGS
BEFORE INSERT OR UPDATE OR DELETE OF DEPARTMENT_NAME, LOCATION_ID ON DEPARTMENTS
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        INSERT INTO ASSIGNMENT_LOGS VALUES (ASSIGNMENT_LOG_SEQ, SYSTIMESTAMP, 
            'TRG_DEPARTMENT_BIUD_LOGS --> INSERT --> ' || :NEW.DEPARTMENT_ID || ', ' || :NEW.DEPARTMENT_NAME || ', ' || NEW.LOCATION_ID);
    ELSIF DELETING THEN
           INSERT INTO ASSIGNMENT_LOGS VALUES (ASSIGNMENT_LOG_SEQ, SYSTIMESTAMP, 
            'TRG_DEPARTMENT_BIUD_LOGS --> DELETE --> ' || :OLD.DEPARTMENT_ID || ', ' || :OLD.DEPARTMENT_NAME || ', ' || OLD.LOCATION_ID); 
    ELSE
        INSERT INTO ASSIGNMENT_LOGS VALUES (ASSIGNMENT_LOG_SEQ, SYSTIMESTAMP, 
            'TRG_DEPARTMENT_BIUD_LOGS --> UPDATE --> ' || 
            CASE WHEN :OLD.DEPARTMENT_NAME<> :NEW.DEPARTMENT_NAME THEN 'NAME CHAGE --> ' || OLD.DEPARTMENT_NAME END
            CASE WHEN :OLD.LOCATION_ID<> :NEW.LOCATION_ID THEN 'NAME CHAGE --> ' || OLD.LOCATION_ID END
            );
    END IF;
END TRG_DEPARTMENT_BIUD_LOGS;
/
--3. Create update trigger on salary change. Log the salary change into assignment_log table.
--4. Create insert trigger on departments table to create default employee in the employees table.
--5. Disable all the trigger created in the assignmnet. try to drop one of the trigger too.


/
SELECT EMPLOYEES_SEQ.NEXTVAL FROM DUAL;
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM ASSIGNMENT_LOGS;
/
--STATEMENT LEVEL TRIGGERS
--Statement level trigger is executed per stetement regardless of the number of records affected.
--Statement level triggers are not used for data level activities but used to apply few restriction on the
--few operations on the table and allow to gather data of operations.
--It is the default trigger type.
--As statement level trigger is not used on data level, NEW and OLD reference varaible can not be used in the statement level trigger.
CREATE OR REPLACE TRIGGER TRG_EMPLOYEES_DELETE_RESTRICTION
BEFORE DELETE ON EMPLOYEES
DECLARE
    V_CNT NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE
    SELECT COUNT(1) INTO V_CNT FROM DEPARTMENTS WHERE IS_ACTIVE = 0;
    IF V_CNT > 0 THEN
        RAISE_APPLICATION_ERROR(-20012, 'YOU CAN NOT DELETE EMPLOYEE WHEN ONE OF THE DEPT IS INACTIVE');
    END IF;
END;
/
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
/
--Assignemt: statement level trigger:

--1. Create statement level trigger to disallow anyone to delete any of the department.
CREATE OR REPLACE TRIGGER TRG_DEPT_SIMT_NO_DELETE_BEF
BEFORE DELETE ON DEPARTMENTS 
BEGIN
    RAISE_APPLICATION_ERROR(-20012, 'YOU CAN NOT DELETE ANY DEPARTMNET....');
END TRG_DEPT_SIMT_NO_DELETE_BEF;
/
SELECT * FROM DEPARTMENTS;
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 300;
/
--2. Create statement level trigger to disallow update in employee salary between 1-7 of the month.
CREATE OR REPLACE TRIGGER TRG_EMP_SALARY_UPDATE_BS
BEFORE UPDATE OF SALARY ON EMPLOYEES
BEGIN
    IF EXTRACT (DAY FROM SYSDATE) <= 7 THEN
        RAISE_APPLICATION_ERROR(-20012, 'ITS NOT ALLOWED TO UPDATE EMPLOYEE DATA DURING THE FIRST WEEK OF THE MONTH....');
    END IF;
END TRG_EMP_SALARY_UPDATE_BS;
/
UPDATE EMPLOYEES SET SALARY = 30000 WHERE EMPLOYEE_ID = 101;

--3. Create statement level trigger on employees table to allow update on employees table to allow update on employees only 
--      if more then 3 departments are active and log entry when employees data are updated, which will be usefull to create the report on the
--      employee data update frequency.
--4. Disable all the created in this assignment.

--COMPOUND TRIGGERS 
--compoud trigger combines following triggers:
--1. before statement trigger 
--2. before row level trigger
--3. after row level trigger
--4. after statement trigger

--compound trigger can be used to resolve the mutating table problem, collect the data at row level and process in batch,
--  create one trigger body for multiple trigger to simplify the implementation.

--CREATE OR REPLACE TRIGGER <trigger name>
--for <insert | update | delate><of column_name>
--on <tablename>

--COMPOUND TRIGGER
    --<declaration section>
--BEFORE STATEMENT IS
    --<declaration section>
--BEGIN
    --<before section>
--END BEFORE STATEMENT;
--BEFORE EACH ROW IS
    --<declaration section>
--BEGIN
    --<before each row section>
--END BEFORE EACH ROW;
---------------------------------------------------------
--AFTER EACH ROW IS
    --<declaration section>
--BEGIN
    --<after each row section>
--END AFTER EACH ROW;
--AFTER STATEMENT IS
    --<declaration section>
--BEGIN
    --<after section>
--END AFTER STATEMENT;
--END;
/

















        