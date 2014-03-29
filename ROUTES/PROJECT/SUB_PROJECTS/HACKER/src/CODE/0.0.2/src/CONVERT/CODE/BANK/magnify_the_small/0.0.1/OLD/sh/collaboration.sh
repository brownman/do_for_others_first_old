#!/bin/bash
# about file:
# plugin:        collaboration
# description:   refresh  last step in a field
#. $TIMERTXT_CFG_FILE

file=$CFG_DIR/step_a_day.txt

file_to_buttons(){
echo2 "files_to_buttons() got: 1: $1"
#create array:
    local file_guide="$1"
    old_IFS=$IFS
    IFS=$'\n'
    lines=($(cat $file_guide)) # array
    IFS=$old_IFS
    #echo ${lines}
#show as buttons:
#local str1="nir eran ran.t"
local str1=''

    for i in "${!lines[@]}"; do
line=${lines[$i]}
#red "$line"
            desc=$( echo $line | awk -F '|' '{print $1}' )
            blue "$desc"
            
        if [ "$str1" = '' ];then
       str1="$desc"
        else
        
       str1="$str1 $desc"
        fi
    done
    
#green "str1: $str1"
$( string_to_buttons "$str1" "collaboration:" 'choose a friend:' )
result="$?"

cyan "result: $result"

local line1="${lines[$result]}"

yellow "line1: $line1"
local name1=$( echo "$line1" | awk -F '|' '{print $1}' )
local ask1=$( echo "$line1" | awk -F '|' '{print $2}' )
#local cmd1=$( echo "$line1" | awk -F '|' '{print $3}' )
$( gxmessage -title "collaborations: with $name1" $GXMESSAGET "$ask1" -entrytext "$cmd1" )
#echo  "$cmd1"
#bash -c "$cmd1" &
#xterm -e "$cmd1" &
#exec "$cmd1"
$TODAY_DIR/code/collaboration.sh "$name1"


            #notify_send "TASK:" "$desc"
            #( echo "$desc" | flite &)
            #( echo0 "$desc" &)
            #exec

            #cmd1='$tasks_sh $command "$desc"'

            #eacher "$tasks_sh $command"  "$desc" #eacher '$tasks_sh time_is_limited' 'it should take a while' 


}

file_to_buttons $file
