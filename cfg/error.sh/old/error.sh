#!/bin/bash


#dependencies: bash, gxmessage, libnotify, xsel, vim
#depend_cfg
#source ./vagrant.cfg
#path=`dirname $0`

export VERSION=1
export GUI=true
export SOUND=false
path=`pwd`
dir_cfg=$path/cfg
source $dir_cfg/args_set.cfg
source $dir_cfg/proxy.cfg
source $dir_cfg/required.cfg
source $dir_cfg/colors.cfg
source $dir_cfg/exiting.cfg
source $dir_cfg/array.cfg
export file_logger=/tmp/logger.txt


install_dependencies_cli(){
    required bash bash
    required vim vim
    required xsel xsel
    required flite flite
}

install_dependencies_gui(){
    required notify-send libnotify-bin 
    required gvim vim-gnome
}
install_dependencies_sound(){
    required flite flite
}




#echo -n '' > $file_logger
clean_logger(){
    blue "clean_logger()"
    if [ -f "$file_logger" ];then
        rm $file_logger
    else
        touch $file_logger
    fi
}

use_error(){
    green 'use_error()'
    local line="$1"
    arr=()
    local str=`echo $line | sed 's/line /+/g'`
    str_to_arr "$str"
    #we have: arr
    num="${#arr[@]}"
    exe="${arr[0]}"
    line="${arr[1]}"
    error="${arr[2]}"
    error_code="${arr[3]}"
    blue 'Assume:'
    echo "array size: $num"
    echo "exe: $exe"
    echo "line: $line"
    echo "error: $error"
    echo "error+code: $error_code"
    notify-send "$error" "$error_code"
    printf "%s\n" "${arr[@]}" > /tmp/error.txt

    cmd="vi $exe $line" 
    echo "$cmd" | xsel --clipboard
    sleep 1
    green 'your clipboard has been updated with:'
    blue "$cmd"

}
try(){
    blue 'try()'

    { 
        if [ $VERSION -eq 2 ];then

            set -o errtrace
            traperror () {
                local err=$1 # error status
                local line=$2 # LINENO
                local linecallfunc=$3 
                local command="$4"
                local funcstack="$5"
                echo "<---"
                echo "ERROR: line $line - command '$command' exited with status: $err" 
                if [ "$funcstack" != "::" ]; then
                    echo -n "   ... Error at ${funcstack} "
                    if [ "$linecallfunc" != "" ]; then
                        echo -n "called at line $linecallfunc"
                    fi
                else
                    echo -n "   ... internal debug info from function ${FUNCNAME} (line $linecallfunc)"
                fi
                echo
                echo "--->" 
            };
            trap 'traperror $? $LINENO $BASH_LINENO "$BASH_COMMAND" $(printf "::%s" ${FUNCNAME[@]})'  ERR;

        fi
        eval "$script" 2>$file_logger ;
    }
    local error_code=$?
    if [ "$error_code" -eq 0   ];then
        print_line
        green "no errors"
    else
        print_line
        red "error_code: $error_code"
    fi

}
check_log(){
    blue  'check_log()' #
    if [ -f "$file_logger" ];then
        if [ -s "$file_logger" ];then
            red "logger is not empty"
            echo Press Enter!
            read
            line=`cat $file_logger`
            print_error "$line"
            print_line
            use_error "$line"
        else
            blue "logger is empty"
            #blue "$file_logger:"
            echo
        fi
    else
        red 'no such file'
    fi

}
steps(){
    blue "steps()"
    clean_logger
    blue "run()"
    green "steps:"
    blue "1.try   2.check_log"
    try 
    check_log
}

################################# START HERE
install_dependencies_cli
if [ "$GUI" = true ];then
    install_dependencies_gui
fi

if [ "$SOUND" = true ];then
    install_dependencies_sound
fi
set_script_and_args "$@"
info(){
    echo "script:  $script"
    echo "args:  ${args[@]}"
}
#cmd=${1:-steps}
cmd=steps
$cmd
blue 'file logger: '
cat $file_logger
echo 
echo
#ref: http://wiki.bash-hackers.org/commands/builtin/eval
#http://linuxcommand.org/wss0150.php
#http://bashdb.sourceforge.net/bashdb.html#SEC_Contents
#http://code.ohloh.net/project?pid=&ipid=305153
#http://stackoverflow.com/questions/6928946/mysterious-lineno-in-bash-trap-err
#https://github.com/sickill/asciinema.org
#http://docs.python-guide.org/en/latest/dev/virtualenvs/
