#!/bin/bash -e

# about file:
# plugin:      translation
# description: translate 1 line of text to many languages by choice

step0(){
    
    dir_txt=/tmp
    dir_mp3=/tmp
    dir_html=/tmp
}
step1(){


    
    #    local lang="$2"

    #    local input=$(remove_trailing "$1")
    #local input="$1" #translate src
    echo "input: $input"

    input_wsp=$(echo "$input"|sed 's/ /+/g');
    input_ws=$(echo "$input"|sed 's/ /_/g');

    file_txt=$(  echo $dir_txt/${input_ws}_${lang}.txt )
    file_mp3=$(  echo $dir_mp3/${input_ws}_${lang}.mp3 )
    file_html=$(  echo $dir_html/${input_ws}_${lang}.html )

    file_mp3=$(  echo $dir_mp3/${input_ws}_${lang}.mp3 )

    echo "input_wsp: $input_wsp"
    echo "file_mp3:  $file_mp3"
}
step2(){
    
    result=''
    if [ "$input_wsp" ];then
        result=$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$input_wsp&sl=en&tl=$lang" ) 
        if [ "$result" ];then
            #echo "$result" >> $TODAY_DIR/translate.json
            cleaner=$(echo "$result" | sed 's/\[\[\[\"//') 
            #trace "$result"
            phonetics=$(echo "$cleaner" | cut -d \" -f 5)
            output=$(echo "$cleaner" | cut -d \" -f 1)
            output_wsp=$(echo "$output"|sed 's/ /+/g');
            output_ws=$(echo "$output"|sed 's/ /_/g');



            #notify-send "$output" "$phonetics"

            echo "$output"
            notify-send "$output"
            if [ "$phonetics" ];then
# 3
                echo  "$phonetics"
                notify-send "$phonetics"

            fi  

        else
            reason_of_death 'no results'
        fi

    fi

    #echo "$output_wsp"
}
step3(){
    
    if [ ! -f "$file_mp3" ] || [ -s "$file_mp3" ];then
        wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $file_mp3 
    else
        echo "use cached file"
    fi
    #ls -l $file_mp3

    cmd="play -V1 -q  $file_mp3"
    #    mpg321 $file_mp3 1> /dev/null
    eval "$cmd" 


}

steps(){
     

    step0
    step1
    step2
    if [ "$SOUND" = true ];then
        step3
    else
        echo 'mute sound'
    fi
}

if [ $# -gt 1 ];then
    lang="$1"
    shift
    input="$@"
    steps 
else
    echo reason_of_death "need 2 arguments - got $#"
fi

