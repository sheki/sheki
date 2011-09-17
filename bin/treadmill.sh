#!/bin/bash
DATE=`date "+%d-%m-%Y"`
FILE="/Users/abhishekk/.kona/treadmill.csv"
function die_usage
{
    echo "Usage : treadmill km time(min)"
    exit 2
}

if [[ -z "${1}" ]] ; then
    die_usage
fi
if [[ -z "{$2}" ]] ; then
    die_usage
fi
echo "$DATE,$1,$2" | tee -a "$FILE"
