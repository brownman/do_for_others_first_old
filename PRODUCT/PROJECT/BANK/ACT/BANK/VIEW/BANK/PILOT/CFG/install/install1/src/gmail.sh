test_if_gmail_notify_is_running(){

set -o pipefail  # trace ERR through pipes
#set -o
util=gmail-notify



#echo "util: $util"
cmd="ps -ef | grep $util | grep -v grep"

#| awk '{print $2}'"
str=$( eval "$cmd" )
#echo "str:  $str"

#echo "str0 $str0"
if [ "$str" = '' ];then
    print_info "Please run gmail-notify!"
fi


#cmd="echo "$str0" | awk '{print $2}' "
#str=$( commander "$cmd" )


assertNotEqual "$str" ""


}


install_gmail_notifier_settings(){
    print_func
    blue 'edit .conf of package gmail-notify'
    blue 'hint: edit the password'
    cmd="cp $path/gmail/notifier.conf /home/$LOGNAME/.notifier.conf"
    echo "$cmd"
    eval "$cmd"
}

