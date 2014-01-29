#!/bin/bash 

#dependencies: bash, gxmessage, libnotify, xsel, vim
#depend_cfg
#source ./vagrant.cfg
#path=`dirname $0`

export VERSION=1
export GUI=true
export SOUND=true
export EDITOR=vim


path=`pwd`
dir_cfg=$path/cfg/general
source $dir_cfg/arg/arg.cfg
source $dir_cfg/proxy/proxy.cfg
source $dir_cfg/required/required.cfg
source $dir_cfg/color/colors.cfg
source $dir_cfg/pids/exiting.cfg
source $dir_cfg/array/array.cfg
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
        /bin/rm $file_logger
    else
        touch $file_logger
    fi
}
parse(){
    local all="$1"
    local str=`echo $all | sed 's/line /+/g'`
    str_to_arr "$str"
    #we have: arr
    num="${#arr[@]}"
    exe="${arr[0]}"
    line="${arr[1]}"
    error="${arr[2]}"
    error_code="${arr[3]}"
    blue 'Assume:'
    echo -e "\t\tarray size: $num"
    echo -e "\t\texe: $exe"
    echo -e "\t\tline: $line"
    echo -e "\t\terror: $error"
    echo -e "\t\terror+code: $error_code"

    #printf "%s\n" "${arr[@]}" > /tmp/error.txt

}
use_error(){
    green 'use_error()'
    local all="$1"
    arr=()


    
    notify-send "$error" "$error_code"


    num_bytes=$(  echo "$all" | wc --bytes )
    red "line: num of bytes: $num_bytes"
    echo press enter
    read
    if [ "$num_bytes" -lt 100 ] && [ "$num_bytes" -gt 1  ];then

    #set array:arr + set vars:num/exe/line/error/error_code
    parse "$all"


echo "editor: $EDITOR"
echo "editor: $GUI"
exit
        cmd="$EDITOR $exe $line" 

        echo "$cmd" | xsel --clipboard
        sleep 1
        green 'your clipboard has been updated with:'
        blue "$cmd"
    else
        print_error "incorrect parsing"
        green "Assume:" 
        echo "invalide path: path contains: $num_bytes bytes."
    fi
}
try(){
    blue 'try()'
    { 
        if [ $VERSION -eq 2 ];then

            set -o errtrace
            traperror () {
                local err="$1" # error status
                local line="$2" # LINENO
                local linecallfunc="$3" 
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
        eval "$script ${args[@]}" 2>$file_logger;
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
            if [ "$SOUND" = true ];then
                echo error | flite
            fi
            echo "press N for skip viewing the log file"
            read answer
            if [ "$answer" != n ];then
                line=`cat $file_logger`
                print_line
                print_error "$line"
                print_line
            fi
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
info(){
    echo "script:  $script"
    echo "args:  ${args[@]}"
}
show_state(){
echo "version: $VERSION"
echo "gui: $GUI"
echo "sound: $SOUND"
echo "editor: $EDITOR"
}
################################# START HERE
show_state
sleep 2
install_dependencies_cli
if [ "$GUI" = true ];then
    install_dependencies_gui
fi

if [ "$SOUND" = true ];then
    install_dependencies_sound
fi
set_script_and_args "$@"
info
sleep 2
#cmd=${1:-steps}
cmd=steps
$cmd
echo 
echo
#ref: http://wiki.bash-hackers.org/commands/builtin/eval
#http://linuxcommand.org/wss0150.php
#http://bashdb.sourceforge.net/bashdb.html#SEC_Contents
#http://code.ohloh.net/project?pid=&ipid=305153
#http://stackoverflow.com/questions/6928946/mysterious-lineno-in-bash-trap-err
#https://github.com/sickill/asciinema.org
#http://docs.python-guide.org/en/latest/dev/virtualenvs/
