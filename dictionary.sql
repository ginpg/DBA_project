-- Ejecutar este archivo como SYS

/*select (data.CREATE_BYTES - data.BYTES) as espacio_libre, t.name
from V$DATAFILE data, V$TABLESPACE t
where data.ts#=t.ts# and (t.name='SOLUCIONES_MOVILES_DATOS' or t.name='SOLUCIONES_MOVILES_INDEX');*/

-- Espacio libre de los tablespaces creados.
select tablespace_name, sum(bytes) as espacio_libre
from dba_free_space
where tablespace_name in ('SOLUCIONES_MOVILES_DATOS', 'SOLUCIONES_MOVILES_INDEX')
group by tablespace_name;

-- De los índices que se encuentran creados en el repositorio
select alli.UNIQUENESS, -- su unicidad
alli.TABLESPACE_NAME, -- el tablespace donde se encuentra almacenado
icol.column_name, -- la(s) columna(s) que conforman el índice
alli.index_name, -- para saber cual indice se muestra
alli.initial_extent, -- 1. parámetro de almacenamiento
alli.min_extents, -- 2. parámetro de almacenamiento
alli.max_extents -- 3. parámetro de almacenamiento
from ALL_INDEXES alli, ALL_IND_COLUMNS icol
where icol.index_name=alli.index_name and alli.tablespace_name='SOLUCIONES_MOVILES_INDEX';

-- El tamaño de las tablas en bloques
-- Se calculan las tablas de los tablespaces que creamos
-- No se cuentas los indices
-- Segment name tiene el mismo nombre de las tablas

-- Ejectuar trigger de estadisticas, para tener resultados más precisos
exec dbms_utility.analyze_schema('ABD','COMPUTE');

SELECT table_name, owner,SUM(blocks) as tam_bloques FROM (
   SELECT segment_name as table_name, owner, blocks
    FROM dba_segments
    WHERE segment_type IN ('TABLE', 'TABLE PARTITION', 'TABLE SUBPARTITION') and owner='ABD'
)
GROUP BY table_name, owner;

-- El tamaño de cada registro (en bytes), (calculo solo el de las tablas que creamos)
SELECT TABLE_NAME, avg_row_len from DBA_ALL_TABLES where owner='ABD';

-- El tamaño de cada columna (en bytes)
select table_name, column_name, avg_col_len from ALL_TAB_COL_STATISTICS where owner='ABD';

-- El Factor de bloqueo de las tablas (este valor lo debe calcular, se asume registros fijos no extensibles).
-- B: tam bloque, tr: tam registro
-- fb = B / tr
-- avg_row_len tiene que ser mayor que 0 para evitar divisiones entre 0.
select (data.block_size / allt.avg_row_len) as factor_bloqueo, allt.table_name
from V$DATAFILE data, V$TABLESPACE t, DBA_ALL_TABLES allt
where data.ts#=t.ts# and t.name = allt.tablespace_name and allt.owner='ABD' and allt.avg_row_len > 0;


-- Dada una consulta de igualdad sobre un campo en una tabla, indicar si se usan índices y calcular el costo en función de números de accesos a disco

EXPLAIN PLAN SET STATEMENT_ID = 'Deveci' FOR select nombre from abd.universidad where acronimo='UCV';

-- nice output
-- select * from table(DBMS_XPLAN.DISPLAY());

select IO_COST, OPERATION, FILTER_PREDICATES from plan_table where operation='INDEX';
