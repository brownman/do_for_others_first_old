#!/bin/bash

str="$1"
run(){
#local cmd="notify_send1 'simple notification' \"_ $str\""
#every "$cmd" 10

    #gxmessage $GXMESSAGET -title 'simple notification' 'hello  world!'
    if [ "$str" = error ];then
        cmd="gxmessage $GXMESSAGET -file $file_error -title 'Errors:$file_error'"
        #optional1 "$cmd" 'error.txt' 'error'
eval "$cmd"
#    else
#        cmd="gedit $KOANS_DIR/about_project.sh"
#        optional1 "$cmd" 'edit about_project.sh' 'error'
    fi


}
run
