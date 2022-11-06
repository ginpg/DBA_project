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
   val_contenido INTEGER,
   val_ponencia INTEGER,
   CONSTRAINT participa_fk3
    FOREIGN KEY (usuario_fk)
    REFERENCES usuario(id),
   CONSTRAINT participa_fk4
    FOREIGN KEY (evento_fk)
    REFERENCES evento(id),
   CONSTRAINT check_puntuacion_ponencia CHECK (
      val_ponencia BETWEEN 1 AND 5
   ),
   CONSTRAINT check_puntuacion_contenido CHECK (
      val_contenido BETWEEN 1 AND 5
   )
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
--#endregion

--#region TRIGGER. Evitar que participante sea expositor y viceversa
SHOW ERRORS TRIGGER restriccion1;
create or replace trigger restriccion1
before insert on dicta
referencing new as new
for each row
declare existe_participante INT; existe_duplicado INT;
begin
   select count(*) into existe_participante
   from abd.participa
   where :new.evento_fk = abd.participa.evento_fk and :new.usuario_fk = abd.participa.usuario_fk;

   select count(*) into existe_duplicado
   from abd.dicta
   where :new.evento_fk = abd.dicta.evento_fk and :new.usuario_fk = abd.dicta.usuario_fk;

   --dbms_output.put_line(existe_participante);
   if (existe_participante>0) then 
      raise_application_error(-20000, 'Usuario expositor no puede ser participante en un mismo evento');
   end if;

   --dbms_output.put_line(existe_duplicado);
   if (existe_duplicado>0) then 
      raise_application_error(-20000, 'Usuario expositor ya existe en este evento');
   end if;

   :new.val_contenido := 0;
   :new.val_ponencia := 0;
end;
/

create or replace trigger restriccion2
before insert on participa
referencing new as new
for each row
declare temp INT; 
begin
   select count(*) into temp
   from abd.dicta
   where :new.evento_fk = dicta.evento_fk and :new.usuario_fk = dicta.usuario_fk;

   if (temp>0) then 
      dbms_output.put_line('Usuario participante no puede ser expositor en un mismo evento');
   end if;
end;
/
--#endregion

--#region VIEW para accesos rapidos
CREATE VIEW charlas_view AS
SELECT u.nombre, u.apellido, d.nombre_charla charla, e.nombre evento
FROM usuario u, dicta d, evento e
WHERE u.id = d.usuario_fk and d.evento_fk = e.id;

CREATE VIEW patrocinados_view AS
SELECT e.nombre evento, em.nombre empresa
FROM evento e, empresa em, patrocina p
WHERE e.id = p.evento_fk and em.id = p.empresa_fk;

--#endregion
 
