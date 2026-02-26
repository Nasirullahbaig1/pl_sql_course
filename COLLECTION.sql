--COLLECTION IN PL/SQL

--PL/SQL  Associative array is
--1. Single dimension --> Single column of data in data in each row.
--2. Sparse --> Elements are not continuous/sequential.
    --There can be gaps bewteen element.
--3. Unbounded --> Number of elements in the array is not predefined.

--Associative array can be indexed by BINARY_INTEGER, PLS_INTERGER, or VARCHAR2.
SET SERVEROUT ON;
DECLARE
    TYPE TYPE_AA_DEPT IS TABLE OF VARCHAR2(50) INDEX BY VARCHAR2(20);
    V_TYPE_AA_DEPT TYPE_AA_DEPT;
    V_INDEX_AA VARCHAR2(20);
BEGIN
    V_TYPE_AA_DEPT('DEPARTMENT1') := 'JAMU';
    V_TYPE_AA_DEPT('DEPARTMENT2') := 'LAHORE';
    
    DBMS_OUTPUT.PUT_LINE(V_TYPE_AA_DEPT('DEPARTMENT1'));
    
    V_INDEX_AA := V_TYPE_AA_DEPT.FIRST;
    DBMS_OUTPUT.PUT_LINE(V_INDEX_AA);
    
    V_TYPE_AA_DEPT.DELETE(V_INDEX_AA);
    
    V_INDEX_AA := V_TYPE_AA_DEPT.NEXT(V_INDEX_AA);
    DBMS_OUTPUT.PUT_LINE(V_INDEX_AA);   
END;
/

--NESTED TABLES IN PL/SQL
--single dimension single column of data in each row.
--sparse elements are dense initially but it can become sparese as elements can be removed from in between. 
    --there can be gaps between element.
--unbounded number of elements in the array is not perdefined.
--Nested table can be declared at database level too.

--VARRAY IN PL/SQL
--single dimension --> single column of data in each row.
--dense --> elements are countinuous. there is no gaps between element.
--bounded --> number of elements in the array is predefined.

--COLLECTION METHODS
--varity of methods are available for collection. Methods are applicable on few collection types but not all.

--EXISTS(n): Return true if element at index n exist.
--COUNT: Returns the number of elements in the collection.
--LIMIT: Returns the maximum number of elements for a VARRAY, OR NULL for nested tables.
--PRIOR(n): Returns the index of the element prior to the specified element.

set serverout on;
declare 
    type nt_number is table of number;
    v_nt_number nt_number := nt_number (1, 2, 3, 4, 5);
begin
    if v_nt_number.exists(40) then
        dbms_output.put_line('Element exists');
    else
        dbms_output.put_line('Element do not exists');
    end if;
    
    dbms_output.put_line('v_nt_number.count = ' || v_nt_number.count);
end;
/















   
   
   
   
   
   
   
