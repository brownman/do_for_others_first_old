#!/bin/bash 
path=`dirname $0`
dir=$path/my_folder
file=$dir/package.cfg
create_dir(){
    if [ ! -d "$dir" ];then
        echo 'generate dir: /cfg'
        mkdir -p "$dir"
    else 
        echo 'use dir: /cfg'
    fi
}

create_config_file(){
    echo 'updating your clipboard'
    echo -e "\
        export dir_bin=usr/bin\n\
        export project_name=dropbox-voices\n\
        export dir_first=first_folder\n\
        export exe=change_my_name" > $file
}
#| xsel --clipboard
show_msg(){
    echo -e "update: \n $file"
}

steps(){
    create_dir
    create_config_file
    show_msg
}


if [ "$1" ];then
    echo "eval $@"
    eval "$@"    
else
    show_self
#    edit_self
fi


