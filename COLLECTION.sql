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
BEGIN
    V_TYPE_AA_DEPT('DEPARTMENT1') := 'JAMU';
    V_TYPE_AA_DEPT('DEPARTMENT2') := 'LAHORE';
    
    DBMS_OUTPUT.PUT_LINE(V_TYPE_AA_DEPT('DEPARTMENT1'));
END;
   
   
   
   
   
   
   
