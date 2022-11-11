/*set markup csv on*/

/*
CREATE VIEW patrocinados_view AS
SELECT e.nombre evento, em.nombre empresa, p.f_aporte, e.id as id_event, em.id as id_empre, e.area, e.f_inicio, e.f_final, em.privada
FROM evento e, empresa em, patrocina p
WHERE e.id = p.evento_fk and em.id = p.empresa_fk;
*/
SPOOL C:\Users\Grimilda\Documents\Semestre\ABD\Proyecto\Comandos\2da_fase\explain_plan2_view.txt

EXPLAIN PLAN SET STATEMENT_ID = 'Q2_view' FOR 
SELECT evento, empresa, f_aporte
FROM patrocinados_view
WHERE privada = 1 AND area = 'Tecnologia' and extract( year from f_inicio) = 2019 AND  extract( year from f_final) = 2021;



SELECT * 
FROM   TABLE(DBMS_XPLAN.DISPLAY); 
SPOOL OFF


