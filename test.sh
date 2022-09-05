#!/bin/bash

sqlplus system/oracle@//localhost:1521/xe @base.sql
sqlplus abd/ABD@//localhost:1521/xe @soluciones_moviles.sql
