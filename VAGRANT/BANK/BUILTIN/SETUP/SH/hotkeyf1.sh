dir_self=`pwd`
install_hotkey(){
    local file=$dir_self/ideas.$LOGNAME.yaml
        if [ -f $file ];then
#reason: setup the hotkeys for the robot
            xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Alt>F1" -t string -s "gvim $file" --create
        else
            echo error - no such file : $file
                fi
}
install_hotkey
