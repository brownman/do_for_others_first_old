#!/bin/bash
# about file:
# plugin:       scrapper
echo "cfg file: $TIMERTXT_CFG_FILE " 
#. $TIMERTXT_CFG_FILE


translate(){
#.echo("Usage: $ casperjs googlepagination.js my search terms")
trace "translate() got 1:$1 2:$2"
local script=$PLUGINS_DIR/javascript/translate.js
local prog=$PLUGINS_DIR/javascript/commands.sh
local args1="$1" #"--target=${1}" #ru
local args2="$2" #'my dogs'
trace "prog: $prog"
#local result=$( $prog $script $args1 "$args2" )
exec $prog $args1 "$args2" "$script" 
#gxmessage -title "scraping result:" "$result" $GXMESSAGE1

#( gedit "$script" &)
#echo "$result"
}


scrap_practice(){

timeout=10
    cyan "idea for practive scraping"
    local title='scraping idea ?'
    while :;do
        answer=$( gxmessage  -buttons "ok"  -entry -title "$title"  -file  $scrap_txt -ontop -timeout $TIMEOUT1 )
        if [ "$answer" = '' ];then
            break
        else 
            update_file $scrap_txt "$answer"
        fi
    done
}

#scrap_something "$1" "$2" "$3"
#eval $@

trace "func $1  $2"

eval "$1" '"$2" "$3"'


