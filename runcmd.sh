#!/bin/bash
####TODO check avalability with ping first
if [ -z "$1" ]; then
        echo "
        usage: $0 username password list.csv
"

        exit 0
else

domain="$1"
OLDIFS=$IFS
IFS=","
start=0
while read hst cmd
do
        if [ $start -ge 1 ]; then
        if [ "$cmd" ]; then
                ./ciscocmd -t $hst -u $1 -p $2 -c $cmd > out/$hst

        fi
        fi
        start=$((start+1))
done < $3
IFS=$OLDIFS
fi

