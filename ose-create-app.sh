#!/bin/bash


## !!!! set local imagestream  in the project with label latest

## 1. export is from openshift namespace ##

# oc export is redhat-openjdk18-openshift -n openshift | oc create -f -
# oc get is
# NAME                         DOCKER REPO                                                        TAGS          UPDATED
# redhat-openjdk18-openshift   docker-registry.default.svc:5000/raus/redhat-openjdk18-openshift   1.0,1.1,1.2   About a minute ago

## 2.  tag it to latest ##

#  oc tag redhat-openjdk18-openshift:1.2  redhat-openjdk18-openshift:latest
# oc get is
# NAME    DOCKER REPO                                                        TAGS                         UPDATED
# redhat-openjdk18-openshift   docker-registry.default.svc:5000/raus/redhat-openjdk18-openshift   latest,1.0,1.1 + 1 more...   20 seconds ago




DRIVER_CLASS="org.postgresql.Driver"
DB_URL="jdbc:postgresql://ssodemo.niko-cloud.ch:5432/keycloak"
DB_USERNAME="niko"
DB_PASSWORD="niko"



OPTIONS="-DDRIVER_CLASS=$DRIVER_CLASS -DDB_URL=$DB_URL -DDB_USERNAME=$DB_USERNAME \
-DDB_PASSWORD=$DB_PASSWORD" 


# deploy application to openshift
#
# get full path to project dir
SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
echo $SCRIPT_DIR
oc new-build \
   --image-stream=redhat-openjdk18-openshift:latest \
   --binary=true \
   --env=AB_JOLOKIA_OFF=true \
   --env=MAVEN_CLEAR_REPO=true \
   --env=JAVA_OPTIONS="$OPTIONS" \
   --name='dbchecker' 
   #-n nikolaj

oc start-build dbchecker --from-dir=./ocp --follow


oc new-app dbchecker



