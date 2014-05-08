dir_self=`where_am_i`
install_hotkey(){
    local file=$dir_self/ideas.$LOGNAME.yaml
    if [ -f $file ];then
        #reason: setup the hotkeys for the robot
        echo "[file exist] $file"
cmd="xfconf-query -c xfce4-keyboard-shortcuts -p \"/commands/custom/<Alt>F1\" -t string -s \"gvim $file\" --create"
echo "[cmd] $cmd"
eval "$cmd"
    else
        echo error - no such file : $file
    fi
}
install_hotkey
