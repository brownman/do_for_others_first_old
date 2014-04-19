clear1(){
echo `caller`
echo CALLED CLEAR
sleep 4
}
grepping(){
    local cmd=$1
    local tag=$2
local str=$(    cat $0 | grep $cmd -A 2 | grep "$tag" | sed "s/\#$tag//g" )
echo " [ $cmd ]"
if [ -n "$str" ];then
echo -n "[ reason ]"
pv "$str"
else
    print_color  31 "[ERROR] update function [ $cmd ] with tag:[ $tag ]"



cmd="cat $0 | grep -n \"$cmd\" -m1 | cut -d':' -f1"
echo "$cmd"
local lineno=$( eval "$cmd" )
cmd="vi +${lineno} $0"
echo update_clipboard "$cmd"

    exit
fi

}


trap_sigint(){
clear
return
}

trap trap_sigint SIGINT
stepping(){
    sleep 1
    clear
    echo -n "[stepping] "

local cmd=$1
grepping "$cmd" reason
echo $cmd
sleep 1
( eval "$cmd" )
sleep 2
}

eat(){
dir_self=`dirname $0`
file_list=$dir_self/list.txt
while read line;do
    if [ -n "$line" ];then
    eval "$line"
fi
done<$file_list
}

source_all(){
    local dir_self=$dir_self
    files=`ls $dir_self/BANK/*.cfg`
    for file in $files;do
#        ls -l $file
clear
source $file

    done
}
steps(){
    dir_self=`dirname $0`
source $dir_self/shared.cfg
source_all
eat
}

steps
