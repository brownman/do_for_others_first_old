#!/bin/bash 
print_script 
plugin_name=deb.sh
path=$dir_workspace/$plugin_name
dir=$path/my_folder
file=$dir/my_package.cfg
create_dir(){
    if [ ! -d "$dir" ];then
        green "generate dir: $dir"
        mkdir -p "$dir"
    else 
        green "use dir: $dir"
    fi
}
create_file(){
    if [ ! -f "$file" ];then
        green "generate file: $file"
        touch $file
    else 
        green "use file: $file"
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
    green 'steps:'
    create_dir
    create_file
    create_config_file
    show_msg
}


if [ "$1" ];then
    echo "eval $@"
    eval "$@"    
else
    show_funcs
#    edit_self
fi


