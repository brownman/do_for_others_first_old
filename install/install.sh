#!/bin/bash -e
#source $dir_cfg/color/color.cfg
path=`dirname $0`
step1(){

    print_func
    blue 'add global var: dir_root to bashrc'
    echo "export dir_root=$PWD"
    blue 'check out command: keyrc'
}
step2(){
    print_func
   blue 'install required debian packages:' 
}

step3(){
    print_func
blue 'update gmail account settings: user + password '

file=$dir_root/cfg/general/vars/vars.cfg
echo "$file" 
cat $file

}

step4(){
    print_func
   blue 'edit .conf of package gmail-notify'
   blue 'hint: edit the password'
   cmd="cp $path/gmail/notifier.conf /home/$LOGNAME/.notifier.conf"
   echo "$cmd"
   eval "$cmd"
}


steps(){
step1
step2
step3
step4
}

if [ "$1" ];then

steps "$1"
else
    print_about_self
fi
