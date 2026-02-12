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































        