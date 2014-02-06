#!/bin/bash -e
#source $dir_cfg/color/color.cfg
path=`dirname $0`
install_hotkeys(){

#export file_idea=$dir_txt/idea.txt
}

install_dropbox(){

#export dir_dropbox=~/Dropbox


}
install_vim_rc(){


#export file_vim=$dir_cfg/vimrc.cfg

}
install_dependencies_cli
install_dependencies_gui
install_dependencies_sound

#dependencies: bash, gxmessage, libnotify, xsel, vim, mpg321
####################
#installation:
#source $dir_root/install/required/required.cfg


install_dependencies_cli(){
    required bash bash
    required vim vim
    required xsel xsel
    required flite flite
    required gmail-notify
}

install_dependencies_gui(){
    required notify-send libnotify-bin
    #libnotify1
    required gvim vim-gnome
    required gxmessage gxmessage
    required xcowsay xcowsay
}
install_dependencies_sound(){
    required flite flite
#    required mpg321 mpg321
    required sox libsox-fmt-all
}


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
