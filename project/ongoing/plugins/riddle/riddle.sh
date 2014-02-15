#!/bin/bash -e
print_script

random_file(){
    print_func
    dir=$dir_vendor/abs/source
    file_list=$dir/list.txt

    if [ -f "$file_list" ];then

        filename=$( random_line $file_list )
echo "filename: $filename"
    
    else
        reason_of_death 'no such file' "$file_list"
    fi


    file_choose=$dir/$filename
    print_note "file choose: $file_choose"


}

run(){
    print_func
    local cmd=''
    random_file
    cmd="$EDITOR_GUI $file_choose"
    #eval "$cmd"
eval "$cmd" &

    
    
}
run
