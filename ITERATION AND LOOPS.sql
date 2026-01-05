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