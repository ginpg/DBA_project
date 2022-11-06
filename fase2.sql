/* select * from abd.usuario; */
/* select * from abd.dicta; */
/* select * from abd.evento; */
/* select * from abd.universidad; */

-- Registros involucrados Query 1
-- Los inserts se corren con el usuario ABD
INSERT
INTO abd.usuario (id, correo, nombre,apellido, contrasena, direccion, telefono)
VALUES (1, 'gp@gmail.com','giselt','parra','pwgp','Caracas','04142240441');

INSERT
INTO abd.universidad (id, acronimo, nombre, descripcion, f_creacion)
VALUES (1, 'UCV', 'Universidad Central Venezuela', 'Descripcion UCV', TO_DATE('10-10-1950', 'MM/DD/YYYY'));

INSERT
INTO abd.evento (id, nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES (1, 'Evento1',1,TO_DATE('10-10-1970', 'MM/DD/YYYY'),TO_DATE('10-20-1970', 'MM/DD/YYYY'),'Descripcion1','Tecnologia');

INSERT
INTO abd.dicta (usuario_fk, evento_fk,nombre_charla, val_ponencia, val_contenido)
VALUES (1,1,'Charla1',3,4);
-- FIN Registros involucrados Query 1

-- Primer Query
--- Ejecutar con el usuario SYS
EXPLAIN PLAN FOR
  SELECT usuario.nombre, usuario.apellido, dicta.nombre_charla, evento.nombre
  FROM abd.usuario, abd.dicta, abd.evento, abd.universidad
  WHERE usuario.id = dicta.usuario_fk AND dicta.evento_fk = evento.id AND evento.universidad_fk = universidad.id AND universidad.acronimo = 'UCV';

-- Imprimir plan de ejecución
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(format => 'BASIC'));


-- Registros involucrados Query 2
-- Los inserts se corren con el usuario ABD
INSERT
INTO abd.empresa (id, nombre, direccion, privada, telefono)
VALUES (1, 'Polar','Caracas',1,'2515167');

INSERT
INTO abd.evento (id, nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES (2, 'EventPolar',1,TO_DATE('10-10-2019', 'MM/DD/YYYY'),TO_DATE('10-20-2019', 'MM/DD/YYYY'),'Cerveza Polar UCV','Tecnologia');

INSERT
INTO abd.evento (id, nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES (3, 'EventPolar',1,TO_DATE('11-10-2021', 'MM/DD/YYYY'),TO_DATE('11-12-2021', 'MM/DD/YYYY'),'Cerveza Polar UCV 2','Tecnologia');

INSERT
INTO abd.patrocina(evento_fk,empresa_fk,aporte,f_aporte)
VALUES (2, 1,100,TO_DATE('10-20-2019', 'MM/DD/YYYY'));

INSERT
INTO abd.patrocina(evento_fk,empresa_fk,aporte,f_aporte)
VALUES (3, 1, 200,TO_DATE('11-10-2021', 'MM/DD/YYYY'));
-- FIN Registros involucrados Query 2

-- Segundo Query
--- Ejecutar con el usuario SYS
EXPLAIN PLAN FOR
  SELECT empresa.nombre, evento.nombre, patrocina.f_aporte
  FROM empresa, evento, patrocina
  WHERE empresa.privada = 1 AND empresa.id = patrocina.empresa_fk AND evento.id = patrocina.empresa_fk AND evento.area = 'Tecnologia' and extract( year from evento.f_inicio) = 2019 OR extract( year from evento.f_final) = 2021;

