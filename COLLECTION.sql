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


   
   
   
   
   
   
   
