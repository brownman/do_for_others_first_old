
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



