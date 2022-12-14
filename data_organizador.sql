/* Ejecutar como Organizador */

/* usuario */
INSERT
INTO abd.usuario (correo, nombre,apellido, contrasena, direccion, telefono)
VALUES ('gp@gmail.com','giselt','parra','pwgp','Caracas','04142240441');

INSERT
INTO abd.usuario (correo, nombre,apellido, contrasena, direccion, telefono)
VALUES ('ds@gmail.com','diego','sanchez','pwds','Caracas','04142240441');

INSERT
INTO abd.usuario (correo, nombre,apellido, contrasena, direccion, telefono)
VALUES ('cm@gmail.com','cristian','martinez','pwcm','Londres','04142240441');

/* evento */
INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento1',1,TO_DATE('10-10-1970', 'MM/DD/YYYY'),TO_DATE('10-20-1970', 'MM/DD/YYYY'),'Descripcion1','Deportes');

INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento2',2,TO_DATE('10-10-1980', 'MM/DD/YYYY'),TO_DATE('10-20-1980', 'MM/DD/YYYY'),'Descripcion2','Emprendimiento');

INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento3',3,TO_DATE('10-10-1990', 'MM/DD/YYYY'),TO_DATE('10-20-1990', 'MM/DD/YYYY'),'Descripcion3','Tecnologia');

/* participa */
INSERT
INTO abd.participa (usuario_fk, evento_fk)
VALUES (2,1);

INSERT
INTO abd.participa (usuario_fk, evento_fk)
VALUES (3,1);

/* dicta */
INSERT 
INTO abd.dicta (usuario_fk, evento_fk,nombre_charla, val_ponencia, val_contenido)
VALUES (1,1,'Charla1',3,4);  

INSERT 
INTO abd.dicta (usuario_fk, evento_fk,nombre_charla, val_ponencia, val_contenido)
VALUES (1,3,'Charla3',1,1);  

INSERT 
INTO abd.dicta (usuario_fk, evento_fk,nombre_charla, val_ponencia, val_contenido)
VALUES (2,3,'Charla2',5,4);  
/* pertenece */
INSERT 
INTO abd.pertenece (usuario_fk, universidad_fk)
VALUES (1,1);  

INSERT 
INTO abd.pertenece (usuario_fk, universidad_fk)
VALUES (2,2);  

INSERT 
INTO abd.pertenece (usuario_fk, universidad_fk)
VALUES (3,3);  
