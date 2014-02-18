#!/bin/bash 
#dir=package/do-for-others-first-0.0.1/usr/local/src/do-for-others-first/
#wrapper=$dir/breath.sh
###########################################  Directory structure:  ######################\
    unset rm


path=`pwd`

export runner=$path/VENDOR/shunit2-2.0.3/src/shell/shunit2

pending_project_has_1_file_to_execute_them_all(){
str=`ls $wrapper` 
assertEquals "$str" "$wrapper"
}
pending_project_has_plugins_directory(){
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
test_pending_easy(){
assertEquals 1 2
}



$path/tests/about_sed.sh
$path/tests/about_grep.sh



#. $runner
