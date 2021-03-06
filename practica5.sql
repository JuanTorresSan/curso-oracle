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
