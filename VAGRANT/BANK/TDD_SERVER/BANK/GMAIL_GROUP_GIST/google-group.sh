#!/bin/bash
#author:         ofer shaham
#plugin:    gmail-group
#package:        do-for-others-first
#version:   0.0.2
#date:      15.2.2014
#depend:    gxmessage gmail-notify libnotify-bin vim-gtk
#help:      utilize shared gmail to act like the mobile application- whatsup 
#arguments: update your .bashrc with USER=gmail_nickname PASSWORD=gmail_passwort
#check:     ps -ef | grep gmail-notify | grep -v grep

#31 - red
#32 - green
#33 - yellow



################################### env ################################\

    exec 2>/tmp/err
set -o nounset

    gmail_check(){
        curl -u $user:$password --silent "https://mail.google.com/mail/feed/atom" | tr -d '\n' | awk -F '<entry>' '{for (i=2; i<=NF; i++) {print $i}}' | sed -n "s/<title>\(.*\)<\/title.*name>\(.*\)<\/name>.*/\2 - \1/p"  
    }
    gmail_check0(){
        curl -u $user --silent "https://mail.google.com/mail/feed/atom" | perl -ne 'print "\t" if /<name>/; print "$2\n" if /<(title|name)>(.*)<\/\1>/;' 
    }

trap_err(){

    local str_caller=`caller`

    echo "  ************ [ $FUNCNAME ] *********"
    print_file /tmp/err
    local cmd=$(   gxmessage -file /tmp/err -title 'trap_err' -entrytext "gvim +${str_caller}" )
    eval "$cmd"
    exit
}
separate_cfg(){
export TERM=xterm
export user=${GMAIL_USER:-''} #env
export password=${GMAIL_PASSWORD:-''} #env
export from=$user@gmail.com
export to=$user@gmail.com
export FAILURE=1
export SUCCESS=0
export file_msg=/tmp/file_msg.txt
export file_compose=/tmp/compose.txt

}
trap trap_err ERR
use_external_cfg_file(){
    file_cfg=$dir_self/private.cfg
if [ ! -f $file_cfg ];then

    print_color 32 "[ creating] saperate .cfg file - now - run again !"
    type separate_cfg | grep export > $file_cfg
    exit 0

else
    source $file_cfg
fi
}
########################################################################/
install_indicator(){
    print_func
    ln -sf /tmp/err $dir_self/err

    ln -sf /tmp/env $dir_self/env
}


print_file(){
    file=$1
    echo
    echo "[file] $file"
    echo '-----'
    cat $file
    echo
}
where_am_i () 
{ 
    local file=$1
    #{1:-"${BASH_SOURCE[1]}"};
    local rpath=$(readlink -m $file);
    local rcommand=${rpath##*/};
    local str_res=${rpath%/*};
    local dir_self="$( cd $str_res  && pwd )";

    echo "$dir_self"
}

set_awareness () 
{
    local file=${BASH_SOURCE:-$0}
    dir_self=$( where_am_i $file );
    local filename=`basename $file`;
    file_self="$dir_self/$filename"
}

install_hotkey(){
    print_func
    if [ "$DESKTOP_SESSION" = xfce ];then
    print_color 34 "installing a hotkey for quick running of this script!"

    key=${1:-1}
    echo "[ assosiate ]"
    echo -t "\t[hotkey] $key"

    cmd="bash -c $file_self"
    cmd1="xfconf-query -c xfce4-keyboard-shortcuts -p \"/commands/custom/<Alt>${key}\" -t string -s \"$cmd\" --create"
    echo -t "[cmd] $cmd1"
    echo
    echo "[confirm] press any key to install the hotkey"
    read
    eval "$cmd1"
else 
    echo "[ your desktop environment is ] $str "
    echo "[ please add a shortkey: alt+f1 for example which targets this file] "
fi
}

################################### helpers ############################\
    print_color_n()       { echo -en "\x1B[01;$1m[*]\x1B[0m $2 "; }
    print_color()       { echo -e "\x1B[01;$1m[*]\x1B[0m $2 "; }
    remove_trailing(){
        local res=$(echo "$1" | sed -e 's/^ *//g' -e 's/ *$//g')
        echo "$res"
    }
    ########################################################################/

    check(){


        ########################## Test Requirements: ##################################\   
        ################################################################################\

        result=$SUCCESS
        ########################## install dependencies ######################\   
        list=`pull depend`
        for item in $list;do
            cmd="dpkg -L $item"
            eval "$cmd" >/dev/null 2>&1 || { echo >&2 "sudo apt-get install $item" ;result=$FAILURE; }
        done

        ########################### test if gmail-notify is running ##########\

            cmd=`pull check`
        str=`eval "$cmd"`
        [ -z "$str" ] && { echo >&2 "please run gmail-notify" ;result=$FAILURE; }


        ########################### test if the user update the default configurations ##########\

            [ -z "$user" ] && { echo >&2 "please update your gmail settings which located in this file" ;result=$FAILURE; }

        return $result
    }

    pull(){
        subject="$1"
        str=`cat $0 | grep "$subject:" | cut -d':' -f2`
        remove_trailing "$str"

    }
    expose(){
        subject="$1"
        print_color_n 33 "$subject:\t\t"
        pull "$subject"
    }

    print_func(){
        echo -e "--> ${FUNCNAME[1]}():" 
    }
    clean_file(){
        local file=$1
        [ -f $file ] && { print_file $file; /bin/rm $file; }
    }
    cleanup(){
        clean_file /tmp/err

        clean_file /tmp/env
    }


    info(){
        print_func

        expose plugin
        expose help
    }
    run(){
        print_func
        echo -e "be cool, stay funny"
        
        #"user:$user\npassword:$password\nfrom:$from\nto:$to" > $file_msg
        gmail_check >$file_msg
        msg=$( gxmessage -entry -sticky -ontop -timeout 3000  -file $file_msg -title "Compose:" )
        if [ "$msg" != '' ];then
            echo -e "$LOGNAME:\t $msg" > $file_compose
            cmd="curl -u $user:$password --ssl-reqd --mail-from $from --mail-rcpt $to --url smtps://smtp.gmail.com:465 -T $file_compose"
            echo "$cmd"
            #xsel "$cmd"
            eval "$cmd" 
            #>/dev/null
        else
            notify-send 'skip sending'
        fi
    }

    steps(){
        clear
        print_func
        info
        eval check 
res=$?
        if [ $res -eq 0  ];then
            print_color 32 'run!'
            run
        else
            print_file /tmp/err
            gxmessage -file /tmp/err
            print_color 31 'follow the Instructions -> then try again!'
        fi
    }



    set_awareness 
use_external_cfg_file
cleanup
    env>/tmp/env
    install_indicator
    notify-send gmail_group


    cmd=${1:-steps}
    print_color 33 "[cmd] $cmd"
    eval "$cmd"
