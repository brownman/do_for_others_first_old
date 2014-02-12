#!/bin/bash

argr(){
    blue "argr (r=elative)"
    args=()
    #assume: $path already exist
    #set:    $script + ${args[@]}
    #echo 'set script and args'
    if [ $# -gt 0 ];then
        dir_base="$1"
        shift
        if [ "$1" ];then
            script="$dir_base/$1"
            if [ -f "$script" ];then
            echo "script: $script"
                green "script OK"
                shift
                if [ "$1" ];then
                    args=( "$@" )
                    green "arg OK"
        echo "args: ${args[@]}"


                fi
            else
                reason_of_death "no such script: " "$script"
            fi
        fi
    else
        red 'Help?'
        green 'greping help:'
        cat $0 | grep help01
        green 'greping example:'
        cat $0 | grep example01
                reason_of_death "no args"
    fi

}


file_to_array11(){
    {
        IFS=\$
        lines=( $(cat -E $file) )
    }
}
file_to_array2(){
    lines=( $(cat $file) ) ## no quotes
}
is_valid_file(){
    http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
}
is_valid_array(){
    http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_10_02.html
    http://www.thegeekstuff.com/2010/06/bash-array-tutorial/
}
type_of(){
    http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_10_01.html
}


args=("$@")

str="${args[@]}"

echo "$str" >> .ideas
sleep 1
cat .ideas | grep  --color=auto "$str"
cat .ideas
