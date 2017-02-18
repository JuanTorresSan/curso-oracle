set serveroutput on;

--generamos secuencia para PELICULAS 
CREATE SEQUENCE SEC_PELICULA
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

--generamos secuencia para HORARIO 
CREATE SEQUENCE SEC_HORARIO
START WITH 1
INCREMENT BY 1
NOMAXVALUE;


-- GENETAR TABLAS
CREATE TABLE PELICULA(ID_PELICULA INTEGER, TITULO VARCHAR2(20),SINOPSIS VARCHAR2(100), CONSTRAINT PK_ID_PELICULA PRIMARY KEY (ID_PELICULA));

CREATE TABLE HORARIOS(ID_HORARIO INTEGER, ID_PELICULA INTEGER,FECHA DATE, CONSTRAINT PK_ID_HORARIO PRIMARY KEY (ID_HORARIO), CONSTRAINT FK2_ID_PELICULA foreign key (ID_PELICULA) REFERENCES PELICULA (ID_PELICULA));

CREATE TABLE SALAS(NUM_SALA INTEGER, ID_PELICULA INTEGER, CONSTRAINT PK_NUM_SALA PRIMARY KEY (NUM_SALA), CONSTRAINT FK1_ID_PELICULAS foreign key (ID_PELICULA) REFERENCES PELICULA (ID_PELICULA));


--RPOCEDIMINETOS
CREATE OR REPLACE PROCEDURE GUARDAR_PELICULA(MY_ID_PELICULA OUT INTEGER, MY_TITULO IN VARCHAR2, MY_SINOPSIS  IN VARCHAR2)
AS
BEGIN
SELECT SEC_PELICULA.NEXTVAL INTO MY_ID_PELICULA FROM DUAL;
INSERT INTO PELICULA VALUES(MY_ID_PELICULA, MY_TITULO,MY_SINOPSIS);
END;
/

CREATE OR REPLACE PROCEDURE GUARDAR_SALA (MY_NUM_SALA IN INTEGER, MY_ID_PELICULA IN INTEGER)
AS
BEGIN
INSERT INTO SALAS VALUES (MY_NUM_SALA, MY_ID_PELICULA);
END;
/

CREATE OR REPLACE PROCEDURE GUARDAR_HORARIOS(MY_ID_HORARIOS OUT INTEGER, MY_ID_PELICULA IN INTEGER, MY_FECHA IN DATE)
AS
BEGIN
SELECT SEC_HORARIO.NEXTVAL INTO MY_ID_HORARIOS FROM DUAL;
INSERT INTO HORARIOS VALUES(MY_ID_HORARIOS, MY_ID_PELICULA, MY_FECHA);
END;
/


----------------------------------------------------------------------------------
create table dance(id_dance integer,nombre varchar2(20),edad integer, constraint pk_id_dance primary key(id_dance));

insert into dance values (1,'Juan',19);
insert into dance values (2,'Pedro',20);
insert into dance values (3,'Luis',45);
insert into dance values (4,'Jose',70);
insert into dance values (5,'Victor',16);

select * from dance;

select nombre,edad from dance where edad < 18 as  ;

declare
estatus varchar2(20);
cursor cur1  is select * from dance;  -- Declaracion del cursos 
--cursos "nombreCursor"
begin
  for rec in cur1 loop
--for "variable" in "cursor" loop
-- por cada linera del cursor haras lo siguinte 
if rec.edad < 18 then 
     estatus:='precoz';
     dbms_output.put_line('nombre '||rec.nombre||' edad '||rec.edad||' estatus '||estatus);
     else
     estatus:='viejo';
     dbms_output.put_line('nombre '||rec.nombre||' edad '||rec.edad||' estatus '||estatus);
  end if;
  end loop;
  end;
  /
  
--------------------------------------------------------

create table trabajador(seguro integer,nombre varchar(25), edad integer,constraint pk_seguro primary key(seguro));
create table nomina(id_nomina integer,seguro integer, sueldo_base float, horas_laboradas integer, fecha_pago date, 
constraint pk_nomina primary key(id_nomina), constraint fk_seguro foreign key(seguro) references trabajador );

insert into trabajador values(1, 'Ana','28');
insert into trabajador values(2, 'Pedro','40');
insert into trabajador values(3, 'Juan','35');
insert into trabajador values(4, 'Karla','41');

insert into nomina(seguro,id_nomina,sueldo_base,horas_laboradas) values(1,1,6000,40);
insert into nomina(seguro,id_nomina,sueldo_base,horas_laboradas) values(2,2,8000,30);
insert into nomina(seguro,id_nomina,sueldo_base,horas_laboradas) values(3,3,7000,42);
insert into nomina(seguro,id_nomina,sueldo_base,horas_laboradas) values(4,4,10000,48);

select * from nomina; 

--secuendia de nomina 
CREATE SEQUENCE SEC_NOMINA
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

CREATE OR REPLACE PROCEDURE GUARDAR_NOMINA(MY_ID_NOMINA OUT INTEGER, MY_SEGURO IN INTEGER, MY_SUELDO_BASE IN INTEGER)
AS
BEGIN
SELECT SEC_NOMINA.NEXTVAL INTO MY_ID_NOMINA FROM DUAL;
INSERT INTO NOMINA(ID_NOMINA, SEGURO, SUELDO_BASE) VALUES(MY_ID_NOMINA, MY_SEGURO,MY_SUELDO_BASE);
END;
/

CREATE OR REPLACE PROCEDURE GENERAR_TRABAJADOR(MY_SEGURO IN INTEGER, MY_NOMBRE IN VARCHAR2, MY_EDAD IN INTEGER, MY_ID_NOMINA OUT INTEGER, MY_SUELDO_BASE IN FLOAT)
AS
BEGIN
INSERT INTO TRABAJADOR VALUES(MY_SEGURO, MY_NOMBRE, MY_EDAD);
GUARDAR_NOMINA(MY_ID_NOMINA, MY_SEGURO, MY_SUELDO_BASE);
END;
/

DECLARE 
VALOR INTEGER;
BEGIN
GENERAR_TRABAJADOR(1, 'Ana','28',VALOR,6000);
GENERAR_TRABAJADOR(2, 'Pedro','40',VALOR,8000);
GENERAR_TRABAJADOR(3, 'Juan','35',VALOR,7000);
GENERAR_TRABAJADOR(4, 'karla','41',VALOR,10000);
END
/
select * from trabajador;
select * from nomina;




--ESTRUCTURA DE UN CURSOR BASICO
DECLARE
CURSOR CUR_1 IS SELECT * FROM TRABAJADOR; 
CURSOR CUR_2 IS SELECT * FROM NOMINA;

BEGIN
FOR REC IN CUR_1 LOOP
FOR REC2 IN CUR_2 LOOP
IF REC2.SEGURO = REC.SEGURO THEN
DBMS_OUTPUT.PUT_LINE('NOMBRE '|| REC.NOMBRE ||' EDAD '|| REC.EDAD || ' SUELDO_BASE ' || REC2.SUELDO_BASE);
END IF;
END LOOP;
END LOOP;
END;
/

SELECT * FROM NOMINA;
-- CURSORES CON UPDATE¡¡¡¡¡¡
DECLARE
CURSOR CUR_3 IS SELECT * FROM NOMINA FOR UPDATE;
BEGIN
FOR REC IN CUR_3 LOOP
UPDATE NOMINA SET HORAS_LABORADAS = 40  WHERE CURRENT OF CUR_3;
END LOOP;
END;
/
