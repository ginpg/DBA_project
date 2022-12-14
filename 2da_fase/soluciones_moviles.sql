-- A partir de aqui hay que hacer login con ABD

--#region Create tablas
create table universidad(
   id INT,
   acronimo VARCHAR2(10) UNIQUE,
   nombre VARCHAR2(50),
   descripcion VARCHAR2(150),
   f_creacion DATE,
   PRIMARY KEY (id)
) 
tablespace soluciones_moviles_datos;

create table usuario(
   id INT,
   correo VARCHAR2(50) UNIQUE,
   nombre VARCHAR2(50),
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
   f_registro timestamp default current_timestamp,
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
   area VARCHAR2(100),
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

create table empresa(
   id INT,
   nombre VARCHAR2(50),
   direccion VARCHAR2(100),
   privada CHAR(1),
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
--#endregion

--#region Generar IDs
create or replace trigger id_generador_universidad
before insert on universidad
referencing new as new
for each row
declare nrows INT; max_id INT; 
begin
   select max(id) into max_id
   from abd.universidad;
   select count(*) into nrows
   from abd.universidad;

   if (nrows=0) then
      :new.id := 1;
   else 
      :new.id := max_id+1;
   end if;
end;
/

create or replace trigger id_generador_usuario
before insert on usuario
referencing new as new
for each row
declare nrows INT; max_id INT; 
begin
   select max(id) into max_id
   from abd.usuario;
   select count(*) into nrows
   from abd.usuario;
   
   if (nrows=0) then
      :new.id := 1;
   else 
      :new.id := max_id+1;
   end if;
end;
/

create or replace trigger id_generador_evento
before insert on evento
referencing new as new
for each row
declare nrows INT; max_id INT; 
begin
   select max(id) into max_id
   from abd.evento;
   select count(*) into nrows
   from abd.evento;
   
   if (nrows=0) then
      :new.id := 1;
   else 
      :new.id := max_id+1;
   end if;
end;
/

create or replace trigger id_generador_empresa
before insert on empresa
referencing new as new
for each row
declare nrows INT; max_id INT; 
begin
   select max(id) into max_id
   from abd.empresa;
   select count(*) into nrows
   from abd.empresa;
   
   if (nrows=0) then
      :new.id := 1;
   else 
      :new.id := max_id+1;
   end if;
end;
/
--#endregion 

--#region Roles 
create role Organizador;
grant create session to Organizador;
/*alter role Organizador quota unlimited on soluciones_moviles_datos;*/
grant select, insert, delete, update
on abd.usuario
to Organizador;
grant select, insert, delete, update
on abd.evento
to Organizador;
grant select, insert, delete, update
on abd.participa
to Organizador;
grant select, insert, delete, update
on abd.pertenece
to Organizador;
grant select, insert, delete, update
on abd.dicta
to Organizador;

create role Administrador;
/*alter role Administrador quota unlimited on soluciones_moviles_datos;*/
grant create session to Administrador;
grant select, insert, delete, update
on abd.universidad
to Administrador;
grant select, insert, delete, update
on abd.empresa
to Administrador;
grant select, insert, delete, update
on abd.patrocina
to Administrador;
--#endregion

--#region Asignacion de roles as sys
grant Administrador to Administrador1;
grant Organizador to Organizador1;
--#endregion

--#region Accesos rapidos
/* Acceso rapido para charlas de un evento y sus expositores 
create index index_expositores
on dicta(usuario_fk,)
tablespace soluciones_moviles_index;

create index index_charlas
on dicta(evento_fk)
tablespace soluciones_moviles_index;*/

/* Acceso rapido para eventos que ha patrocinado una empresa 
create index index_patrocinantes
on patrocina(empresa_fk)
tablespace soluciones_moviles_index;

create index index_patrocinados
on patrocina(evento_fk)
tablespace soluciones_moviles_index;*/
/* No se crearon index para claves primarias dado a que Oracle los crea automaticamente */
--#endregion


--#region VIEW para accesos rapidos
/*
CREATE VIEW charlas_view AS
SELECT u.nombre, u.apellido, d.nombre_charla charla, e.nombre evento
FROM usuario u, dicta d, evento e
WHERE u.id = d.usuario_fk and d.evento_fk = e.id;

CREATE VIEW patrocinados_view AS
SELECT e.nombre evento, em.nombre empresa
FROM evento e, empresa em, patrocina p
WHERE e.id = p.evento_fk and em.id = p.empresa_fk;
*/
--#endregion
 
