delay=5
file_locker=/tmp/riddle

dir=''
subject=''
delay1=$delay_riddle
notify_send1 delay "$delay1"

random_path(){
        dir=$SCRIPT_DIR/tasks/abs/source
        subject=abs

        
        filename=$(random_from_subject1 $subject)

        full_path=$dir/$filename

}


run(){

    notify_send1 'riddle' 'bash riddles'
    local cmd=''
        random_path


        #notify_send1 "res" "$file"
        if [ "$full_path" != '/' ];then
            #update_commander
           
            cmd1="copy $full_path"
            optional "$cmd1" "copy riddle.sh ?" question
 cmd="gedit $full_path"
            detach "$cmd"  
 cmd="gedit $KOANS_DIR/src/about_project.sh"
            detach "$cmd"  
        fi
        trace 'sleep..'        
        sleep1 $delay1
    echo 'do_abs'
}
run
