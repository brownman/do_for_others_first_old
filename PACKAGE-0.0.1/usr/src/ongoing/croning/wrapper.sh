#!/bin/bash 
pushd `dirname $0` >/dev/null

clear


source helpers.cfg
source vars.cfg

echo 'this script must be independent'
sleep 1
dir=`pwd`
user=''
SUDO=''
plugin_name=${1:-''}

if [ "$(id -u)" != "0" ]; then
    user='user'
    SUDO=''
else
    user='root'
    SUDO='sudo'
    sleep 10
fi



if [ -z "$NAME" ];then
    #reason_of_death 'name is empty'
    user_name=$MY_NAME
else
    user_name=$NAME
fi

run(){
    echo run
    time1=`date | cut -d' ' -f4 | sed 's/:/_/g'`
    path="/home/$user_name"

    if [ -d "$path" ];then
        dir="$path/Desktop/croning"
        if [ ! -d "$dir" ];then
            echo "creating directory: $dir"
            mkdir "$dir"
            chmod 1777 $dir
        fi

        #file=$dir/${time1}_${user}.txt
        file=$dir/${user}_${user_name}_${plugin_name}.txt
        touch $file
        crontab -l > $file

        if [ "$plugin_name" != '' ];then
            notify-send 'plugin:' "$plugin_name" 
            dir="$dir_plugins/$plugin_name"
            if [ -d "$dir" ];then
                file=$dir/wrapper.sh 
                if [ -f "$file" ];then
                    $file  
                else
                    reason_of_death 'no such file' "$file"
                fi
            else
                reason_of_death 'no such dir' "$dir"
            fi
        else
            reason_of_death 'supply a plugin name'
        fi
    else
        reason_of_death 'no such path' "$path"
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


# notify-send 'user name:' "$user_name"


notify-send "type: $user        name: $user_name"   "plugin: $plugin_name"
#flite  "$user_name" 2>/dev/null
#flite  "$user" 2>/dev/null
#flite  "$plugin_name" 2>/dev/null
if [ "$plugin_name" = install ];then
    install
else
    run 
fi
popd
