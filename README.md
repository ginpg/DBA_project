# Proyecto de ABD

# Setup
**Importante**: debe inicicializarse SQLPlus en la carpeta del repo para que pueda ejectuar los scripts `.sql`

1. Inicicializar estructuras de datos

Ingresar como el usuario SYS con SQLPlus, ejecutar script
```bash
@base.sql
```

2. Ingresar como usuario ABD (contrasena=ABD) con SQLPlus, ejecutar script
```bash
@soluciones_moviles.sql
```

# Cargar data de prueba

3. Ingresar como usuario Administrador1 (contrasena=Administrador1) que ya se le ha concedido el rol de Administrador para las operaciones DML en Universidad, Empresa y la relacion de estos a eventos
```bash
@data_administrador.sql
```

4. Ingresar como usuario Organizador1 (contrasena=Organizador1) que ya se le ha concedido el rol de Organizador para las operaciones DML en Eventos, Usuarios y la relacion entre estos
```bash
@data_organizador.sql
```

# Consultas diccionario directorio

Antes de ejecutar `dictionary.sql`, necesitas haber cargado los datos de prueba, como se explica en la sección anterior.


Luego, ingresar como el usuario SYS
```bash
@dictionary.sql
```

