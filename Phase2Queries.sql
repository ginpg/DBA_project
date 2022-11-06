EXPLAIN PLAN SET STATEMENT_ID = 'Q1_lleno' FOR 
SELECT usuario.nombre, usuario.apellido, dicta.nombre_charla, evento.nombre
FROM usuario, dicta, evento, universidad
WHERE usuario.id = dicta.usuario_fk AND dicta.evento_fk = evento.id AND evento.universidad_fk = universidad.id AND universidad.acronimo = 'UCV';

SPOOL C:\Users\Grimilda\Documents\Semestre\ABD\Proyecto\Comandos\answer.txt

SELECT OPERATION, OBJECT_NAME FROM plan_table WHERE STATEMENT_ID = 'Q1_lleno';

EXPLAIN PLAN SET STATEMENT_ID = 'Q2_lleno' FOR 
SELECT empresa.nombre, evento.nombre, patrocina.f_aporte
FROM empresa, evento, patrocina
WHERE empresa.privada = 1 AND empresa.id = patrocina.empresa_fk AND evento.id = patrocina.empresa_fk AND evento.area = 'Tecnologia' and extract( year from evento.f_inicio) = 2019 AND  extract( year from evento.f_final) = 2021;

SELECT OPERATION, OBJECT_NAME FROM plan_table WHERE STATEMENT_ID = 'Q2_lleno';

--#region Inseriones Q1 y Q2
INSERT
INTO abd.usuario (correo, nombre,apellido, contrasena, direccion, telefono)
VALUES ('gp@gmail.com','giselt','parra','pwgp','Caracas','04142240441');
INSERT
INTO abd.usuario (correo, nombre,apellido, contrasena, direccion, telefono)
VALUES ('ds@gmail.com','diego','sanchez','pwds','Caracas','04142240441');
INSERT
INTO abd.usuario (correo, nombre,apellido, contrasena, direccion, telefono)
VALUES ('cm@gmail.com','cristian','martinez','pwcm','Londres','04142240441');

INSERT 
INTO abd.universidad (acronimo, nombre, descripcion, f_creacion) 
VALUES ('UCV', 'Universidad Central Venezuela', 'Descripcion UCV', TO_DATE('10-10-1950', 'MM/DD/YYYY'));
INSERT 
INTO abd.universidad (acronimo, nombre, descripcion, f_creacion) 
VALUES ('USB', 'Universidad Simon Bolivar', 'Descripcion USV', TO_DATE('10-10-1960', 'MM/DD/YYYY'));
INSERT 
INTO abd.universidad (acronimo, nombre, descripcion, f_creacion) 
VALUES ('UDO', 'Universidad de Oriente', 'Descripcion UDO', TO_DATE('10-10-1970', 'MM/DD/YYYY'));
INSERT 
INTO abd.universidad (acronimo, nombre, descripcion, f_creacion) 
VALUES ('UCAB', 'Universidad Catolica Andres Bello', 'Descripcion UCAB', TO_DATE('10-10-1980', 'MM/DD/YYYY'));

INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento1',1,TO_DATE('10-10-1970', 'MM/DD/YYYY'),TO_DATE('10-20-1970', 'MM/DD/YYYY'),'Descripcion1','Tecnologia');
INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento2',1,TO_DATE('10-10-2020', 'MM/DD/YYYY'),TO_DATE('10-20-2020', 'MM/DD/YYYY'),'Descripcion1','Tecnologia');
INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento3',2,TO_DATE('10-10-2020', 'MM/DD/YYYY'),TO_DATE('10-20-2020', 'MM/DD/YYYY'),'Descripcion1','Deportes');


INSERT
INTO abd.dicta (usuario_fk, evento_fk,nombre_charla, val_ponencia, val_contenido)
VALUES (1,1,'Charla1',3,4);
INSERT
INTO abd.dicta (usuario_fk, evento_fk,nombre_charla, val_ponencia, val_contenido)
VALUES (2,2,'Charla2',3,4);
INSERT
INTO abd.dicta (usuario_fk, evento_fk,nombre_charla, val_ponencia, val_contenido)
VALUES (1,1,'Charla3',2,2);
--#endregion


--#region Insercion en anos de eventos
INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento4',3,TO_DATE('10-10-1920', 'MM/DD/YYYY'),TO_DATE('10-20-1970', 'MM/DD/YYYY'),'Descripcion1','Tecnologia');
INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento3',3,TO_DATE('10-10-2019', 'MM/DD/YYYY'),TO_DATE('10-20-2020', 'MM/DD/YYYY'),'Descripcion1','Tecnologia');
INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento4',2,TO_DATE('10-10-2020', 'MM/DD/YYYY'),TO_DATE('10-20-2020', 'MM/DD/YYYY'),'Descripcion1','Deportes');
--#endregion

EXPLAIN PLAN SET STATEMENT_ID = 'Q2_masregistros' FOR 
SELECT empresa.nombre, evento.nombre, patrocina.f_aporte
FROM empresa, evento, patrocina
WHERE empresa.privada = 1 AND empresa.id = patrocina.empresa_fk AND evento.id = patrocina.empresa_fk AND evento.area = 'Tecnologia' and extract( year from evento.f_inicio) = 2019 AND  extract( year from evento.f_final) = 2021;

SELECT OPERATION, OBJECT_NAME FROM plan_table WHERE STATEMENT_ID = 'Q2_masregistros';