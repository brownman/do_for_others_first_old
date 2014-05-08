#!/bin/bash
#create a file and source it - try to catch the error on the outer shell


create_file(){
#check: -f $file

touch $file
echo 'zbabun(){ echo hi; }' > $file


    assert file_exist "$file"
}
source_file(){
source $file

}
trap_err(){
local str=`caller`
print_color 31 "trap: $str"
}
update_file(){
echo zbabunag >> $file
}

steps(){

file=/tmp/1.cfg
    create_file
    trap trap_err ERR
    source_file 
    update_file
    ( source_file )
    
    
}

steps
