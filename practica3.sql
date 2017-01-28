set serveroutput on;

--RECAITULANDO LO QUE ES UN BLOQUE PL SQL

DECLARE 
nombre varchar2(20):='Juan Francisco';
BEGIN
DBMS_OUTPUT.PUT_LINE('BUENAS NOCHEZ '|| nombre);
END;
/



declare 
EDAD INTEGER:=23;
DIAS INTEGER;
ESTATUS varchar2(12);
BEGIN
DIAS:=EDAD*365;
IF DIAS > 10000 THEN
    ESTATUS:='ESTAS VIEJO';
      ELSE
    ESTATUS:='ERES JOVEN';
END IF;
DBMS_OUTPUT.PUT_LINE('TU EDAD EN DIAS ES: ' || DIAS ||' ESTAUS:'||ESTATUS);
END;
/


--VEREMOS NUESTRON PRIMER PROCEDIMIENTO ALMACENADO
CREATE OR REPLACE PROCEDURE saludar(mensaje IN varchar2) 
AS
begin 
DBMS_OUTPUT.PUT_LINE('HOLA BUENAS NOCHES ' ||mensaje);
end;
/

--EJECUTAMOS EL PROCEDIMIENTO 
exec saludar('Juan Francisco Torres'); 


--generamos secuencia 

CREATE SEQUENCE SEC_PERSONA
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

--GENERAMS LA TABLA 
CREATE TABLE PERSONA(ID_PERSONA INTEGER, NOMBRE VARCHAR2(20),EDAD INTEGER, CONSTRAINT PK_ID_PERSONA PRIMARY KEY (ID_PERSONA));


-- Out es para PK    In es para insertar datos 
CREATE OR REPLACE PROCEDURE guardar_persona(my_id OUT integer, my_nombre IN varchar2, my_edad IN integer) 
AS 
BEGIN
SELECT sec_persona.nextval  INTO my_id from DUAL;insert into persona values(my_id, my_nombre, my_edad );
END;
/

declare 
valor integer;
begin
guardar_persona(valor, 'Juan',23);
end;
/

select *from persona;
