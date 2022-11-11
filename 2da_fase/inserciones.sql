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
INTO abd.empresa (nombre, direccion, privada, telefono)
VALUES ('Polar','Caracas',1,'2515167');
INSERT 
INTO abd.empresa (nombre, direccion, privada, telefono)
VALUES ('PG','Caracas',1,'2515167');
INSERT 
INTO abd.empresa (nombre, direccion, privada, telefono)
VALUES ('PDVSA','Anzoategui',0,'2515167');

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

/* Insercion en anos de eventos */
INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento4',3,TO_DATE('10-10-1920', 'MM/DD/YYYY'),TO_DATE('10-20-1970', 'MM/DD/YYYY'),'Descripcion1','Tecnologia');
INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento3',3,TO_DATE('10-10-2019', 'MM/DD/YYYY'),TO_DATE('10-20-2020', 'MM/DD/YYYY'),'Descripcion1','Tecnologia');
INSERT
INTO abd.evento (nombre,universidad_fk,f_inicio,f_final,descripcion,area)
VALUES ('Evento4',2,TO_DATE('10-10-2020', 'MM/DD/YYYY'),TO_DATE('10-20-2020', 'MM/DD/YYYY'),'Descripcion1','Deportes');


INSERT
INTO abd.patrocina(evento_fk,empresa_fk,aporte,f_aporte)
VALUES (1,1,100,TO_DATE('10-01-2000', 'MM/DD/YYYY'));
INSERT
INTO abd.patrocina(evento_fk,empresa_fk,aporte,f_aporte)
VALUES (3,3,200,TO_DATE('10-02-2019', 'MM/DD/YYYY'));
INSERT
INTO abd.patrocina(evento_fk,empresa_fk,aporte,f_aporte)
VALUES (2,2,300,TO_DATE('10-03-2020', 'MM/DD/YYYY'));
--#endregion