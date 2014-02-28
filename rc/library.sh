#!/bin/bash -e
echo "LOADING: library.sh"

#shlvl
echo 'example: use public.history.save'
selfish(){
    local ptrn="$1"
    local num="$2"
    local delimeter="$3"
    local color="$4"
    local path3="$5"

    str=`cat "$path3" | grep $ptrn | cut -d"$delimeter" -f${num}|xargs -0 echo`
    if [ -n "$str" ];then
        print_color $color "*********  Avaliable $ptrn:"
        echo "$str" 
    else 
        #        echo 'no grepping for pattern: ' "$ptrn"
        echo -n ' .. '
    fi
    #>> .history

}


exiting(){
    echo 'exiting'
    exit 1
}

#echo 'set -o nounset'
#set -o nounset
correction(){
    echo -e "\t\t\tCORRECTION()"  
    path=${1:-''}
    item=${2:-''}
    cmd="grep $item -r $path --color=auto --exclude-dir=.old"
    echo "but .."
    echo "you may meant to say:"
    #echo "$cmd"
    sleep 4
    eval "$cmd" | head -5
    tree -L 2 $dir_root/rc/bash
    exiting
}
func_lvl(){
    echo "-------*----------*-----func_lvl: ${#FUNCNAME[@]}"
}
coverage(){
#    echo '---> coverage() '
     file="$1"
           selfish export 3 ' ' 35 "$file"
            selfish alias 1 '=' 32  "$file"
            selfish trap 2 ' ' 31 "$file"
}
use(){
    #echo "---> use()"
    #func_lvl
    args=( "$@" )

    str=`echo  "${args[@]}"|sed 's_\._/_g'`

    path="$dir_rc/lib"
    prefix="$path/$str"
    if [ -f "$prefix.cfg" ];then

print_line
        echo "File: $prefix.cfg"
        coverage "$prefix.cfg"
        source "$prefix.cfg"
 
    elif [ -f "$prefix.sh" ];then

#        echo "==============  exist: $prefix.sh"
        echo "File: $prefix.sh"
        coverage "$prefix.sh"
        eval "$prefix.sh"
    else
print_line
        tree "$prefix" -L 2
        print_line
        tree "$prefix" -L 1
    fi


}
export -f use
$@
