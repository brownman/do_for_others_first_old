#!/bin/bash 
# about file:
# plugin:      translation
# description: translate 1 line of text to many languages by choice
declare -A repeater
repeater["it"]=1
repeater["en"]=1
repeater["ru"]=2
repeater["ar"]=1
repeater["hi"]=1
repeater["jp"]=1
repeater["tl"]=1

declare -A amount 
amount["jp"]=11
amount["it"]=11
amount["en"]=11
amount["ru"]=12
amount["ar"]=3
amount["hi"]=2
amount["tl"]=1
#export repeater
help_options="sentance/ line/ lines"
method="$1" #sentance, line, lines
from="$2" #file or sentance
multiple_langs=true
#false
#assert_equal_str "$3"
silence2=${3:-"$SILENCE"} #"$3" #false #export MULTIPLE_LANGS=true
#if [ "$silence2" = 'false' ];then
#breakpoint 3
#fi
#cmd="notify_send1 'silence request?' '$silence2'"
#every "$cmd" 9
#assert_equal_str "$silence2" 'false'
#silence2=$silence2
lang_target=$LANG_DEFAULT

#silence2_fetch=$silence2_FETCH #if no tts is needed
silence2_fetch=true
#$silence2

#unlocker?
file_locker=/tmp/translation
delay=3
loops=2
gentle=true

trace 'translate.sh got:'
trace "1:$1 2:$2"
notify_send 'TranslatE:' "$@"


random_language_changer(){

    random1 10
    local ans=$?

    if [ $ans -eq 0 ];then
        lang_target="ar"
    elif [ $ans -eq 1 ];then
        lang_target="hi"
    elif [ $ans -eq 2 ];then
        lang_target="it"
    elif [ $ans -eq 3 ];then
        lang_target="tl"
    fi

    trace "switch language to:" "$lang_target"

}
fetch_html(){
    is_valid "$file_html"
    result=$?
    trace 'result is: '
    trace $result
    if [[ $result -ne 1  ]];
    then
        trace "fetch html"
        if [ "$lang" = 'ru' ]|[ "$lang" = 'ar' ];then
            tasker scrap "$lang" "$input"
            tasker show_file_html $file_html
        fi
    else
        tasker show_file_html $file_html
        trace "cache copy"
    fi
}
make_assosiation(){
    local str="$1"

    local ass=$(gxmessage -entrytext "$str|$lang_target|" -title "sound like:"  -file $file_assosiation $GXMESSAGET -iconic )
    if [ "$ass" != '' ];then
        echo "$ass" >> $file_assosiation
        #update_logger "make_assosiation" "$ass"
    fi


}
play1(){
    #assert_equal_str "play: silence2 is:$silence2"
    trace "play1() got: "
    trace "$1 | $2"

    if [ "$silence2" = 'false' ];then

        local file="$1"

        if [ "$PLAYING_ON" = false ];then
            export PLAYING_ON=true
            local lang="$2"
            #local lang_repeat=\$"$lang"R   # Name of variable (not value!).
            #local times1=$(eval "expr \"$lang_repeat\" ")
            times1=${repeater[$lang]} 
            times1=${times1:-1}

            notify_send "times: $times1 for $lang"
            if [ "$times1" != '' ];then

                #declare  -i  counter
                local counter=0
                while [[  $counter -lt  $times1 ]]; do
                    play -V1 -q  "$1"
                    (( counter++ ))
                done
            else
                play -V1 -q  "$1"
            fi
            export PLAYING_ON=false
        else
            trace 'playing is already on'
            #Backtrace1
        fi
    else
        cmd="notify_send1 'silence' 'on'"
        every "$cmd" 15
        #notify_send1 'silence2 is on'
        trace 'skip playing'

    fi

}


translate_f(){

    ################################# result: txt 
    trace "translate_f() got:"
    trace "input: $1 | lang: $2"


    local lang="$2"

    local input=$(remove_trailing "$1")
    #local input="$1" #translate src




    local input_wsp=$(echo "$input"|sed 's/ /+/g');
    local input_ws=$(echo "$input"|sed 's/ /_/g');

    local file_txt=$(  echo $dir_txt/${input_ws}_${lang}.txt )
    local file_mp3=$(  echo $dir_mp3/${input_ws}_${lang}.mp3 )
    local file_html=$(  echo $dir_html/${input_ws}_${lang}.html )

    is_valid $file_txt
    result=$?
    trace 'result is: '
    trace $result
    if [[ $result -ne 1  ]];
    then
        trace "fetch txt"
        result=$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$input_wsp&sl=en&tl=$lang" ) 
        #echo "$result" >> $TODAY_DIR/translate.json
        cleaner=$(echo "$result" | sed 's/\[\[\[\"//') 
        #trace "$result"
        phonetics=$(echo "$cleaner" | cut -d \" -f 5)
        output=$(echo "$cleaner" | cut -d \" -f 1)
        output_wsp=$(echo "$output"|sed 's/ /+/g');
        output_ws=$(echo "$output"|sed 's/ /_/g');

        #touch "$file_txt"
        echo "$output" >   "$file_txt"

        if [  "$lang" = 'ru' ] || [ "$lang" = 'hi' ]
        then 
            echo  "$phonetics" >>   "$file_txt"
        fi
        cat $file_txt

        #is_valid $file_txt
    else

        cat $file_txt
        trace "cache copy"

    fi
    printing1  "$file_txt" "$lang" "$input"

    ################################# result: html 
    #fetch_html

    ################################# result: mp3 
    output=$(cat $file_txt | head -1)
    #blue "fetch for: $output"
    output_wsp=$(echo "$output"|sed 's/ /+/g');
    output_ws=$(echo "$output"|sed 's/ /_/g');
    is_valid $file_mp3
    result=$?
    if [[ $result -ne 1 ]];then
        trace 'fetch sound'
        if [ "$lang" = 'tl' ]
        then
            trace $output
            #trace "$output" | text2wave -o "$file_mp3" #/tmp/1.wav | lame /tmp/1.wav  $file_mp3 
        else
            if [ "$silence2_fetch" = true ];then
                trace 'play this mp3 on next run'
                ( wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $file_mp3 &) 
            else
                wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $file_mp3 
                play1  "$file_mp3" "$lang"
            fi
        fi
        #is_valid $file_mp3
    else
        #trace $result
        trace "cache copy"
        if [ "$lang" = 'tl' ]
        then
            trace 'no tl audio'
        else

            play1  $file_mp3 "$lang"
        fi


    fi

}




choose5(){
    trace "choose5() got: $1"

    local file=$1
    local files1=$(ls  $file 2> /dev/null )
    if [ ! "$files1" ];then
        error_handler 
    fi


    local str=$(cat $file | sort --random-sort | head -n 1)

    trace "choosen line: "
    trace "$str"
    echo5 "$str" 
}


choose4(){
    trace "choose4() got: $1"

    local file=$1
    local files1=$(ls  $file 2> /dev/null )
    if [ ! "$files1" ];then
        error_handler 
    fi

    local str=$(cat $file | sort --random-sort | head -n 1)

    trace "choosen line: "
    trace "$str"

    echo4 "$str" 
}


echo5(){

    #sleep1 3
    notify_send 'echo5'

    #count words in sentence - if lower then 4 - translate_f also to: ar, hi
    local max1=0
    local str="$1"

    local cmd=''
    if [ "$str" = '' ];then

        error_handler
        exiting
    fi

    #    speller "$str"
    #    if [[ $? -eq 1 ]];then
    #        return 
    #    fi
    local  current=$(echo "$str" | wc -w)




    for lang in "${!amount[@]}"
    do
        #notify_send1 ""
        max_for_lang=${amount[$lang]}
        max_for_lang=${max_for_lang:-12}
#notify_send1        "$max_for_lang -gt $current ?"
        if [ $current -le $max_for_lang ];then
         
            #notify_send1 "  translate:  $lang : $str"
            translate_f  "$str" $lang 
            sleep1 2
        fi
    done

    collect_new_words "$lang_target" "$str" &
}


collect_new_words(){

    local lang1="$1"
    local str="$2"
    local num=$(echo "$str" | wc -w)
    if [[ $num -gt 1 ]];then
        cmd="tasker string_to_buttons \"$str\""
        local pick_word=$( commander   "$cmd")
        if [ "$pick_word" != '' ];then


            cmd="translate_f \"$pick_word\" $lang1"


            commander "$cmd"

            cmd="make_assosiation $pick_word"
            optional1 "$cmd" # 'make assosiation' 'question'
            #tasker add_association

        fi
    else
        #notify_send 'scrap here..'
        trace 'scrap here..'

        #fetch_html
    fi
}


echo4(){
    trace "echo4() got: $1"




    if [ "$1" = '' ];then
        trace 'empty string'
        return
    fi

    #speller "$1"

    if [[ $? -eq 1 ]];then
        return
    fi





    random_language_changer
    local lang1="$lang_target"
    trace "translate to: $lang1"


    #    if [ "$lang1" = '' ];then
    #        random1 4
    #        local num=$?
    #        #trace "num: $num"
    #        lang0="${arr1[$num]}"
    #        lang1=$(lower $lang0)
    #    fi

    local str="$1"
    trace "$str"

    collect_new_words "$lang1" "$str" &


    translate_f  "$str" "en"


    sleep1 2 

    translate_f  "$str" "$lang1"

    sleep1 2
    translate_f  "$str" "$lang1"

}
printing1(){
    #notify_send1 "printing1"
    #local input_ws="$1" 
    local file_txt="$1"

    local lang="$2"
    local input="$3"

    local line1=$(cat $file_txt | head -1)

    #local line3=$(echo "$line2"|sed 's/ /:1,/g');

    local line2=''
    local max=$(cat $file_txt | wc -l)
    if [  $max -eq 2 ];then
        line2=$(cat $file_txt | head -2 | tail -1)
    fi
    #assert_equal_str "$line2"

    if [ "$lang" != 'en' ];then
        local tmp1="$lang|$input|$line1|$line2" 
        #(  tasker db set 'words' true true "$tmp1" &)
    fi

    #assert_equal_str "abc"
    if [ "$silence2" = true ];then
        if [ "$lang" = ru ];then
            notify_send1 "$line2" "$line1"   

            #update_logger "translate" "$input ! $lang ! $line2 !  $line1"
        else

            notify_send1  "$line1"
        fi
    else
        if [[ "$lang" = he  ||  "$lang" = hi ]];
        then
            notify_send1  "$line2" "$line1"   

        else
            notify_send1  "$line1"
        fi

    fi

}


one_line(){
    local file="$1"
    #choose5 $STATIC_DIR/reminder.txt
    #choose4 $STATIC_DIR/motivations.txt

    #choose4 $DYNAMIC_DIR/motivation/glossary.txt
    #choose5 $DYNAMIC_DIR/motivation/glossary.txt
    if [ "$multiple_langs" = true ];then
        if [ "$file" != '' ];then
            choose5 "$file"
            #else
            #choose5 $CFG_DIR/quotes.txt
        fi

        #one_tip
    else
        if [ "$file" != '' ];then
            choose4 "$file"
            #else
            #choose4 $CFG_DIR/quotes.txt
        fi

        #one_tip
    fi

}

all_lines(){
    notify_send 'speak all lines'
    lines=() 
    local from="$1"
    local delay=4
    local cmd='echo4'
    #local cmd='notify_send1'
    file_to_lines "$from"

    execute_lines

    #assert_equal_str "${lines[1]}"
    #local msg=$(    execute_lines )
    #local msg=$(file_to_lines "$from")
    echo "$msg"
    echo "zz"

}


run(){
    #assert_equal_file $file_log

    local result=''
    #motivation "$file"
    if [ "$method" = 'sentence' ];then
        #speller "$from"
        #assert_equal_str "$from"
        if [ "$multiple_langs" = true ];then
            echo5 "$from" 
        else
            echo4 "$from" 
        fi
    elif [ "$method" = 'line' ];then

        #speller "$from"
        one_line "$from"
    elif [ "$method" = 'lines' ];then

        #result=$(
        all_lines "$from"
        ##result=$(all_lines "$from")
        echo "$result"
    else
        trace   "unknown method:"
        help1 "$help_options"
    fi
}

unlocker true
