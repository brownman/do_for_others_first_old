
func1(){
strace -tt -ff -o /tmp/zenity zenity --list --title "Select musicians" --text="Some text" --column="Select" --column="Musician" --checklist --height=480 --width=370 < list.txt 

}
echo show_menu
#line=$( cat list.txt | cut -d'|' -f1 | zenity --list --column 1  )

cmd0="cat  list.txt | cut -d'#' -f2 | zenity --list --column=field --multiple" 
echo "$cmd0"
cmd=$( eval "$cmd0" )

eval "$cmd"
#echo $str_res
#echo res: $?
exit
echo show_cmd
cmd=$( echo "$line" | cut  -d'|' -f2 )
echo "[cmd] $cmd"
eval "$cmd"
echo confirm_cmd
echo cmd=$( confirmYN op1=edit op2=run)
