for file in `ls `; do
        z=`cat $file | grep "$1" | wc -l`
        if [ $z -eq 0 ] ; then
                echo $file
        fi
done

