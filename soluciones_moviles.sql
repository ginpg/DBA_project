/* Ver cuantos MB tiene cada tablespace como referencia*/
select  tablespace_name, 
        bytes / 1024/ 1024  MB
from    dba_data_files;

/* Tablespaces para los archivos de datos y el de indices */
create  tablespace soluciones_moviles_datos
datafile 'soluciones_moviles_datos.dbf' 
size 8M;

create tablespace soluciones_moviles_index
datafile 'soluciones_moviles_index.dbf' 
size 2M;


/* USUARIO ABD PARA LA CREACION DE TABLAS */
create user ABD identified by ABD;
grant CREATE TABLE, CREATE SESSION, CREATE VIEW, CREATE TRIGGER, CREATE ROLE to ABD with ADMIN OPTION;
alter user ABD quota unlimited on soluciones_moviles_datos;
alter user ABD quota unlimited on soluciones_moviles_index;


/* Creacion de tablas */
create table universidad(
   id INT,
   acronimo VARCHAR2(10),
   nombre VARCHAR2(30),
   descripcion VARCHAR2(150),
   f_creacion DATE,
   PRIMARY KEY (id)
) 
tablespace soluciones_moviles_datos;

create table usuario(
   id INT,
   correo VARCHAR2(50) UNIQUE,
   nombre VARCHAR2(30),
   apellido VARCHAR2(30),
   contrasena VARCHAR2(30),
   direccion VARCHAR2(100),
   telefono VARCHAR2(15),
   PRIMARY KEY (id)
) 
tablespace soluciones_moviles_datos;

create table pertenece(
   universidad_fk INT,
   usuario_fk INT,
   f_registro DATE,
   CONSTRAINT pertenece_fk
    FOREIGN KEY (universidad_fk)
    REFERENCES universidad(id),
   CONSTRAINT pertenece_fk2
    FOREIGN KEY (usuario_fk)
    REFERENCES usuario(id)
) 
tablespace soluciones_moviles_datos;

create table evento(
   id INT,
   nombre VARCHAR2(10),
   universidad_fk VARCHAR2(10),
   f_inicio DATE,
   f_final DATE,
   descripcion VARCHAR2(100),
   area NUMBER(1,0),
   PRIMARY KEY (id)
) 
tablespace soluciones_moviles_datos;

create table participa(
   usuario_fk INT,
   evento_fk INT,
   CONSTRAINT participa_fk
    FOREIGN KEY (usuario_fk)
    REFERENCES usuario(id),
   CONSTRAINT participa_fk2
    FOREIGN KEY (evento_fk)
    REFERENCES evento(id)
) 
tablespace soluciones_moviles_datos;

create table dicta(
   usuario_fk INT,
   evento_fk INT,
   nombre_charla VARCHAR2(50),
   val_contenido NUMBER(1,0),
   val_ponencia NUMBER(1,0),
   CONSTRAINT participa_fk3
    FOREIGN KEY (usuario_fk)
    REFERENCES usuario(id),
   CONSTRAINT participa_fk4
    FOREIGN KEY (evento_fk)
    REFERENCES evento(id)
) 
tablespace soluciones_moviles_datos;

create table empresa(
   id INT,
   nombre VARCHAR2(50),
   direccion VARCHAR2(100),
   privada INT,
   telefono VARCHAR2(15),
   PRIMARY KEY (id)
) 
tablespace soluciones_moviles_datos;

create table patrocina(
   evento_fk INT,
   empresa_fk INT,
   aporte NUMBER,
   f_aporte DATE,
   CONSTRAINT patrocina_fk
    FOREIGN KEY (empresa_fk)
    REFERENCES empresa(id),
   CONSTRAINT patrocina_fk2
    FOREIGN KEY (evento_fk)
    REFERENCES evento(id)
) 
tablespace soluciones_moviles_datos;

/* Generar id */
create trigger id_generador_universidad
before insert on universidad
referencing new as new old as old
for each row
declare temp
begin
   select max(id) into temp
   from universidad
   
   if (temp>=1) then
      :new.id = temp+1
   end if
end
/

create trigger id_generador_usuario
before insert on usuario
referencing new as new old as old
for each row
declare temp
begin
   select max(id) into temp
   from usuario
   
   if (temp>=1) then
      :new.id = temp+1
   end if
end
/

create trigger id_generador_evento
before insert on evento
referencing new as new old as old
for each row
declare temp
begin
   select max(id) into temp
   from evento
   
   if (temp>=1) then
      :new.id = temp+1
   end if
end
/

create trigger id_generador_empresa
before insert on empresa
referencing new as new old as old
for each row
declare temp
begin
   select max(id) into temp
   from empresa
   
   if (temp>=1) then
      :new.id = temp+1
   end if
end
/

/* Hasta aqui se ha ejecutado bien */ 
/* ROLES*/
create role Organizador;
grant select, insert, delete, update
on usuario, evento, participa, dicta
to Organizador;

create role Administrador;
grant select, insert, delete, update
on universidad, empresa, patrocina
to Administrador;

/* INDEX */
/* Acceso rapido para charlas de un evento y sus expositores */
create index index_expositores
on dicta(usuario_fk)
tablespace soluciones_moviles_index;

create index index_charlas
on dicta(evento_fk)
tablespace soluciones_moviles_index;

/* Acceso rapido para eventos que ha patrocinado una empresa */
create index index_patrocinantes
on patrocina(empresa_fk)
tablespace soluciones_moviles_index;

create index index_patrocinados
on patrocina(evento_fk)
tablespace soluciones_moviles_index;

/* No se crearon index para claves primarias dado a que Oracle los crea automaticamente */

/* TRIGGERS */
/* Evitar que participante sea expositor y viceversa */
create trigger 
before insert on dicta
declare temp
begin
   select id into temp
   from participa
   where :new.evento_fk = participa.evento_fk and :new.usuario_fk = participa.usuario_fk

   if id exist then 
      raise_application_error('Usuario expositor no puede ser participante en un mismo evento')
   end if
end
/

create trigger 
before insert on participa
declare temp
begin
   select id into tem
   from dicta
   where :new.evento_fk = dicta.evento_fk and :new.usuario_fk = usuario_fk

   if id exist then 
      raise_application_error('Usuario participante no puede ser expositor en un mismo evento')
   end if
end
/

