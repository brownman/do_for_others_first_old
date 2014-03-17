#!/bin/bash 
source breath.cfg
set -o nounset

export dir_root=`pwd`
export file_units=files_units_tmp
str=$( alias | grep test_ )
#echo "$str"
echo "$str" > $file_units
cat $file_units
sleep 3
#arg=${1:-shunit}
#cmd="$dir_root/works/test/0.0.1/test.sh $arg"
#source $dir_root/.breath.cfg
#echo "$cmd"
#eval "$cmd"
while read line;do

    alias_name=`    echo "$line" | cut -d'=' -f1 | sed "s/alias//g"`
    file=`    echo "$line" | cut -d'=' -f2 | sed "s/'//g"`
    echo "$file"
    if [ -f $file ];then
        echo exist
        ls -l $file

    eval $file
    else
       # echo  not exist
    #    echo x
#    filename=`    basename $file`
    echo '[skip]' "$alias_name"
    fi

done < $file_units

#echo "vi $cmd" | /usr/bin/xsel --clipboard
