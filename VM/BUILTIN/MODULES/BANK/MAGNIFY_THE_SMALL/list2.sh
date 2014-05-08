#!/bin/bash 




exec 2>/tmp/err
set -o nounset
export dir_self=`pwd`
pushd $dir_self >/dev/null
export file_setup=$dir_self/setup.cfg

[ -f $file_setup ]  && { source $file_setup; } || { echo "[error] file not found:  $file_setup";exit 1; }

trap trap_err ERR

#gist: mission is to look after me while I am sailing in space time
#depand_package: svn
#later: https://code.google.com/p/yad/wiki/Examples
#how:  use a simple loop , feed it with a simple txt list.
#minimalism: 24
#date: 2/5/2014
#author: ofer shaham (c)
prepare(){
    if [ ! -f $file_list ];then
        touch $file_list
        echo -e "commitment\nlist todo" >> $file_list
    fi
}
set_env(){
    #self awareness
    dir=`dirname $0`
    file_list=$dir/.list.txt
    #yad
        #translation
    script_translate="$dir_self/SINGLES/BANK/translation/translation.sh"
    lang=ru
    SOUND=false
export    GXMESSAGE="-ontop -sticky"
}

eat(){

    local args=( $@ )

    print_func
    local max=${#args[@]}
    echo "[max] $max"

    local task_name="${args[0]}"

    local file="$dir_self/SINGLES/BANK/$task_name/${task_name}.sh"
    local cmd=''
    if [ -f "$file" ];then
        if [ $max -gt 1 ];then
            args=( ${args[@]:1} )
            #update_args
            cmd="$file ${args[@]}"
        else
            cmd="$file"
        fi
        echo  -e "\t[cmd] $cmd"

set -e
eval "$cmd"
set +e
     #   local line_for_translation=$( eval "$cmd"  )

        res=$?
        echo "[res] $?"
     #   translate_line "$line_for_translation"
    else
        echo "[error] file not exist " "$file"
        return 1
    fi


}
breaking(){
    echo break
    break
}
loop(){
    sdiiif
    local counter=1
    while :;do
        
        xcowsay "WoW!!!  $counter"
    while read line;do
        #just in case:
        if [ -n "$line" ];then
notify-send $line

            echo "[$counter]"
            echo "[line] $line"
            eat "$line"
            sleep 1 
        else
            echo encounter empty line
            breaking
        fi




    done<$file_list
sleep 1
        let 'counter += 1'
done
}

steps(){
isdf
sleep 10
#catch_error0
#set -o nounset
    set_env
    prepare
    loop
}

#export -f trap_err
#trap trap_err ERR
#cmd=${1:-steps}
#eval "$cmd"

#set -o nounset
#export -f trap_err
steps 
popd>/dev/null
