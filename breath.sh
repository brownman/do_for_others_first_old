#!/bin/bash
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
export VERSION=1
export LANG=ru

pushd `dirname $0`> /dev/null

dir_root=`pwd`

export dir_project=$dir_root/vm

source $dir_project/env/env.cfg
source $dir_project/env/struct.cfg
source $dir_project/env/source.cfg



#export dir_deb=$dir_project/friends/OLD/packaging/deb.sh
export file_logger=/tmp/logger.txt










traperror () {
    print_func
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
use_error(){

    green 'use_error()'
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
        print_error "incorrect parsing"
        flite 'incorrect parsing'
        green "Assume:" 
        echo "invalide path: path contains: $num_bytes bytes."
    fi
}
try(){

    #    blue 'try()'
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
              #  else
               #     gxmessage -file "$file_logger" -title logger -timeout 3000 -ontop -sticky
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
    if [ "$DEBUG" = true ];then
        show_state
    fi
    #info
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



if  [  $# -gt 0  ];then


    arg "$@"
    #Assume: script has been defined

    #cmd=${1:-steps}
    cmd=steps
    $cmd
    echo 
    echo
else
    about_self
fi
#echo random_line misterious
#ref: http://wiki.bash-hackers.org/commands/builtin/eval
#http://linuxcommand.org/wss0150.php
#http://bashdb.sourceforge.net/bashdb.html#SEC_Contents
#http://code.ohloh.net/project?pid=&ipid=305153
#http://stackoverflow.com/questions/6928946/mysterious-lineno-in-bash-trap-err
#https://github.com/sickill/asciinema.org
#http://docs.python-guide.org/en/latest/dev/virtualenvs/

#https://www.google.co.il/search?q=bash+best+practices&oq=bash+best&aqs=chrome.1.69i57j0l3.3122j0j1&sourceid=chrome&ie=UTF-8
##http://kvz.io/blog/2013/11/21/bash-best-practices/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+kvz+(Kevin+van+Zonneveld)


<< ABC
https://www.google.co.il/search?q=bash+best+practices&oq=bash+best&aqs=chrome.1.69i57j0l3.3122j0j1&sourceid=chrome&ie=UTF-8
http://mywiki.wooledge.org/BashGuide/Practices
http://andreinc.net/2011/09/04/bash-scripting-best-practice/
http://fahdshariff.blogspot.co.il/2013/10/shell-scripting-best-practices.html
http://stackoverflow.com/questions/78497/design-patterns-or-best-practices-for-shell-scripts
http://kvz.io/blog/2013/11/21/bash-best-practices/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+kvz+(Kevin+van+Zonneveld)
#vim: moving around: http://vim.wikia.com/wiki/Moving_around
ABC


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

dpkg -S sox
libsox-fmt-mp3: /usr/lib/sox/libsox_fmt_mp3.so

COMMENT

