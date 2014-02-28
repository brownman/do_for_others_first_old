#!/bin/bash -e
#echo "USING: library.sh"
#echo -n '' > .alias.optional
#shlvl
#echo 'example: use public.history.save'
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
add_alias_for(){
  #  print_color_n 31 'add_alias_for():'
str="$1"
type="$2"
file="${str}.${type}"
if [ -f "$file" ];then
base=`basename $str`
#dir=`dirname $file`
from="${base}E"
echo "$from"
str="alias $from='gvim $file'"
echo "$str" >> alias.optional
else
    echo 'no such file' "$file"
fi

}

use1(){
    #echo "---> use()"
    #func_lvl
    first="$1"
    shift
    if [ $# -gt 0 ];then
        args=( "$@" )
    fi

    str=`echo  "$first"|sed 's_\._/_g'`

    path="$dir_rc/lib"
    prefix="$path/$str"
#    echo "???????? prefix: $prefix"
    if [ -f "$prefix.cfg" ];then

        if [ "${args[@]}" = edit ];then
           echo gvim "$prefix.cfg"
            
        else

add_alias_for "$prefix" "cfg"
            #print_line
            echo "File: $prefix.cfg"
            coverage "$prefix.cfg"
            source "$prefix.cfg"

        fi
    elif [ -f "$prefix.sh" ];then
        if [ "${args[@]}" = edit ];then
           echo gvim "$prefix.sh"
        else

add_alias_for "$prefix" "sh"

            #        echo "==============  exist: $prefix.sh"
            echo "File: $prefix.sh"
            coverage "$prefix.sh"
            eval "$prefix.sh \"${args[@]}\""
        fi
    else
        echo 'Tree: '
        print_line
        tree "$prefix" -L 2
        print_line
        tree "$prefix" -L 1
    fi


}
#export -f use

args=( "$@" )
use1 "${args[@]}"
