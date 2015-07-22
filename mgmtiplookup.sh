#!/bin/bash
if [ "$3" == "txt" ]; then
        db=1
else
        db=0
        echo -en "CCT,CE IP,Port Speed,CAR,Shape,CID,Hostname,Mgmt IP\n"
fi

if [ -z "$1" ]; then
        echo "
        need input domain number
        need input csv file as argument
        output_format csv or txt {default csv}

        $0 domain input_csv ouput_format
        ex.
        $0 05 input.csv csv
        "

        exit 0
else

domain="$1"
OLDIFS=$IFS
IFS=","
start=0
while read vpn cid altcic pvc name pe vrf hub peif encap ceip ceipv6 portspeed dir vlan proto asover qos car profile shape fragm
do
        if [ $start -ge 1 ]; then
           if [ ! -z "$ceip" ]; then
                echo -ne "$ceip"
                if [ "$db" -eq 1 ]; then echo -ne "\t"; else echo -ne ","; fi
                echo -ne "$portspeed"
                if [ "$db" -eq 1 ]; then echo -ne "\t"; else echo -ne ","; fi
                echo -ne "$car"
                if [ "$db" -eq 1 ]; then echo -ne "\t"; else echo -ne ","; fi
                echo -ne "$shape"
                if [ "$db" -eq 1 ]; then echo -ne "\t"; else echo -ne ","; fi
                echo -ne "$cid"
                if [ "$db" -eq 1 ]; then echo -ne "\t"; else echo -ne ","; fi
                host=`host $ceip`
                env="pointer "
                host2=${host/*$env}
                env2=".d$domain"
                host3=${host2/$env2*}
                if [[ ! $host3 =~ ^.*NXDOMAIN.*$ ]] ; then
                        echo -ne "$host3"
                        if [ "$db" -eq 1 ]; then echo -ne "\t"; else echo -ne ","; fi
                        cm=`cinfo $host3 | grep "Managed IP"`
                        cm2=${cm:14}
                        cm3=${cm2/Domain*}
                        echo -ne "$cm3" | tr -d ' '
                        #if [ "$db" -eq 1 ]; then echo -ne "\t"; else echo -ne ","; fi
                else
                        echo -ne "NXDOMAIN"
                        #if [ "$db" -eq 1 ]; then echo -ne "\t"; else echo -ne ","; fi
                fi
                echo -ne "\n"
           fi
        fi
done < $2
IFS=$OLDIFS
fi

