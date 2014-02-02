#!/bin/bash  -e
#help01: supply a script to wrap  
#example01: ./wrapper.sh 3/suspend.sh/suspend.sh 1
#dependencies: bash, gxmessage, libnotify, xsel, vim
#depend_cfg
#source ./vagrant.cfg

export DISPLAY=:0
export VERSION=1
export GUI=false

export TRANSLATE=true
export SOUND=true

export EDITOR=vim
export TRACE=false





export dir_project=`dirname $0`

source $dir_project/4/struct.cfg
source $dir_project/4/INSTALLATION/required/required.cfg

#now we have dir_cfg
source $dir_cfg/self/self.cfg


source $dir_cfg/arg/arg.cfg
source $dir_cfg/sound/sound.cfg
source $dir_cfg/proxy/proxy.cfg
source $dir_cfg/color/color.cfg
source $dir_cfg/pids/exiting.cfg
source $dir_cfg/array/array.cfg

source $dir_cfg/funcs/funcs3.cfg
source $dir_cfg/sleep/sleep3.cfg

source $dir_cfg/vars/me.cfg
source $dir_cfg/vars/time.cfg

source $dir_cfg/zenity/zenity.cfg

export file_logger=/tmp/logger.txt


install_dependencies_cli(){
    required bash bash
    required vim vim
    required xsel xsel
    required flite flite
    required gmail-notify
}

install_dependencies_gui(){
    required notify-send libnotify-bin libnotify1
    required gvim vim-gnome
    required gxmessage gxmessage
    required xcowsay xcowsay
}
install_dependencies_sound(){
    required flite flite
}
<<'COMMENT'
what ever written here is a comment
 1299  sudo apt-get install libnotify0.4-cil
 1312  sudo apt-get install xosd-bin
 1314  sudo  apt-get install libnotify1 notification-daemon dbus 
 1315  sudo  apt-get install libnotify4]
 1316  sudo  apt-get install libnotify4
 1319  sudo apt-get --reinstall install notify-osd
 1320  sudo apt-get --reinstall install libnotify-bin
 1326  sudo apt-get --reinstall install notify-osd
 1333  sudo apt-get autoremove notify-sende
 1334  sudo apt-get autoremove notify-send
COMMENT

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
    if [ "$num_bytes" -lt 200 ] && [ "$num_bytes" -gt 1  ];then

        #set array:arr + set vars:num/exe/line/error/error_code
        parse "$all"


        cmd="$EDITOR $exe $line" 

        echo "$cmd" | xsel --clipboard
        sleep 1
        green "$0 says:"
        echo 'your clipboard has been updated with:'
        blue "$cmd"
    else
        print_error "incorrect parsing"
        green "Assume:" 
        echo "invalide path: path contains: $num_bytes bytes."
    fi
}
try(){
    
    blue 'try()'

    echo  -n '/*'
    print_line
    echo 

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
        eval "nice -n10 $script ${args[@]}" 2>$file_logger;
    }
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
    #blue  'check_log()' #
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
                if [ "$GUI" = false ];then
                    print_line
                    print_error "$line"
                    print_line
                else
                    gxmessage -file "$file_logger" -title logger -timeout 3000 -ontop -sticky
                fi
            fi
            use_error "$line"
        else
            blue "logger is empty"
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
    show_my_name
    echo "version: $VERSION"
    echo "gui: $GUI"
    echo "sound: $SOUND"
    echo "editor: $EDITOR"
    echo "trace: $TRACE"
}
################################# START HERE



show_state
sleep 2
install_dependencies_cli
install_dependencies_gui
install_dependencies_sound
arg "$@"
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
