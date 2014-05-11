#!/bin/bash
#depand_package: sox flac
#info: speech recognition  
#describe: use google-speech-recognition-api
#later:    parse result - and set the confident level - ask the user for proceeding/repeat/exit
set -o nounset
play(){
    file=$1
/usr/bin/play "$file" 
}
play_wav(){

    play $file_wav
}
trap_sigint(){
    echo
    echo "BREAKING"
    echo ----------------
}
install_dependencies(){
    apt-get install sox
    apt-get install flac
}

record_wav(){
    if [ -n "$file_wav" ];then
        #        rec -r 16000 -c 1 $file_wav
        #        rec -q -c 1 -r 16000 $file_wav silence 1 0.3 3% 1 0.3 3%
        #       rec -q -c 1 -r 16k $file_wav silence 1 0.3 4% 1 0.3 4%
        #echo "Recording... Please press ^C a few seconds after finishing."
        rec -r 16000 -b 16 -c 1 $file_wav
    else
        echo "[error] update var: file_wav "
    fi
}

wav_to_flac(){
    #    flac -f -s $file_wav -o $file_flac
    [ -f $file_flac ] && { rm $file_flac; }
    if [ $file_wav ];then
         local cmd="flac -f -s $file_wav -o $file_flac"
        #local cmd="sox $file_wav $file_flac gain -n -5 silence 1 5 2%"
    echo "[$cmd] $cmd"
    sleep 2
    eval "$cmd"
    else
        echo  "[error] file not found: " "$file_wav"
    fi

}
parse_api_response(){
    #local str_result=`cat /tmp/out`
    #echo "$a" | egrep -o "\"utterance\":\"[^\"]*\"" |sed 's/"utterance":"//;s/"//'|nl
    a=$(echo "$str_result" | grep -Po '(?<="utterance":")[^"]+(?=",)' )
    b=$(echo "$a" |egrep -o "\"confidence\":[^}]*" |sed 's/"confidence"://')
    c=$(qalc $b \* 100 | egrep -o "=.*" |sed 's/= //' |sed 's/\.\([0-9]\)*/\.\1/')

    echo "Done, results below : )"
    echo
    echo "Confidence in results = ${c}%"


}
upload1(){
#    local lang="en-US"
    local results=5
    local google_api_url="https://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&pfilter=2&lang=en-US&maxresults=$results"
    local  cmd="curl -s -H Content-Type: audio/x-flac; rate=16000 --data-binary @${file_flac} $google_api_url"
    echo "[cmd] $cmd"
    sleep 2
    eval "$cmd" 
    #1>/tmp/out 2>/tmp/err
#[ -f /tmp/out ]  && {   cat -n /tmp/out; }
#[ -f /tmp/err ]  && {   cat -n /tmp/err; }
}
present_file_attr(){
    local file=$1
       file $file
}
upload3(){
#expected: {"status":0,"id":"7c5893bbf1eb378686bdf3aa369f1a44-1","hypotheses":[{"utterance":"hello world","confidence":0.6340324}]}

local res=$( wget -q -U "Mozilla/5.0" --post-file $file_flac --header="Content-Type: audio/x-flac; rate=16000" -O - "http://www.google.com/speech-api/v1/recognize?lang=en-us&client=chromium" )
echo "[res] $res"
}
upload2(){
    
    local str_results=$(curl \
        --data-binary @${file_flac} \
        --header 'Content-type: audio/x-flac; rate=16000' \
        'https://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&pfilter=2&lang=en-US&maxresults=5' )
    echo  "$str_results"
}
set_env(){
    dir_self=`dirname $0`
    source $dir_self/CFG/menu.cfg
    file_wav=/tmp/record.wav
    file_flac=/tmp/record.flac
    file_menu=$dir_self/menu.txt
}


#convert to 8 bit
#sox -b $file_in -w $file_out
recording_playing(){
    step    record_wav
    step    play_wav
}
api_interaction(){
    present_file_attr $file_flac
      upload3
#    step    parse_api_response

}        
converting(){
    step    wav_to_flac
    play $file_flac
}

step(){
    local str=$1
    echo "[funcname] $str"
    sleep 2
    eval "$str"
}

steps(){

    trap trap_sigint SIGINT
    set_env

    menu1 "$file_menu" 
}
steps
