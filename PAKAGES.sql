--PAKAGES IN PL/SQL

--Pakage is the schema object stored in the database.
--it can contain related objects within it.

--Generally following objects are used in the pakage:
    --Procedure
    --Function
    --Variable
    --Cursor
    --Constant
    --Exception etc.
--Pakage consist of two parts
    --Pakage specification
    --Pakage Body(optional)
--Pakage body is mandatory when pakage specification contains cursor or sub-program.
--Object declared in the specification are public and it can be accessed from anywhere
--in the same schema.

--Pakage body contains the implementation of the cursor or sub-program declared in the package specification.

--Pakage body can have private cursor, sub-progam, varaible etc also which are not declared in the pakage specification.
--Private objects are accessible to package body only.

--Why to use Pakage?
--Pakages encapsulate logically related types, varaibles, constants, sub-programs, cursors and exceptions in named PL/SQL.
--It increase the readability and make it easy to manage.
--Pakage hides the implementation and expose the functionality only.
--Pakages aare loaded into memory for the first invocation of the sub-progarm. 
--subsequent calls of the sub-prgrams do not need to lead it into the memory.
--Recompliation is not done when sub-program implementation(package body) is changed.
--Grant to the package is given. Individual grant of the sub progarm is not needed then.

--Pakage specificaion
--Pakage specification include only functionality and not implementation.
--Public item can be decalred in the specification.
--scope of the items declared in the specification is entire schema in which pakage is created.
--Oracle will create a separeate instance of the package for each session that references to the pakages items.
--if the package specification has at least one varaible, constant or cursor the package is stateful or else it stateless.

--sentax:
--CREATE [OR REPLACE] PACKAGE pakage_name AS 
--  declaration;
--END pakage_name;

CREATE OR REPLACE PACKAGE pkg_fisrt_package AS
    v_my_fisrt_variable NUMBER;
    PROCEDURE my_pkg_first_proc (
        p_in_varchar IN VARCHAR2
    );

    PROCEDURE my_pkg_second_proc (
        p_in_varchar IN VARCHAR2
    );

    FUNCTION my_first_pkg_function (
        p_in_number IN NUMBER
    ) RETURN NUMBER;

END pkg_fisrt_package;
/

--PACKAGE BODY
--If the paakages specification has cursors or sub-programs, then the packages body is mendatory.
--Both the package body and package specification must be in the same schema.
--Each cursor or sub-program declared in the package specification must have implementation in the package body.
--Package body can have additional curosr or sub-progarm which is private to package body and accessible to only package body.
--Pakage body initilizatin part is only executed once3 when package is referenced fisrt time.
--syntax:
--  CREATE [OR REPLACE] PACKAGE BODY package_name IS | AS
--      varaible declaration;
--      subprogram implementations;
--      [BEGIN
--      EXCEPTION]
--  END [<package_name>];
/
--Assignment part-1: Package
--1. Create utility package to have three different procedure in it.
--  all the varables should be public (in package specification)
--  One procedure should output the second highest employees id and salary of the given departmnet id.
--  One function to return Y/N if salary of employee is greater then the avarage salary of all employee of his department.
--  One procedure to log the logs entry.
--  third procedure should update the department_id of the second heighest employee of the department of the given employee to input department_id.
--      call the first procedure and second procedure in it to fatch the employee/department details and log it in the logs table as per conviences.
--  call different procedure of the package in anonymous block and try to use initilize method and access the variable.
/
--SPECEFICATION
CREATE OR REPLACE PACKAGE pkg_emp_utill_1 AS
    V_DEPT_EMP_CNT         NUMBER;
    V_IS_SALARY_HIGH_THEN_DEPT_SALARY VARCHAR2 (1);
    
    --Procedure
    PROCEDURE p_second_highest_emp (
        p_in_department_id IN departments.department_id%TYPE,
        p_out_emp_id       OUT employees.employee_id%TYPE,
        p_out_emp_salary   OUT employees.salary%TYPE,
        P_OUT_STATUS       OUT NUMBER
    );
    
    --function
    FUNCTION FUN_IS_SALARAY_ABOVE_AVG_DEPT_SALARY(P_IN_EMP_ID IN EMPLOYEES.EMPLOYEE_ID%TYPE) 
    RETURN VARCHAR2;

END pkg_emp_utill_1;
/
--BODY
CREATE OR REPLACE PACKAGE BODY pkg_emp_utill_1 AS
    --procedure
    PROCEDURE p_second_highest_emp (
        p_in_department_id IN departments.department_id%TYPE,
        p_out_emp_id       OUT employees.employee_id%TYPE,
        p_out_emp_salary   OUT employees.salary%TYPE,
        p_out_status       OUT NUMBER
    ) IS
    BEGIN
        p_out_status := 0;
        SELECT
            COUNT(1)
        INTO v_dept_emp_cnt
        FROM
            employees
        WHERE
            department_id = p_in_department_id;

        IF v_dept_emp_cnt < 2 THEN
            p_out_status := -1;
        ELSE
            SELECT
                employee_id,
                salary
            INTO
                p_out_emp_id,
                p_out_emp_salary
            FROM
                employees
            WHERE
                department_id = p_in_department_id
            ORDER BY
                salary DESC,
                employee_id
            OFFSET 1 ROW FETCH NEXT 1 ROW ONLY;

        END IF;

    END p_second_highest_emp;
    
    --function
    FUNCTION FUN_IS_SALARAY_ABOVE_AVG_DEPT_SALARY(P_IN_EMP_ID IN EMPLOYEES.EMPLOYEE_ID%TYPE) 
    RETURN VARCHAR2
    IS 
    BEGIN
        SELECT CASE WHEN SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES 
        WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = P_IN_EMP_ID))
        THEN 'Y' 
        ELSE 'N' 
        END
        INTO V_IS_SALARY_HIGH_THEN_DEPT_SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = P_IN_EMP_ID;
        RETURN V_IS_SALARY_HIGH_THEN_DEPT_SALARY;
    END FUN_IS_SALARAY_ABOVE_AVG_DEPT_SALARY;


END pkg_emp_utill_1;
/
SET SERVEROUT ON
DECLARE
    V_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
    V_SALARY EMPLOYEES.SALARY%TYPE;
    V_STATUS NUMBER :=0;
BEGIN
    pkg_emp_utill_1.p_second_highest_emp(90, V_EMP_ID, V_SALARY, V_STATUS);
    DBMS_OUTPUT.PUT_LINE('STATUS: ' || V_STATUS);
    DBMS_OUTPUT.PUT_LINE('EMP_ID: ' || V_EMP_ID);
    DBMS_OUTPUT.PUT_LINE('SALARY: ' || V_SALARY);
END;
/
SELECT pkg_emp_utill_1.FUN_IS_SALARAY_ABOVE_AVG_DEPT_SALARY(101) FROM DUAL;
SELECT * FROM EMPLOYEES;













