#!/bin/bash -e
#source $dir_cfg/color/color.cfg
path=`dirname $0`
step1(){
    blue 'add global var: dir_project to bashrc'
    echo "export dir_project=$PWD"
    blue 'check out command: keyrc'
}
step2(){
   blue 'install required debian packages:' 
}

step3(){
blue 'update gmail account settings: user + password '

file=$dir_project/cfg/general/vars/vars.cfg
echo "$file" 
cat $file

}

step4(){
   blue 'edit .conf of package gmail-notify'
   blue 'hint: edit the password'
   cmd="cp $path/gmail/notifier.conf /home/$LOGNAME/.notifier.conf"
   echo "$cmd"
   eval "$cmd"
}


steps(){

green step1
step1

green step2
step2

green step3
step3

green step4
step4

}

steps
