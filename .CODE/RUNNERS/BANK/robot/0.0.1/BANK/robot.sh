#!/bin/bash
#info: the robot of workspaces


str=`caller`
echo robot.sh caller is [  $caller ]
return

#. $file_trap
#. $file_debug
set -o nounset
#info: robot think that everything is easy
update_file(){
    file="$1"
    str="$2"
    ensure file_exist $file
    echo "$str" > $file
}
set_env(){
    #set -x

set -e
    print_func
  mode_translate=${MODE_TRANSLATE:-false}
    dir_robot=$( $file_server "$dir_root/.WORKSPACE/BANK/DIR/robot/txt" )
#    assert dir_exist "$dir_robot"
#    [ ! -d $dir_robot ] && { mkdir -p $dir_robot ;} || { echo dir robot exist; }
set +e
#set +x
}


robot_feels(){
    print_func
    local str="$1"
    local file=$dir_robot/${str}.txt
    [ ! -f $file ] && { touch $file;echo 'empty_line' > $file ; gvim $file; }
    local line=$(    random_line "$file" )


    robot_says "$line"
if [ "$mode_translate" = true ];then
    echo translate..
     $single_translation ru "$line"
     $single_translation ar "$line"
     $single_translation it "$line"
     proxy sleep 1
fi
 }

robot_says(){


#local     args=$( proxy present echo $@ )
local args=( $@ )

    print_func

    local cmd="$args"
#    proxy present print_color 32 "."
    proxy present pv "$cmd"
    
}
finish(){
    robot_says "I am much smarter now !"
    robot_feels happy

}
robot_cli(){
    print_func

    local text="$cmd_please"
    local  file_robot="$file_robot"
    #echo "$cmd" >> /tmp/robot.txt
    robot_says "what the hell is  [ $text ] \?"
    read command
    local        items=( $command )
#proxy    assert num_not_zero "${#items[@]}"
    update_file        "${items[@]}" $file_robot
    finish


}


steps(){
    print_func

    robot_cli 
}
############################################### enter
clear
cmd_please="$@"

    type set_env
proxy     sleep 3
    set_env

if [ -n "$cmd_please" ];then


    str_cmd=`echo "$cmd_please" | sed 's/ /_/g'`
    file="$dir_robot/$str_cmd"

#    (       proxy update_clipboard "gvim $file" )
    if [ -f $file ];then
        cmd="chmod u+x $file; eval $file"
        nl $file
        proxy sleep 3
        proxy "$cmd"
    else
proxy present        print_color 31    "invalid command"
    fi
     
else
   robot_says eveything is easy ... repeat after me.. everything.. 
   ls -1 $dir_robot
    
fi


#steps
#export -f robot_cli
#alias robot="robot_cli"
