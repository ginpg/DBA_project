/*Formato*/
SET LINESIZE 130;
SET PAGESIZE 0;

--#region EXPLAIN PLAN CONSULTA #1
SPOOL C:\Users\Grimilda\Documents\Semestre\ABD\Proyecto\Comandos\2da_fase\explain_plan1_vacio.txt

EXPLAIN PLAN SET STATEMENT_ID = 'Q1_vacio' FOR 
SELECT usuario.nombre, usuario.apellido, dicta.nombre_charla, evento.nombre
FROM usuario, dicta, evento, universidad
WHERE usuario.id = dicta.usuario_fk AND dicta.evento_fk = evento.id AND evento.universidad_fk = universidad.id AND universidad.acronimo = 'UCV';

SELECT * 
FROM   TABLE(DBMS_XPLAN.DISPLAY); 

SPOOL OFF;
--#endregion

--#region EXPLAIN PLAN CONSULTA #2
SPOOL C:\Users\Grimilda\Documents\Semestre\ABD\Proyecto\Comandos\2da_fase\explain_plan2_vacio.txt

EXPLAIN PLAN SET STATEMENT_ID = 'Q2_vacio' FOR 
SELECT empresa.nombre, evento.nombre, patrocina.f_aporte
FROM empresa, evento, patrocina
WHERE empresa.privada = 1 AND evento.id = patrocina.evento_fk AND empresa.id = patrocina.empresa_fk AND evento.area = 'Tecnologia' and extract( year from evento.f_inicio) = 2019 AND  extract( year from evento.f_final) = 2021;

SELECT * 
FROM   TABLE(DBMS_XPLAN.DISPLAY); 

SPOOL OFF;
--#endregion