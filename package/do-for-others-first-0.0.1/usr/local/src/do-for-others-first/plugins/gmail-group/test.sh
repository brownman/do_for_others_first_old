
test_dependencies(){
    let 'counter=0'
    #   echo "$file_script"
    str0=`cat $file_script | grep  depend | cut -d':' -f2`
    str=$( remove_trailing "$str0" )
    #assertEqual "$str" "$str0"
    local res0=true
    local res=''
    #str_to_arr "$str" ' '
    #num=${#arr[@]}
    file_package=/tmp/package
    echo -n '' > $file_package
    for item in $str;do
cmd="dpkg -L $item"
    eval "$cmd" >/dev/null 2>&1 || { echo -e >&2 "$item" >> $file_package ;let 'counter += 1'; }

    done
    str=`cat $file_package`
    if [ $counter -eq 0 ];then
        assertEqual 1 1
    else
    reason_of_death 'install the packages'    "$str"
    fi
    #str=`echo $file_script`

}

#            echo "item:-$item-"
#        res0=$( has_spaces "$item" )
#        if [ "$res0" = false ];then
#            res=`which $item`    
#            echo "-$res-"
#
#            assertNotEqual "$res" '' 
#        else
#            echo  'has spaces.'
#        fi


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
        reason_of_death "Please run g mail notify!" 'gmail-notify'
    fi
    #cmd="echo "$str0" | awk '{print $2}' "
    #str=$( commander "$cmd" )
    assertNotEqual "$str" ""
}

test_username_and_password_are_set(){
    if [ "$GMAIL_USER" = '' ] || [ "$GMAIL_PASSWORD" = '' ];then

        echo "user:     -$GMAIL_USER-"
        echo "password: -$GMAIL_PASSOWRD-"
        reason_of_death 'edit the configuration file' "$file_config"
    else
        assertEqual 1 1
    fi

}

#install_gmail_notifier_settings(){
#    blue 'edit .conf of package gmail-notify'
#    blue 'hint: edit the password'
#    cmd="cp $path/gmail/notifier.conf /home/$LOGNAME/.notifier.conf"
#    echo "$cmd"
#    eval "$cmd"
#}

#source $file_runner
