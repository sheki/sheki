#!/bin/bash

project=$(basename $PWD)
mvn $@
if [ $? -eq 0 ] ;
then
    growlnotify   -m "Build succeeded for $project" -t maven
else
    growlnotify  -m  "Build failed for $project" -t maven
fi
