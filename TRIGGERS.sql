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





























        