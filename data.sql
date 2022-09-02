/* All at once */
INSERT ALL
   INTO abd.universidad (acronimo, nombre, descripcion, f_creacion) VALUES ('ECV', 'Universidad Central Venezuela', 'Descripcion UCV', TO_DATE('10-10-1950', 'MM/DD/YYYY'))
   INTO abd.universidad (acronimo, nombre, descripcion, f_creacion) VALUES ('ESB', 'Universidad Simon Bolivar', 'Descripcion USV', TO_DATE('10-10-1960', 'MM/DD/YYYY'))
   INTO abd.universidad (acronimo, nombre, descripcion, f_creacion) VALUES ('EDO', 'Universidad DE Oriente', 'Descripcion UDO', TO_DATE('10-10-1970', 'MM/DD/YYYY'))
SELECT 1 FROM DUAL;

/* universidad */
INSERT 
INTO abd.universidad (acronimo, nombre, descripcion, f_creacion) 
VALUES ('UCV', 'Universidad Central Venezuela', 'Descripcion UCV', TO_DATE('10-10-1950', 'MM/DD/YYYY'));
INSERT 
INTO abd.universidad (acronimo, nombre, descripcion, f_creacion) 
VALUES ('USB', 'Universidad Simon Bolivar', 'Descripcion USV', TO_DATE('10-10-1960', 'MM/DD/YYYY'));
INSERT 
INTO abd.universidad (acronimo, nombre, descripcion, f_creacion) 
VALUES ('UDO', 'Universidad DE Oriente', 'Descripcion UDO', TO_DATE('10-10-1970', 'MM/DD/YYYY'));

/* empresa*/
INSERT 
INTO abd.empresa (nombre, direccion, privada, telefono)
VALUES ('Polar','Caracas',1,'2515167');
INSERT 
INTO abd.empresa (nombre, direccion, privada, telefono)
VALUES ('P&G','Caracas',1,'2515167');
INSERT 
INTO abd.empresa (nombre, direccion, privada, telefono)
VALUES ('PDVSA','Anzoategui',0,'2515167');

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
VALUES ('Evento1',1,TO_DATE('10-10-1970', 'MM/DD/YYYY'),TO_DATE('10-20-1970', 'MM/DD/YYYY'),'Descripcion1',5);

INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento2',2,TO_DATE('10-10-1980', 'MM/DD/YYYY'),TO_DATE('10-20-1980', 'MM/DD/YYYY'),'Descripcion2',5);

INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento3',3,TO_DATE('10-10-1990', 'MM/DD/YYYY'),TO_DATE('10-20-1990', 'MM/DD/YYYY'),'Descripcion3',5);

/* participa */
INSERT
INTO abd.participa (usuario_fk, evento_fk)
VALUES (2,1);

INSERT
INTO abd.participa (usuario_fk, evento_fk)
VALUES (3,1);

/* dicta */
INSERT 
INTO abd.dicta (usuario_fk, evento_fk,nombre_charla)
VALUES (2,1,'Charla1');  
/*ESTO DEBE DAR ERROR PORQUE YA EXISTE COMO PARTICIPANTE*/

INSERT 
INTO abd.dicta (usuario_fk, evento_fk,nombre_charla)
VALUES (1,1,'Charla1');  

/* pertenece */
INSERT 
INTO pertenece (usuario_fk, universidad_fk)
VALUES (1,1);  

INSERT 
INTO pertenece (usuario_fk, universidad_fk)
VALUES (2,2);  

INSERT 
INTO pertenece (usuario_fk, universidad_fk)
VALUES (3,3);  

/* patrocina */
INSERT
INTO abd.patrocina(evento_fk,empresa_fk,aporte,f_aporte)
VALUES (1,1,100,TO_DATE('10-01-2000', 'MM/DD/YYYY'));

INSERT
INTO abd.patrocina(evento_fk,empresa_fk,aporte,f_aporte)
VALUES (2,2,200,TO_DATE('10-02-2000', 'MM/DD/YYYY'));

INSERT
INTO abd.patrocina(evento_fk,empresa_fk,aporte,f_aporte)
VALUES (3,3,300,TO_DATE('10-03-2000', 'MM/DD/YYYY'));