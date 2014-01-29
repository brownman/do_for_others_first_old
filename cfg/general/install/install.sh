#!/bin/bash -e
source $dir_cfg/color/color.cfg
path=`dirname $0`
step1(){
    blue 'add global var: dir_project to bashrc'
    echo "export dir_project=$path"
}
step2(){
   blue 'install required debian packages:' 
}

step3(){
   blue 'check out command: keyrc'
}

step4(){
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

steps
