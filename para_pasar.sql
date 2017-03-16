create table papa(id integer primary key,nombre varchar2(40),edad integer);
create table hijomayor(id integer primary key, nombre varchar2(40), edad integer);
create table hijomenor(id integer primary key, nombre varchar2(40),edad integer);


create or replace trigger disp_papa after insert on papa for each row 
begin
if : new.edad > 18 then
insert into hijomayor values(:new.id, :new.nombre, :new.edad);
else
insert into hijomenor values(:new.id, :new.nombre, :new.edad);
end if;
end;
/

insert into papa values(1,'izzra',24);
insert into papa values(2,'Dani',17);

--hacemos un select en papa
select * from papa;
select * from hijomayor;
select * from hijomenor;


create table trabajador(id integer primary key, nombre varchar2(20), sueldo_base float);
create table respaldo(id integer primary key, nombre varchar2(20), sueldo_base float);

create or replace trigger disp_trabajador after insert on respaldo for each row
begin
if:  new.id = 3 then
for id
insert into respadldo values(:new.id, :new.nombre, :new.sueldo_base ); 
