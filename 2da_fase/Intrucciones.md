# Proyecto de ABD

# Setup
**Importante**: debe inicicializarse SQLPlus en la carpeta del repo para que pueda ejectuar los scripts `.sql`

1. Inicicializar estructuras de datos

Ingresar como el usuario SYS con SQLPlus, ejecutar script
```bash
@base.sql
```

2. Crear definiciones de las tablas del proyecto

Ingresar como el usuario ABD (contraseña: ABD) con SQLPlus, ejecutar script
```bash
@soluciones_moviles.sql
```
seguido de
```bash
@dicta.sql
```
Estos son las soluciones de la fase I con una pequeña correccion y comentando los comandos de creacion de indices debido a que esto forma parte de la secuencia de ejecución de la segunda fase.

3. Ejecutar y desplegar el EXPLAIN PLAN de las tablas vacias
```bash
@vacio.sql
```

4. Realizar inserciones
```bash
@inserciones.sql
```

5. Ejecutar y desplegar el EXPLAIN PLAN con tablas llenas
```bash
@full.sql
```

6. Crear indices, ejecutar y desplegar el EXPLAIN PLAN con indices
```bash
@indexes.sql
```

7. Hacer actualizacion, ejecutar y desplegar el EXPLAIN PLAN
```bash
@after_update.sql
```