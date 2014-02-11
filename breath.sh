#!/bin/bash -e
#url:http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_02_03.html 
#url:http://www.cyberciti.biz/faq/linux-log-files-location-and-how-do-i-view-logs-files/
####################
#
#help_1:\t\t\t--- supply a script to wrap ----
#example_1:\t./wrapper.sh 3/suspend.sh/suspend.sh 1\n

reset
set -o pipefail  # trace ERR through pipes
set -o nounset
set -o errtrace
export VERSION=2
export LANG=ru
pushd `dirname $0`> /dev/null
export dir_root=`pwd`
echo "dir_root: $dir_root"
    source $dir_root/bashrc.fun
    source $dir_root/projectrc.fun
clean_logger(){
    print_func
    if [ -f "$file_logger" ];then
        cmd="/bin/rm $file_logger"
        commander "$cmd"
    else
        cmd="touch $file_logger"
        commander "$cmd"
    fi
}
use_error(){
    print_func
    local all="$1"
    arr=()
    num_bytes=$(  echo "$all" | wc --bytes )
    red "line: num of bytes: $num_bytes"
    echo press enter
    read
    if [ "$num_bytes" -lt 300 ] && [ "$num_bytes" -gt 1  ];then
        #set array:arr + set vars:num/exe/line/error/error_code
        parse_primary "$all"
    else
        print_error "$all"
        print_error "incorrect parsing"
        flite 'incorrect parsing'
        green "Assume:" 
        echo "invalide path: path contains: $num_bytes bytes."
    fi
}
try(){
    print_func
    echo  -n '/*'
    print_line
    echo 
    if [ $VERSION -eq 2 ];then
        red 'Should : trap errors!'
        trap 'traperror $? $LINENO $BASH_LINENO "$BASH_COMMAND" $(printf "::%s" ${FUNCNAME[@]})'  ERR;
    fi
    cmd="nice -n10 $script"
    #            print_evaluating ".... $script ...."
    if [ ${#args[@]} -eq 0 ]; then
        eval "$cmd" 2>$file_logger;
    else
        eval "$cmd ${args[@]}" 2>$file_logger;
    fi
    local error_code=$?
    print_line
    echo  '*/'
    if [ "$error_code" -eq 0   ];then
        trace green "no errors"
    else
        red "error_code: $error_code"
    fi

}
check_log(){
    #lue  'check_log()' #
    print_func
    if [ -f "$file_logger" ];then
        if [ -s "$file_logger" ];then
            red "logger is not empty"
            if [ "$SOUND" = true ];then
                flite 'error'
            fi
            echo "press N for skip viewing the log file"
            read answer
            if [ "$answer" != n ];then
                line=`cat $file_logger`
                if [ "$GUI" = false ];then
                    print_line
                    print_error "$line"
                    print_line
                fi
            fi
            use_error "$line"
        else
            blue "logger is empty"
            echo
        fi
    else
        red "no such file"
        echo "$file_logger"
    fi

}
steps(){
    print_func
    #check_system

    if [ "$DEBUG" = true ];then
        show_state
    fi
    clean_logger
    blue "run()"
    green "steps:"
    blue "1.try   2.check_log"
    try 
    check_log
}
show_state(){
    $dir_project/4/exports.cfg
    cat $0 | grep export
    if [ "$DEBUG" = true ];then
        set -o  
    fi
}
################################# START HERE
check_system(){
    green 'INSTALLING..' 
    print_line
    echo
    sleep 3
    $dir_install/runner.sh
    result=$?
    # echo "result=$result"
    if [ $result -eq 1 ];then
        echo
    else
        print_line
        echo
        print_good "success!"
    fi
}
if  [  $# -gt 0  ];then
    arg "$@"
    cmd=steps
    $cmd
    echo 
    echo
else
    check_system
    confirm
    about_self
fi

