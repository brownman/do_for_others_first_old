
install_hotkeys(){

    #export file_idea=$dir_txt/idea.txt
    echo
}


install_hotkeys(){
    #xfce desktop:
    xfconf-query -c xfce4-keyboard-shortcuts -p /commands/default/XF86Display -s 'pending'
    xfconf-query -c xfce4-keyboard-shortcuts -l

    cmd="$1"
    echo "$1"
    xfce4-settings-manager
}

