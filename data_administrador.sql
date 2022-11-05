/* Ejecutar como Administrador */

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
VALUES ('PG','Caracas',1,'2515167');
INSERT 
INTO abd.empresa (nombre, direccion, privada, telefono)
VALUES ('PDVSA','Anzoategui',0,'2515167');

/* patrocina 
INSERT
INTO abd.patrocina(evento_fk,empresa_fk,aporte,f_aporte)
VALUES (1,1,100,TO_DATE('10-01-2000', 'MM/DD/YYYY'));

INSERT
INTO abd.patrocina(evento_fk,empresa_fk,aporte,f_aporte)
VALUES (3,3,200,TO_DATE('10-02-2019', 'MM/DD/YYYY'));

INSERT
INTO abd.patrocina(evento_fk,empresa_fk,aporte,f_aporte)
VALUES (2,2,300,TO_DATE('10-03-2020', 'MM/DD/YYYY'));
*/