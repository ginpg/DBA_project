# Proyecto de ABD

# Setup
1. Inicicializar estructuras de datos

**Importante**: debe inicicializarse SQLPlus en la carpeta del repo para que pueda ejectuar los scripts `.sql`

Ingresar como el usuario SYS con SQLPlus, ejecutar script
```bash
@base.sql
```

2. Ingresar como usuario ABD (contrasena=ABD) con SQLPlus, ejecutar script
```bash
@soluciones_moviles.sql
```

3. Ingresar como usuario Administrador1 (contrasena=Administrador1) que ya se le ha concedido el rol de Administrador para las operaciones DML en Universidad, Empresa y la relacion de estos a eventos
```bash
@data.administrador.sql
```

4. Ingresar como usuario Organizador1 (contrasena=Organizador1) que ya se le ha concedido el rol de Organizador para las operaciones DML en Eventos, Usuarios y la relacion entre estos
```bash
@data.organizador.sql
```
