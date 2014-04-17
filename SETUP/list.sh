stepping(){
    sleep 1
    clear
    echo -n "[stepping] "

local cmd=$1
grepping "$cmd" reason

echo $cmd
sleep 1
eval "$cmd"
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
