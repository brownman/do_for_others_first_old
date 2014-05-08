#!/bin/bash -e
#depend: egrep
#help: load .cfg files - before using the library
clear
pushd `dirname $0`


load_list(){
dir_rc_steps=$dir_rc/STEPS
file0=$dir_rc/list.txt
file=/tmp/file
egrep -v '(^#|^$)' $file0 > $file
}



expose_str(){
    echo 'expose_str()'
#print_func

echo "args: $@"
cut_index="$3"
str="$2"
file="$1"
cmd="cat $file | grep $str| cut -d' ' -f${cut_index} | xargs echo"
echo "$cmd"
str1=`eval "$cmd" | xargs echo`
arr=( "$str1" )
if [ ${#arr[@]} -gt 0 ];then
    max=${#arr[@]}
    echo  "Available $str[$max]: ${arr[@]}"
else
#    echo 'error:' "$str - not found in - $file" 
echo -n .
fi
}


run(){


echo "LOADING: steps.cfg"
if [ "$dir_root" != '' ];then
    
echo "vi $dir_root/rc/steps.cfg"
let 'counter=0'
while read line;do
echo " ---------   step: $counter -----------"
name=$line

file_cfg="$dir_rc_steps/bank/$name.cfg"

expose_str $file_cfg export 3
expose_str $file_cfg alias 2

cmd="source $file_cfg"
msg=`basename $file_cfg`
echo
echo "=== LOADING: $msg"
eval  "$cmd"
let 'counter+=1'
done < $file
else
    echo 'must run: install.sh first'

fi


}
steps(){


load_list
run

}



steps
popd
