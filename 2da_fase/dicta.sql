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