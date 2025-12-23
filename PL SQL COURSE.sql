--Introduction to PL-SQL ORACLE
--Procedural launage in SQL

--PL/SQL Anonymous block 
--Decleration section
--Begin
--Execution sectoin
--Exception section
--END.

--Iteration (LOOP)
--Handeling exceptions
    --system defined exceptions
    --user defined exceptions
--Record type
--cursor
    --implicit cursor
    --explicit cursor

--procedure
--function
--package
--Trigger
--Collections
    --Nested tables
    --Variable sized array or VARRAYs
    --Associated Arrays

--Introduction to PL/SQL
--Anonymous PL/SQL block:
--DECLARE
--variable declaration goes here

SET SERVEROUTPUT ON;
DECLARE
    V_NUM_D NUMBER DEFAULT 10;
    V_NUM NUMBER;
    V_VARCAHR2 VARCHAR2(100) NOT NULL := 'THIS IS DEFALUT VALUE';
    --V_EMP_ID CONSTANT CATEGORIES.CATEGORYID%TYPE :=12;
    --V_EMP_FIRSTNAME NAME.FULLNAME%TYPE;
BEGIN
    dbms_output.put_line('V_NUM_D' || ' = ' || V_NUM_D);
END;
/

--Program to find the sum of two numbers
DECLARE
    a int;
    b int;
    c int;
BEGIN
    a:=&a;
    b:=&b;
    c:=a+b;
    
    dbms_output.put_line('Sum of a and b = ' || c);
END;

--Program to find the greater number
DECLARE 
    x int;
    y int;
    z int;
BEGIN
    x:=&x;
    y:=&y;
    if(x>y)
    then
    dbms_output.put_line('x is greater then y');
    else
    dbms_output.put_line('y is greater then x');
    end if;
END;

--PL/SQL    
    --FUNCTION
    --PROCEDURE
    --TRIGGER
    --CURSOR

CREATE Table department(
    dep_id number(3),
    dep_name varchar2 (100),
    dep_city varchar2 (100)
)

insert into department(dep_id, dep_name, dep_city)
values(1, 'ICT', 'Chitral');

select * from department;

--declare one variable V_num_days as number
--declare one variable V_num_months as number default value as 3
--declare one variable V_birthday as date, not null, default value should be 2002-03-18
--try to update the V_birthday to null and check the result
--create one constant as V_pie_value and default it using assignment operator to 3.14.
--create the variable to store id, name, and city of the department.
--make id as constant with value =1, and department city as not null and initialize with lahore.

DECLARE
    V_num_days NUMBER;
    V_num_months NUMBER DEFAULT 3;
    V_birthday DATE NOT NULL DEFAULT DATE '2002-03-18';
    V_pie_value CONSTANT NUMBER(3,2) := 3.14;
    V_DEPT_ID CONSTANT department.dep_id%TYPE :=1;
    V_DEPT_NAME department.dep_name%TYPE;
    V_DEPT_CITY department.dep_city%TYPE NOT NULL :='Lahore';   
    
BEGIN
    --V_birthday:= null;
    null;
END;
/

--Variable assignment in PL/SQL
--There are three primary ways to perform these assignments.

--Using := operator
--variable_name := value;
DECLARE
   v_count NUMBER := 10; -- Initial assignment
BEGIN
   v_count := v_count + 1; -- Update value
END;
/

--Using INTO operator:
    --SELECT column_name INTO variable_name
    --FROM .....
    --Multiple variable assignments is allowed using INTO clause.
DECLARE
   v_emp_name VARCHAR2(50);
BEGIN
   SELECT last_name INTO v_emp_name FROM employees WHERE employee_id = 100;
END;
/

--Practcal on variable assignment
--use the variable from variable decleration assignment practiacl
--assign any update value to all the variables except constant variables.
--add 2 months to the existing v_birthday and assing it back to v_birthday.
--assign the name of the department and city having max dept id in the departments table.
--assign the month and date of the existing value of v_birthday to v_num_day and v_num_month.

SET SERVEROUTPUT ON;
DECLARE
    V_num_days NUMBER;
    V_num_months NUMBER DEFAULT 3;
    V_birthday DATE NOT NULL DEFAULT DATE '2002-03-18';
    V_pie_value CONSTANT NUMBER(3,2) := 3.14;
    V_DEPT_ID CONSTANT department.dep_id%TYPE :=1;
    V_DEPT_NAME department.dep_name%TYPE;
    V_DEPT_CITY department.dep_city%TYPE NOT NULL :='Lahore';   
    
BEGIN
    V_num_days := 20;
    V_num_months := 10;
    V_birthday := date'2002-03-05';
    V_DEPT_NAME := 'HR';
    V_DEPT_CITY := 'Delhi';
    
    dbms_output.put_line('V_num_days = ' || V_num_days);
    dbms_output.put_line('V_num_months = ' || V_num_months);
    dbms_output.put_line('V_birthday = ' || V_birthday);
    dbms_output.put_line('V_DEPT_NAME = ' || V_DEPT_NAME);
    dbms_output.put_line('V_DEPT_CITY = ' || V_DEPT_CITY);
    
    V_birthday := add_months(V_birthday,2);
    dbms_output.put_line('V_birthday = ' || V_birthday);
    
    SELECT dep_name, dep_city INTO V_DEPT_NAME, V_DEPT_CITY
    FROM department ORDER BY dep_id desc fetch first row only;
    dbms_output.put_line('V_DEPT_NAME = ' || V_DEPT_NAME);
    dbms_output.put_line('V_DEPT_CITY = ' || V_DEPT_CITY);
    
    V_num_days := TO_CHAR(V_birthday,'DD');
    V_num_months := TO_CHAR(V_birthday, 'MM');
    dbms_output.put_line('V_num_days = ' || V_num_days);
    dbms_output.put_line('V_num_months = ' || V_num_months);
END;
/

--Working with variables
--Variable assignment can be done repetatively.
--all SQL operations can be done on the variable like they can be used in 
--SELECT, UPDATE, DELECT statements too.
CREATE Table employee(
    emp_id number(3),
    emp_name varchar2 (100),
    salary number (15)
);
insert into employee(emp_id, emp_name, salary)
values(1, 'nasir', 30000);
insert into employee(emp_id, emp_name, salary)
values(2, 'mustan', 35000);
insert into employee(emp_id, emp_name, salary)
values(3, 'annie', 25000);
insert into employee(emp_id, emp_name, salary)
values(4, 'faizan', 44000);
insert into employee(emp_id, emp_name, salary)
values(5, 'aftab', 60000);

DECLARE
    v_salary employee.salary%type;
    v_half_salary employee.salary%type;
    v_half_salary_plue employee.salary%type;
    v_emp_id employee.emp_id%type;
    v_emp_name employee.emp_name%type;
BEGIN
    select max(salary) into v_salary from employee;
    dbms_output.put_line('v_salary = ' || v_salary);
    
    select count(*)into v_half_salary from employee where salary <= v_salary/2;
    dbms_output.put_line('v_half_salary_count = ' || v_half_salary);
    
    select max(salary) into v_half_salary_plue from employee where salary <= v_salary/2; 
    dbms_output.put_line('Max v_half_salary_plue = ' || v_half_salary_plue);
    
    select emp_id, emp_name into v_emp_id, v_emp_name from employee where salary = v_half_salary_plue;
    dbms_output.put_line('v_emp_id = ' || v_emp_id);
    dbms_output.put_line('v_emp_name = ' || v_emp_name);
END;
/

select * from department;
insert into department(dep_id, dep_name, dep_city)
values(2, 'HR', 'Chitral');
insert into department(dep_id, dep_name, dep_city)
values(3, 'ICT', 'Lahore');
insert into department(dep_id, dep_name, dep_city)
values(4, 'HR', 'Karachi');
insert into department(dep_id, dep_name, dep_city)
values(5, 'ICT', 'Chitral');
insert into department(dep_id, dep_name, dep_city)
values(6, 'DEV', 'Lahore');
insert into department(dep_id, dep_name, dep_city)
values(7, 'DEV', 'Chitral');

--Working with variables practical
--Declare one variable v_luckey number
--count total number of departments and assign it to v_luckey_number variable
--multiply salary and employee_id and take the third last digit from that value and order employee according
--to that number in decending order.
--take first v_luckey_number employee from that ordered employee and update their salary by v_luckey_number.

DECLARE
    
BEGIN

END
/













