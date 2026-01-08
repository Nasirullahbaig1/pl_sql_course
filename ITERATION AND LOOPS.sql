--ITERATION

--BASIC LOOP STATEMENT
--Basic loop consist of LOOP, END LOOP AND EXIST statement.
--SYNTAX
--<<LABEL_NAME>> LOOP
--      <execute statements>
--      <EXIST{LABLE_NAME} OR EXIST{LABLE_NAME} WHEN>
--    END LOOP;

SET SERVEROUT ON;
DECLARE
    v_num number := 100;
BEGIN
    loop
        if v_num > 150 then
            exit;
        end if;
        dbms_output.put_line(v_num);
        v_num := v_num + 1;
        end loop;
END;
/

DECLARE
    v_num number := 100;
BEGIN
    loop
        exit when v_num > 160;
        dbms_output.put_line(v_num);
        v_num := v_num + 1;
    end loop;
END;
/

DECLARE 
    v_num number := 0;
    v_loop_count number := 0;
BEGIN
    loop
        loop
            v_loop_count := v_loop_count + 1;
            v_num := v_num +1;
            dbms_output.put_line(v_num);
            exit when v_loop_count >= 3;  
        end loop;
        v_loop_count := 0;
        v_num := v_num + 97;
        exit when v_num > 500;
    end loop;
END;
/

--PRACTICAL

--Using basic loop create the multiplecation table of 3 upto 10.
SET SERVEROUT ON;
DECLARE
    V_NUM_MUL NUMBER :=3;
    V_NUM_COUNT NUMBER :=1;
    V_RESULT NUMBER;
BEGIN
    LOOP
        V_RESULT := V_NUM_MUL * V_NUM_COUNT;
        DBMS_OUTPUT.PUT_LINE(V_NUM_MUL || ' * ' || V_NUM_COUNT || ' = ' || V_RESULT);
        V_NUM_COUNT := V_NUM_COUNT +1;
        EXIT WHEN V_NUM_COUNT >= 11;
    END LOOP;
END;
/


--Using the basic loop print the second of system less then 48.
DECLARE
    V_NUM NUMBER :=0;
BEGIN
    LOOP
        V_NUM := V_NUM + 1;
        DBMS_OUTPUT.PUT_LINE('Iteration# ' || V_NUM || ' Seconds --> ' || to_char(SYSTIMESTAMP, 'ff3'));
        exit when V_NUM >= 5000;
    END LOOP;
END;
/

--FOR LOOP - NUMARIC
--SYNTAX:
--FOR index in <IN REVERSE>
--lower_value .. upper_value
--LOOP
--  statement;
--END LOOP;

SET SERVEROUT ON;
BEGIN
    FOR I IN 1..10
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

DECLARE
    V_NUM NUMBER :=0;
BEGIN
    FOR I IN 1..100
    LOOP
        V_NUM := V_NUM + I;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_NUM);
END;
/

--PRACTICAL ON FOR LOOP

--Create the multiplication table of 3 using for loop
DECLARE
    V_NUM NUMBER := 3;
BEGIN
DBMS_OUTPUT.PUT_LINE('TABLE OF 3');
    FOR I IN 1..10
    LOOP 
        V_NUM := V_NUM * I;
        DBMS_OUTPUT.PUT_LINE(3 || ' * ' || I || ' = ' || V_NUM);
        V_NUM := 3;
    END LOOP;
END;
/

--print all the indivisibel number from 1 to 100. using for loop
SET SERVEROUT ON;
DECLARE
    V_DIVISIBLE NUMBER :=0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('INDIVISIBLE NUMBER LESS THEN 100:');
    FOR I IN 1..100 LOOP
        V_DIVISIBLE := 0;
        IF I >= 3 THEN
            FOR J IN 2..I-1 LOOP
               IF MOD(I,J) = 0 THEN
                    V_DIVISIBLE := 1;
                END IF;
            END LOOP;
            IF V_DIVISIBLE = 0 THEN
                DBMS_OUTPUT.PUT_LINE(I);
            END IF;
        END IF;
    END LOOP;
END;
/





















