print_script
echo 'plugin: gmail_group'

test_gmail_notify_is_running(){
str=`cat $0 | grep 'check:'`
assert "$str" 1
}

test_dependencies(){
str=`cat $0 | grep 'dependencies:'`
assert "$str" 1
}
