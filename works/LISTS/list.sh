#!/bin/bash -e
print_script

path=`dirname $0`
pushd $path>/dev/null

step1(){

dir=$path/screens
pushd $dir>/dev/null

ls -l
file=list
if [ -f $file ];then
    
#lister
$lister_sh
#$dir/list
else
reason_of_death 'file not found' "$file"    
fi

popd>/dev/null
}

steps(){
print_func

step1
}
steps
popd>/dev/null
