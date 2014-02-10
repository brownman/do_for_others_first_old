#!/bin/bash
print_script

random_path(){
    print_func
    dir=$dir_vendor/abs/source
    file_list=$dir/list.txt

    if [ -f "$file_list" ];then

        filename=$( random_line $file_list )
echo "filename: $filename"
    confirm
    
    else
        reason_of_death 'no such file' "$file_list"
    fi


    file_choose=$dir/$filename.sh
    print_note "file choose: $file_choose"


}


run(){
    print_func
    local cmd=''
    random_path
    cmd="$EDITOR_GUI $file_choose"
echo    commander "$cmd"
}
run
