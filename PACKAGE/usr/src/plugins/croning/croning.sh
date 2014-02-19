#!/bin/bash -e
clear
echo 'this script must be independent'
sleep 5
dir=`pwd`
user=''
SUDO=''

if [ "$(id -u)" != "0" ]; then
    user='user'
    SUDO=''
else
    user='root'
    SUDO='sudo'
fi
user_name=${NAME:-$LOGNAME}

#/usr/bin/notify-send 'user name:' "$user_name"
/usr/bin/notify-send 'user name:' "$user_name"


run(){
   echo run
    plugin_name="$1"
    time1=`date | cut -d' ' -f4 | sed 's/:/_/g'`
    dir="/home/$user_name/Desktop/croning"
    if [ ! -d "$dir" ];then
        echo "creating directory: $dir"
        mkdir "$dir"
        chmod 1777 $dir
    fi
    

    file=$dir/${time1}_${user}.txt
    touch $file
    crontab -l > $file
    flite -t "$user"
    util=/usr/games/xcowsay
    $util "$user"
    if [ "$plugin_name" != '' ];then
        notify-send 'plugin:' "$plugin_name" 
        file="$dir_plugins/$plugin_name/wrapper.sh"
        if [ -f "$file" ];then
       $file  
        else
        echo reason_of_death 'no such file' "$file"
        fi
        

    else
        echo reason_of_death 'no plugin name '
    fi
}


install(){
    echo install
    echo -e "\t\t\t\tRESULTS:"
echo    print_color 35 "user: $user"
        file=$dir/txt/crontab.$user.txt
        $SUDO crontab $file
        $SUDO crontab -l
   }
   
arg=${1:-''}

if [ "$arg" = install ];then
    install
else
    run "$arg"
fi
