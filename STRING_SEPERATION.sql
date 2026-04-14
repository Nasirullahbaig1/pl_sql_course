CREATE OR REPLACE FUNCTION string_sep(str in varchar2, char_1 in varchar2)
return varchar2
is 
str_in varchar2(500):= str;
dlmi varchar2(10):= char_1;
str_end number;
sub_str varchar2(100);
BEGIN
    --CHECK FOR EMPTY INPUT
    IF LENGTH(STR_IN) IS NULL OR LENGTH(STR_IN) = 0 THEN
        RETURN 'THE PASSED STRING IS EMPTY...';
    END IF;
    --CHECK FOR THE CHERECTER
    IF INSTR(STR_IN , DLMI) = 0 THEN
        RETURN STR_IN;
    END IF;
    
    LOOP
        STR_END := INSTR(STR_IN, DLMI);
        
        IF STR_END = 0 THEN
            DBMS_OUTPUT.PUT_LINE('SUB-STRING : ' || STR_IN);
            EXIT;
        END IF;
        
        SUB_STR := SUBSTR(STR_IN, 1, STR_END - 1);
        DBMS_OUTPUT.PUT_LINE('SUB-STRING : ' || SUB_STR);
        
        STR_IN := SUBSTR(STR_IN, STR_END + 1);
    END LOOP;
    RETURN 'DONE...';
    
END string_sep;
/
SET SERVEROUTPUT ON;
/
DECLARE
    result VARCHAR2(200);
BEGIN
    result := string_sep('NASAIR@ULLAH@BAIG', '@');
    DBMS_OUTPUT.PUT_LINE('Result: ' || result);
END;
/








