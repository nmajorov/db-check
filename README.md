# test remote database access  from Openshift



simple application to test openshift connectivity to 
database postgresql outside to openshift






## build project 

run command 

    mvn clean package

create dir if not exist 

    
    mkdir -p ocp/deployments

copy uberjar in deployments dir

   
    cp ./target/dbchecker-0.0.1-SNAPSHOT.jar ocp/deployments/


## deploy to openshift

### 1. create project in openshift

    oc login

    oc new-project raus


**set local imagestream redhat-openjdk18-openshift in the project with label latest !**

### 2. export imagestream from openshift namespace ###

create your project local imagestream for openjdk
by exporting openjdk image from openshift namespace.


            oc export is redhat-openjdk18-openshift -n openshift | oc create -f -

            # list imagestreams  in your project
             oc get is
             NAME         DOCKER REPO TAGS          UPDATED
             redhat-openjdk18-openshift   docker-registry.default.svc:5000/raus/redhat-openjdk18-openshift   1.0,1.1,1.2   About a minute ago

### 3.  tag it to latest ###


         oc tag redhat-openjdk18-openshift:1.2  redhat-openjdk18-openshift:latest


        oc get is
        NAME    DOCKER REPO                                                        TAGS                         UPDATED 
        redhat-openjdk18-openshift   docker-registry.default.svc:5000/raus/redhat-openjdk18-openshift   latest,1.0,1.1 + 1 more...   20 seconds ago

### 4. create binary build and application 

See more info here:
[jdk Binary Builds](https://access.redhat.com/documentation/en-us/red_hat_jboss_middleware_for_openshift/3/html-single/red_hat_java_s2i_for_openshift/#binary_builds)

edit and run script:


        ./ose-create-app.sh

