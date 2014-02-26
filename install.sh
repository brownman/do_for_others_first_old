#!/bin/bash -e
source ./rc/lib/group/basics.cfg



clear
step1(){
    #info: create a file - that links between .bashrc and this project
    #check: file=~/bashrc.additions;echo -e "\nFile: $file\n";cat $file
    echo step1
    file=~/bashrc.additions
    str="export dir_root=$PWD\nsource \$dir_root/setup.cfg"
    cmd="echo -e \"$str\" > $file"
    confirm "$cmd"
}
step2(){
    #info:       add last line to file: .bashrc
    #check:      grep 'source ~/bashrc.additions' ~/.bashrc
    echo step2
    str="source ~/bashrc.additions"
    cmd="echo \"$str\" >> ~/.bashrc"
    confirm "$cmd"
}
step3(){
    #info: load the setup.cfg
    #check: use package.color.color;print_color 32 cool
    echo step3
    source ~/.bashrc

}

steps(){
    #info: run all steps
    #check: cat $0 | grep check:
    step1
    step2
    step3
}


self_echo(){
    print_func
    local cmd="$1"
    local str="$2"

    #echo -e "func: $cmd \ngrep: $str"
    res=`cat $0 | grep "$cmd" -A 2 | grep "$str"`
    echo "$res"
}

self_eval(){
    print_func
    local str=`self_echo "$1" "$2"`
    echo "eval: $str"
  #  cmd=`echo "$str" | cut -d':' -f1-`
  # confirm "$cmd" 
    exiting
}



cmd=$1

if [ "$cmd" ];then
        #echo "SELF:"
        echo "$cmd()"
        self_echo "$cmd" info
        self_echo "$cmd" check

        eval "$cmd" 
else
    echo 'supply a step to execute'
    show_funcs
fi

