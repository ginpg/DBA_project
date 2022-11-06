-- Primer Query
SELECT usuario.nombre, usuario.apellido, dicta.nombre_charla, evento.nombre
FROM usuario, dicta, evento, universidad
WHERE usuario.id = dicta.usuario_fk AND dicta.evento_fk = evento.id AND evento.universidad_fk = universidad.id AND universidad.acronimo = "UCV";

-- Segundo Query
SELECT empresa.nombre, evento.nombre, patrocina.f_aporte;
FROM empresa, evento, patrocina
WHERE empresa.privada = 1 AND empresa.id = patrocina.empresa_fk AND evento.id = patrocina.empresa_fk AND evento.area = "Tecnologia" and extract( year from evento.f_inicio) = 2019 AND  extract( year from evento.f_final) = 2021;

-- Registros involucrados Query 1

INSERT
INTO abd.usuario (id, correo, nombre,apellido, contrasena, direccion, telefono)
VALUES (1, 'gp@gmail.com','giselt','parra','pwgp','Caracas','04142240441');

INSERT
INTO abd.usuario (id, correo, nombre,apellido, contrasena, direccion, telefono)
VALUES (2, 'ds@gmail.com','diego','sanchez','pwds','Caracas','04142240441');

INSERT
INTO abd.usuario (id, correo, nombre,apellido, contrasena, direccion, telefono)
VALUES (3, 'cm@gmail.com','cristian','martinez','pwcm','Londres','04142240441');

INSERT
INTO abd.universidad (id, acronimo, nombre, descripcion, f_creacion)
VALUES (1, 'UCV', 'Universidad Central Venezuela', 'Descripcion UCV', TO_DATE('10-10-1950', 'MM/DD/YYYY'));

INSERT
INTO abd.evento (id, nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES (1, 'Evento1',1,TO_DATE('10-10-1970', 'MM/DD/YYYY'),TO_DATE('10-20-1970', 'MM/DD/YYYY'),'Descripcion1','Tecnologia');

INSERT
INTO abd.evento (id, nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES (2, 'Evento2',2,TO_DATE('10-10-2020', 'MM/DD/YYYY'),TO_DATE('10-20-2020', 'MM/DD/YYYY'),'Descripcion1','Tecnologia');

INSERT
INTO abd.dicta (usuario_fk, evento_fk,nombre_charla, val_ponencia, val_contenido)
VALUES (1,1,'Charla1',3,4);

INSERT
INTO abd.dicta (usuario_fk, evento_fk,nombre_charla, val_ponencia, val_contenido)
VALUES (2,2,'Charla2',3,4);

-- Registros involucrados Query 2

INSERT
INTO abd.empresa (nombre, direccion, privada, telefono)
VALUES ('Polar','Caracas',1,'2515167');
