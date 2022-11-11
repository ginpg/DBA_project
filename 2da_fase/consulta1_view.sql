/*
CREATE VIEW charlas_view AS
SELECT u.nombre, u.apellido, d.nombre_charla charla, e.nombre evento, u.id as id_user, e.id as id_event, e.universidad_fk as id_univ
FROM usuario u, dicta d, evento e
WHERE u.id = d.usuario_fk and d.evento_fk = e.id;
*/

SPOOL C:\Users\Grimilda\Documents\Semestre\ABD\Proyecto\Comandos\2da_fase\explain_plan1_view.txt

EXPLAIN PLAN SET STATEMENT_ID = 'Q1_view' FOR 
SELECT charlas_view.nombre, charlas_view.apellido, charlas_view.charla, charlas_view.nombre
FROM charlas_view, universidad
WHERE charlas_view.id_univ = universidad.id AND universidad.acronimo = 'UCV';


SELECT * 
FROM   TABLE(DBMS_XPLAN.DISPLAY); 
SPOOL OFF