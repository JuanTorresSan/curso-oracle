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
