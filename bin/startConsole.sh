#!/bin/bash
export GRINDERPATH='/Users/abhishekk/play/projects/grinder-3.4'
export GRINDERPROPERTIES='/Users/abhishekk/play/projects/grinder-3.4/grinder.properties'
export CLASSPATH=$GRINDERPATH/lib/grinder.jar:$CLASSPATH
java -cp $CLASSPATH net.grinder.Console
