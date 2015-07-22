for a in $(cat devices.txt | awk {'print $1'}); do echo $a; 'viewconfig' $a | ggrep -B 2 -A 2 'VPN:'; done
