#!/bin/bash -e
#print_script
path=`dirname $0`
dir_vendor=$path/.VENDOR
dir=$dir_vendor/abs/source
file_list=$dir/list.txt

random_file(){
#    print_func
    
    if [ -f "$file_list" ];then

        filename=$( random_line $file_list )
echo "filename: $filename"
    
    else
     echo   reason_of_death 'no such file' "$file_list"
    fi


    file_choose=$dir/$filename
    echo print_note "file choose: $file_choose"


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
