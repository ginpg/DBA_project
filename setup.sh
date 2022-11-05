#!/bin/bash

sqlplus system/oracle@//localhost:1521/xe @base.sql
sqlplus abd/ABD@//localhost:1521/xe @soluciones_moviles.sql
sqlplus Administrador1/Administrador1@//localhost:1521/xe @data_administrador.sql

sqlplus Organizador1/Organizador1@//localhost:1521/xe @data_organizador.sql

