#!/bin/sh

#DRIVER_CLASS="org.hsqldb.jdbcDriver"
#DB_URL="jdbc:hsqldb:mem:anam"
#DB_USERNAME="sa"

DRIVER_CLASS="org.mariadb.jdbc.Driver"
DB_URL="jdbc:mariadb://localhost:3306"
DB_USERNAME="bpm"
DB_PASSWORD="bpm"


LIB=$(echo ./lib/*.jar | tr ' ' ':')
echo "classpath: " $LIB

java -DDRIVER_CLASS=$DRIVER_CLASS -DDB_URL=$DB_URL -DDB_USERNAME=$DB_USERNAME -DDB_PASSWORD=$DB_PASSWORD -cp $LIB ch.sag.dbchecker.DBChecker
