#!/bin/sh

CUR_DIR=`dirname $0`
#DRIVER_CLASS="org.hsqldb.jdbcDriver"
#DB_URL="jdbc:hsqldb:mem:anam"
#DB_USERNAME="sa"

DRIVER_CLASS="org.postgresql.Driver"
DB_URL="jdbc:postgresql://ssodemo:5432/keycloak"
DB_USERNAME="niko"
DB_PASSWORD="niko"
#MAX_TRY=4 # how many attempts

OPTIONS="-DDRIVER_CLASS=$DRIVER_CLASS -DDB_URL=$DB_URL -DDB_USERNAME=$DB_USERNAME \
-DDB_PASSWORD=$DB_PASSWORD" 

LIB=$(echo $CUR_DIR/target/dbchecker*.jar | tr ' ' ':')
echo "classpath: " $LIB

if [ "x$MAX_TRY" == "x" ];then
    echo "MAX_TRY option is not set"
else
    OPTIONS="$OPTIONS -DMAX_TRY=$MAX_TRY"
fi

java $OPTIONS -cp $LIB ch.sag.dbchecker.DBChecker