play_history(){
    lang1=$(lower $lang)
    echo1 $lang1
    #ls -1 --sort=time /tmp/bash_koans/txt/*.txt | grep -E "($lang1.txt|it.txt)"
    #exit

    for I in $(ls -1 --sort=time /tmp/bash_koans/txt/*.txt | grep -E "($lang1.txt|it.txt)")
    do 
        str1=$(echo $I | sed 's/txt/mp3/g' ) #| sed 's/word_//g')


        files=$(ls  $str1 2> /dev/null )

        if [[  "$files"  ]]
        then
            (say1 "$str1" &)
            gxmessage  -buttons "_$last_task" -nearmouse -wrap -title "title"  -file $I -font "serif bold 34" -sticky
            echo1 "txt file: $I"


        fi

    done
}


update_glossary(){
    sleep1 10
    cyan "update:"
    title="my Children story:"
    file=$TODAY_DIR/txt/log.txt
    max=5
    for (( c=1; c<=$max; c++ ))
    do
        echo -n "counter: "
        cyan "$c of $max"
        $PLUGINS_DIR/logger.sh add_line "$file" "$title" 'true'
    done
    #'http://www.cyberciti.biz/faq/bash-for-loop/'
}

reminder(){
    #recent_progress
    #last_step
echo  'show progress in a field'
echo 'show buttinns'
"does 1 tiny step aday - is equal to a nice huge step a month ?"
rainbow "$remind1" 
rainbow "$remind2" 
}
#show(){
#    cyan "show:"
#    gxmessage -title 'show: morning reminder' -file $DYNAMIC/wish.txt $GXMESSAGET
#}
#


glossary_reminder(){
    word=$(    gxmessage -title 'glossary reminder' -file $DYNAMIC_DIR/glossary.txt $GXMESSAGET -entry )
    echo5 "$word"
    choose5 $DYNAMIC_DIR/glossary.txt
}

