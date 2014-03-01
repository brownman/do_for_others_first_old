#!/bin/bash -e
source robot.cfg
echo "STEPS "
trap breakpoint ERR

func_lvl(){
    echo " :lvl: ${#FUNCNAME[@]}"
}

breakpoint(){
    func_lvl
    echo  'breakpoint()'
    /usr/bin/flite -t breakpoint
    /usr/bin/notify-send 'breakpoint' "$0"
}
should(){
    echo should $@
    sleep 3
}
step0(){
   # echo 'step0'
  #  robot should print self
   # load the file structure
    file="$dir_root/rc/cli_steps/0_struct/setup.cfg"
    cat $file | grep help
    source  "$file"

}
step1(){
    str=`cat product_lvl.txt`
    echo "productivity level:$str"
}
step2(){
echo
}

steps(){
    echo -n 'steps()'
    func_lvl
    step0
}
steps
