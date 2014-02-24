#!/bin/bash
# about file:
# plugin:      logger - update file - push 1 line on top 
# description: translate 1 line of text to many languages by choice
# gui: yes
# cli: no
#. $TIMERTXT_CFG_FILE

messageANS() {
    local title="$1"
    local file="$2"
    #local result=
    result=$( gxmessage -center  -nofocus       -title "$title" -file $file -timeout 15 -entry )

    if [ "$result" != '' ];then
        cat $rules_txt > /tmp/rules
        echo "$result" > $rules_txt
        cat /tmp/rules >> $rules_txt
    fi
}

add_line(){
    debug white "add_line() got:"
    debug cyan "file:$1 title:$2 when:$3"
    #latest modifications: 
    #pass reference by supplying name of global variable.
    local file="$1"
    local title="$2"
    local when="$3"
    local last_msg='yes, you can'
    #while :;do

    answer=$( gxmessage  -button "$NAME1 Story"  -title "$title" -file  "$file" -ontop -timeout 10 -entry $ICONIC  )
    
    if [ "$answer" = '' ];then
        sleep1 5 
        #$PLUGINS_DIR/translation.sh $last_msg
        
        
        $PLUGINS_DIR/translation.sh line $TODAY_DIR/txt/glossary.txt 
   elif [ "$answer" = 'mute' ];then
       export SILENCE=true 

   elif [ "$answer" = 'exit' ];then
        exit 1
    elif [ "$answer" = 'delete1' ];then
       echo '' > $file 
    elif [ "$answer" = 'remind1' ];then
     gxmessage  -title "I have time for everything:" -file  "$TODAY_DIR/txt/times.txt" -ontop -timeout 10 $ICONIC
    else
        if [ "$when" = 'true' ];then
            date1="$(date +%H:%M)"
            str="$date1 - $answer"
        else
            str="$answer"
        fi
        if [ "$last_msg" != "$answer"];then
        last_msg="$answer"
        update_file $file "$str"
        fi
       
    if [  "$PROFIT" = true ];then
            $PLUGINS_DIR/translation.sh sentence "$answer" 
        fi
    fi


}



eval "$1" '"$2" "$3" "$4"'
