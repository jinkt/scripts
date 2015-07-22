#!/bin/bash


if [ -z "$1" ]; then
        echo "
        run ciscocmd from csv
        usage $0 file.csv username password  enable_pass

        file.csv
        hostname,command
"

        exit 0
else

OLDIFS=$IFS
IFS=","
start=0
while read hst cmd
do
        echo "conf t" > ./ciscocmd.tmp
        echo $cmd >> ./ciscocmd.tmp
        echo "do sh ip int br" >> ./ciscocmd.tmp
        echo "end" >> ./ciscocmd.tmp
        echo "wr" >> ./ciscocmd.tmp
        ./ciscocmd -u $2 -p $3 -s $4 -r ./ciscocmd.tmp -t $hst

done < $1
IFS=$OLDIFS
fi



