#!/bin/bash
    set -o nounset

#info: robot think that everything is easy
set_env(){
    print_func
    dir_robot=$dir_root/.WORKSPACE/robot/txt
    [ ! -d $dir_robot ] && { mkdir -p $dir_robot ;}

    file_robot="$FILE_ROBOT"

}


robot_feels(){
    print_func
    local str="$1"
    local file=$dir_robot/${str}.txt
    [ ! -f $file ] && { touch $file;echo 'empty_line' > $file ; gvim $file; }
    local line=$(    random_line "$file" )
    robot_says "$line"
}

robot_says(){
    print_func
    local args="$@"
    local cmd="$args"
    proxy present pv "$cmd"
}

robot_cli(){
    print_func
if [ -n "$cmd_please" ];then
        local cmd="$cmd_please"
    local  file_robot="$file_robot"
        #echo "$cmd" >> /tmp/robot.txt
        robot_says "what the hell is  [ $cmd ] ?"
        read describe
        robot_says "tags ?"
        read tags
        robot_says "command ?" 
        read command
        echo "$item" > $file_robot
        robot_says "I am much smarter now !"
        robot_feels happy

    else
proxy present         print_color 31 "you again ! just leave me ! I need a nap"
    fi

}


steps(){
    print_func
    set_env
    robot_cli 
}
cmd_please="$@"
steps 

#steps
#export -f robot_cli
#alias robot="robot_cli"
