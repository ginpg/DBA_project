-- Ejecutar este script como sys
-- Ingresar como ABD
-- Luego ejectuar soluciones_moviles.sql

--#region Tablespaces para los archivos de datos y el de indices
create  tablespace soluciones_moviles_datos
datafile 'soluciones_moviles_datos.dbf' 
size 8M;

create tablespace soluciones_moviles_index
datafile 'soluciones_moviles_index.dbf' 
size 2M;
--#endregion

--#region Usuario ABD para la creacion de tablas
create user ABD identified by ABD;

--#region Usuarios que obtienen roles
create user Administrador1 identified by Administrador1;
create user Organizador1 identified by Organizador1;
--#endregion

grant CREATE TABLE, CREATE SESSION, CREATE VIEW, CREATE TRIGGER, CREATE ROLE to ABD with ADMIN OPTION;
alter user ABD quota unlimited on soluciones_moviles_datos;
alter user ABD quota unlimited on soluciones_moviles_index;
--#endregion
