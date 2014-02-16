#!/bin/bash
dir=package/do-for-others-first-0.0.1/usr/local/src/do-for-others-first/
wrapper=$dir/breath.sh
###########################################  Directory structure:  ######################\
test_project_has_1_file_to_execute_them_all(){
str=`ls $wrapper` 
assertEquals "$str" "$wrapper"
}
test_project_has_plugins_directory(){
str=`ls $dir/plugins`
assertNotSame "$str" ''
}
#########################################################################################/




###########################################  Wrapper catch errors  ######################\
pending_wrapper_catches_errors(){
local file=/tmp/script_with_errors.sh
echo sdlkfj > $file
chmod u+x $file
$wrapper $file
str=`cat /tmp/logger.txt`
assertNotEquals "$str" ''
}
#########################################################################################/



##################################  Plugins are independent creatures ######################\
pending_self_described(){
local file=''
}

############################################################################################/





. ./VENDOR/old/shunit2-2.0.3/src/shell/shunit2
