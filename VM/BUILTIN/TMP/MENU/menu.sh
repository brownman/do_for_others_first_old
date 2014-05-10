

step1(){
local cmd=$(    cat $dir_self/history.txt | zenity --list --column 'recent_command' ) 
echo "[cmd] $cmd"
}
