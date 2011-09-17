#!/bin/bash

dir=$(basename $PWD)
cmd=$1
shift
$cmd $@
if [ $? -eq 0 ] ;
then
    growlnotify  -w -m "$cmd succeeded, $dir, $@" -t $cmd
else
    growlnotify -w -m  "$cmd failed, $dir, $@" -t $cmd
fi

