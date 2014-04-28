#!/bin/bash  

file1=$dir_root/sos
file2=$dir_root/tasker
assert_symlink_not_broken(){
    file=$1

    if [[ ! -e $file &&  -L $file ]]; then
        filename=`basename $file`
        reason_of_death "please run $filename" "$file"
    else
        echo    "symlink is ok" "$file"
    fi

}

run(){

 assert_symlink_not_broken "$file1" & 
 sleep 3
 assert_symlink_not_broken "$file2"
}
run
