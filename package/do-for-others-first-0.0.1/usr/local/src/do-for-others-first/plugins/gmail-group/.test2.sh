#!/bin/bash
#print_script
#echo 'test: gmail_group'

testEquality() {
    assertEquals 1 1
}
testEquality1() {
    ./breath.sh

    assertEquals 2 1
}




test_gmail_notify_is_running(){
    str=`cat $0 | grep 'check:'`
 #   assert "$str" 1

    assertEquals 2 "$str"
}

test_dependencies(){
    str=`cat $0 | grep 'dependencies:'`
    assertEquals "$str" 2
}
source $file_runner
