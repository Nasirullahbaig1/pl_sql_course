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




















