#!/bin/bash
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 
#cmd="notify_send1 'tasker.sh:' '$@'"
#every "$cmd" 10
option(){
local task="$1"
local cmd="tasker $task"
notify_send4 "$task" "$cmd"
}
shopping(){
    local res=1

    local file="$DATA_DIR/txt/shopping.txt"
    while [ "$res" ];do
        notify_send1 'buy more'
        res=$(zenity1 "$file")
        if [ "$res" ];then
            cmd="xdg-open \"$res\""
            #notify_send4 'open website' "$cmd"
            detach "$cmd"
        else
            cmd="gedit $file"
            detach "$cmd"
        fi
    done

}

lecture(){

    local util=vlc
    local subject=lecture
    local recent=$(recent lecture )
local dir=$DIR_LECTURE


    local res=$(confirm  'linux lecture' 'string:' "$recent")
    
#assert_equal_str "$?"
    if [ "$res" = '' ];then

        #file open
        local dir=/TORRENTS
        local res=$(pick_file "$dir" )


    fi
    if [ "$res" ];then
        #cmd="vlc \"$res\""
        #detach "$cmd"

#assert_equal_str "$res"
        update_points "$res" lecture
        local cmd="$util '$res'"
        detach "$cmd" 


    fi



}

show_psaudo_like_koans(){
    trace ''
}

cron(){
    $PLUGINS_DIR/cron.sh "$1"
}

question(){
    local str=$(gxmessage $GXMESSAGET -entry -title question 'investigation begins')

    if [ "$str" ];then
        local cmd='tasker motivation question'
        detach "$cmd"

        url2="http://www.commandlinefu.com/commands/using/$str"
        url3="http://unix.stackexchange.com/questions/tagged/$str"
        url1="https://github.com/brownman/brownman.github.com/edit/master/README.md"

        cmd="xdg-open $url1"
        detach "$cmd"
        cmd="xdg-open $url2"
        detach "$cmd"
        cmd="xdg-open $url3"
        detach "$cmd"
    fi
    cmd="~/magnify_the_small/AWESOME/fu -a '$str1'"
    #cmd1="xterm1 $cmd" 
    local res=$(detach "$cmd")
    gxmessage "$res" -title "fu" $GXMESSAGET
    #detach "$cmd1"
    cmd="grep -lr '$str' $SCRIPT_DIR/tasks/abs/source/*.sh"
    #cmd1="xterm1 $cmd"
    local res=$(detach "$cmd1")
    gxmessage "$res" -title "abs" $GXMESSAGET
    
#grep -r "$str" $SCRIPT_DIR

}
readme1(){
    echo 'update readme with blogger image of whiteboard'
}
funny_brain_wash(){
    notify_send3 'be happy' 
}
plan_hour_5m_step(){

    #local  trigger=$(  zenity1 $DATA_DIR/txt/enlightment.txt )
    #helper0 "$trigger"
    arr=(1 2 3 4 5 6) 
    show_args



}

update_points(){
    notify_send 'update' 'points'
    local str="$1"
    local filename=${2:-logger}
    local file=$DATA_DIR/log/$filename.log
    if [ "$str" ];then
        update_file  $file "$time1|$str"
        #cmd='tasker wallpaper'

        #optional "$cmd" "tasker wallpaper" warning 

        #every "$cmd"
        #every "$cmd" 10
    else
        notify_send 'skip'
    fi
}


wallpaper(){
    notify_send3 'updating wallpaper'
    local cmd=$PLUGINS_DIR/wallpaper.sh
    detach "$cmd"
}


translate_later(){
    gedit $DATA_DIR/txt/later.txt
}


config(){
    #export DEBUG=true
    notify_send 'cfg-test' 'unit..' 
    args=( "$@" )
    res1=$(  "${args[@]}" )
    echo "$res1" #must echo for testing to work
    #assert_equal_str "$res1"
}

say(){
    flite "$1"
}
collect_new_words(){
    cmd='tasker learn_langs'
    commander "$cmd" &
    flite 'collect new words!' true
    flite 'create your own conversation'
    optional "free_imagination  $DATA_DIR/txt/conversation.txt" 
    ( exo-open http://www.google.com &)
}
cfg1(){

    #assert_equal_str 'cfg1 doesnt exist'
    #config
    #breakpoint
    trace 'no cfg1'
    flite 'exiting'
    sleep1 8
    exiting

}
#efficiency_report(){
#    flite 'efficiency report'
#    notify_send1 'efficiency report:' 'words,snippets,order'
#    local res=$(    level )
#    #local res=$(    check-boxes)
#    #notify_send1 'efficiency level:' "$res"
#    #echo "$res"
#    return $res
#}
efficiency_report2(){
    #$( messageYN1 "report:" ' are you efficient ? (answer: left or right)'  )
    #local result1=$?
    #update_file $file_logger "$time1|$max_efficiency|$result1"

    local str="$time1"
    db set efficiency true true "$str" 
}


impulse(){

    local   file=$DATA_DIR/txt/testing.txt 

    free_imagination $file
    #local line=$(cat $file | head -1)

}


children_story(){
    notify_send1 'children story'

    url1='http://teaching-tales.org/'
    url2='http://www.mamalisa.com/'


    exo-open "$url1" &
    exo-open "$url2" &
    free_speak child &
}
riddle(){
    notify_send1 'task' 'riddle'
    $PLUGINS_DIR/riddle.sh 
}


free_imagination(){
    local file=${1:-"$DATA_DIR/txt/testing.txt"}

    $PLUGINS_DIR/free_imagination.sh "$file"
}

do_koan(){
    #local dir_source=$PWD/1/testing/python2/koans

    local dir_source=$dir_koans
    local file_name_target="recent_koan.py" 
    update_recent_link "$dir_source" "$file_name_target"

    cat $LINKS_DIR/recent_koan.py | head -10
}

#notify_send "tasker.sh:" "$*"
article(){

    local file="$1"
    $PLUGINS_DIR/article/commands.sh "$file"
}

google(){
    $PLUGINS_DIR/google.sh "$1"
}


task_from(){
    notify_send "picker got" "$@"

    local name="$1" #
    local num="$2" #
    local file1=$DATA_DIR/tmp/${name}.tmp
    #mantion_file $file1
    local str=''
    if [ "$num"  = '' ];then
        str=$(zenity1 $file1)
    else
        lines=()
        file_to_lines $file1 
        str=$(echo ${lines[$num]})

    fi

    local cmd="tasker $str"

    #assert_equal_str "$cmd"
    #assert_equal_str "$cmd"

    #notify_send4 "$cmd" "$cmd"
    detach "$cmd"
    #eval "$cmd" & 
}

ask_a_question(){
    notify_send 'ask! and learn!'
}

random_quote(){
    local res=$( $PLUGINS_DIR/random_quote.sh )
    echo "$res"
}
show_msg(){
    trace "show_msg $1: $2"
    local msg=$( gxmessage $GXMESSAGET "$1" -title "$2" -entry )
    #commitment "$msg"
    echo "$msg"
}


practice_regexp(){
    #http://linux.die.net/Bash-Beginners-Guide/sect_04_02.html#sect_04_02_02

    local exp=${1:-'\<c...h\>'}

    exp=$(gxmessage $GXMESSAGET -entrytext "$exp" -title 'practice!' 'Enter RegExp:' )

    local file=/usr/share/dict/words
    local file_tmp=/tmp/regexp
    local res=$(grep "$exp" "$file")
    #gxmessage $GXMESSAGET "$res" -title "$exp"

    echo "$res" > $file_tmp
    local str=$(zenity1 "$file_tmp")
    echo01 "$str"
}


string_to_buttons(){

    local str="$1"
    local delimeter=${2:-' '}
    local res=$($PLUGINS_DIR/string_to_buttons.sh "$str" "$delimeter")
    tasker update_points "$res" collected
    echo "$res"
}

free_speak(){
    local subject=${1:-'free'}

    xterm1 $PLUGINS_DIR/free_speak.sh "$subject" 
    #disown
}

nothing(){
    trace "nothing got: $1"
    echo "$1"
}

rules(){
    #gxmessage $GXMESSAGET -file 
    zenity1 $DATA_DIR/tmp/notes.tmp

}

recent_video(){
    str='vlc /TORRENTS/VIDEO1/SecurityTube.Python.Scripting.Expert/Module-01/02.m4v'
    commander "$str"
}

take_photo(){
    $PLUGINS_DIR/take_photo.sh
}

increase_motivation(){

    detach $PLUGINS_DIR/increase_motivation.sh
}

db(){
    #notify_send1 'db' "$@"

    ##works:
    local args=( "$@" )
    #$(show_args "${args[@]}")
    local res1=$(   $PLUGINS_DIR/db.sh   "${args[@]}")
    echo "$res1" #must echo for testing to work
    #assert_equal_str "$res1"
    ############################### proxy for execution #####################



}

menu(){
    breakpoint
}

#cow_report(){
#    local table=$1
#    local num=$( db counter $table)
#    notify_send3 "$table.db: ++$num "
#}
cow_report_txt(){
    #flite 'riddl'
    #local file=
    #local num=$( cat $DATA_DIR/txt/assosiation.txt | wc -l )
    #xcowsay "associations: $num"
    trace ''
}

motivation(){

    #notify_send1 'motivation'
    #caller1
    subject="$1"
    #cmd=cow_report
    #every "$cmd" 3 
    #reason='push: learning new language'
    local line=''

    if [ "$subject" = '' ];then
        random1 10
        ans=$?
        if [ $ans -gt 5 ];then
            line=$(random_from_subject1 glossary)
        else
            line=$(random_from_subject1 sport)
        fi
    else
        line=$(random_from_subject1 "$subject")
        #assert_equal_str "$line"
    fi

    #tasker  update_points "$line"

    #    res=$( dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend )

  #  cmd="helper0 \"$line\""  
  cmd="flite '$line'"
    detach "$cmd"
    #notify_send4 "$line" "$cmd"
    #assert_equal_str "$line"


    #    #show_file "$file_name" &
    #    echo "line: $line"
    #    cmd=cow_report
    #    every "$cmd" 2 


}

motivations(){
    notify_send3 'motivationsssss!'
    local file=${1:-"$DATA_DIR/txt/later.txt"}
    local cmd="$PLUGINS_DIR/translation.sh lines  true"
    commander "$cmd"
    echo "$motivations"
    #fi
    #echo 'end'
}


scrap(){

    local lang=$1 
    local word=$2 
    local word1=''
    trace "word: $word"


    word1=$(echo "$word") 
    $PLUGINS_DIR/scrap.sh translate $lang "$word1" 
    #exo-open /TORRENTS/html/


}

add_koan(){
    #yellow 'add 1 koan !'
    #( bash -c $KOANS_DIR/meditate.sh &)
    cmd="gedit $PROJECT_DIR/bugs/bash_koans/src/about_sed.sh"
    detach "$cmd"
    cmd="gedit $PROJECT_DIR/bugs/bash_koans/src/about_project.sh"
    detach "$cmd"
    cmd='tasker open_more'
    optional "$cmd"
}

open_more(){
    cmd="gedit $PROJECT_DIR/bugs/bash_koans/meditate"
    detach "$cmd"
    cmd="gedit $PROJECT_DIR/bugs/bash_koans/support/functions.sh"
    detach "$cmd"
    cmd="gedit $PROJECT_DIR/bugs/bash_koans/support/1/garbadge.sh"
    detach "$cmd"

    cmd="gedit $PROJECT_DIR/bugs/bash_koans/support/functions.sh"
    detach "$cmd"

    cmd="gedit $PROJECT_DIR/bugs/bash_koans/support/1/garbadge.sh"
    detach "$cmd"
}

set_rational_condition(){
    trace ''
    local file="$DATA_DIR/txt/rational_condition.txt"
    gedit "$file"
}

record_for_later(){
    xdg-open 'http://www.youtube.com/upload'
}




show_file_html(){
    local    file="$1"
    string_to_buttons_file 'cancel edit' '2 options' $file
    answer=$?

    if [[ $answer -eq 1 ]];then
        exo-open $file
    else
        echo 'skip editing'
    fi

}

show(){
    trace "show() got: $1 $2"
    local name="$1"

    flite "minimizinged file" # - $name"
    local file=$CFG_DIR/txt/$name.txt
    touch $file
    show_file "$file"
}

time1(){
    date1="$(date +%H:%M)"
    ( gxmessage  -buttons "_$last_task" "time: $date1"  -sticky -ontop -font "serif bold 74" -timeout $TIMEOUT1 &)
    echo4 "$date1"
}

update(){
    cyan "update:"
    title="NOW DOING:"
    file=$now_txt
    add_line $file "$title" true #add time note 
    tile="EFFICIENT COMMITMENT:"
    file=$ideas_txt
    add_line $file "$title"
}

#before_suspension(){
#    notify_send1 'before_suspension'
#    flite 'think smaller'
#    sleep1 5
#    motivation
#
#    cmd=free_speak
#    every "$cmd" 10
#
#    cmd=learn_langs
#    every "$cmd" 15
#e
play_recent(){
    local line=$(        random_line $DATA_DIR/tmp/workflow.tmp )
    parse_line1 "$line" 
    #commander "$line"

    #update_table logger "$date1" "play_recent" "$line1"
}
task_force(){
    local line=$( random_line $DATA_DIR/tmp/task_force.tmp )


    local str=$( echo "$line" | awk -F '|' '{print $1}' )
    local cmd=$( echo "$line" | awk -F '|' '{print $2}' )
    notify_send3 "$str"
    commander "$cmd"
}


resources(){
    notify_send1 'resources' 'list'
    local url=$(        random_line $DATA_DIR/tmp/resources.tmp )
    commander "exo-open $url"

}

easiest_task(){
    local file=$DATA_DIR/txt/testing.txt
    #touch $file
    free_imagination $file &
    local  str=$(cat $file | head -1)
    flite "$str"
}


must(){

    cmd="$PLUGINS_DIR/must.sh"
    #notify_send4  'must' "$cmd"
    eval "$cmd"

}

lpi(){
    local file='/home/dao01/Desktop/linux-edu/LPIC1.pdf'
    #local file_memory_page=/tmp/page.txt
    #local page=$( cat $file_memory_page | head -1 )
    local res=$( recent "page" 'lpi page' )
    update_points "$res" lpi
    #update_file "$file_memory_page" "$page" 
    local util=$util_pdf
    local cmd="$util $file -i $res"
    detach "$cmd"
    optional1 "tasker lpi"
}

background(){

    args=( "$@" )
    (  "${args[@]}" &)
    #res1=$(   )
    #trace "$res1" #must echo for testing to work
    ###########################
    notify_send3 finito
}
after_suspend(){
  cmd='tasker reminder'
   detach "$cmd" 
}
suspend2(){
    tasker update_points "suspend2" suspend2
     $PLUGINS_DIR/suspend.sh

cmd="exo-open http://0.0.0.0:3000"
eval "$cmd"




 #after_suspend 
}
updating(){
    local cmd="gedit $DATA_DIR/yaml/url.yaml"
    #$cmd &
    detach "$cmd" 
}
updating1(){


    local type=$(gxmessage $GXMESSAGET -entry -title 'file type' 'choose:' )
    local str=$(gxmessage $GXMESSAGET -entry -title 'file name' 'update:' )
    local cmd=''

    if [ "$str" ] && [ "$type" ]
    then
        if [ "$type" = 'cfg' ];then
            file=$CFG_DIR/$str.$type
        elif [ "$type" = koan ];then

            local file="$PROJECT_DIR/bugs/bash_koans/src/about_$str.sh"
            touch $file
            chmod u+x $file
        else #yaml, txt , tmp
            file=$DATA_DIR/$type/$str.$type

        fi
        cmd="gedit $file"
        detach "$cmd"
    else 
        notify_send1 'Error on: str, type'
    fi

}
suspend1(){
    local timeout=300
    notify_send1 'reminder' 'kill noisy tasks'
    #sleep1 20
    local gui=$1
    if [ "$gui" = 'true' ];then
        tasker sleep2 "$suspend1_motivation" 'suspend?' $timeout
    else

        sleep1 $timeout
    fi
    $PLUGINS_DIR/suspend.sh
    notify-send3 "finish suspend2"
    update_points suspend1 suspend1
    flite 'suspend2 finish'
}
pownder(){
    local subject="$1"
    gedit $DATA_DIR/txt/$subject.txt
}
act_or_do(){


    messageYN1 'act or do' "y/n"
    res=$?


    if [ $res -eq $NO ];then
        pownder "task"
    else
        xdg-open 'www.google.com'

    fi
}

show_progress(){
    local cmd="sleep2 '$1' '$2' '$3'"
    "$cmd"
}

report(){
    echo 'update google blogger with the score for this cycle'
}

collaboration(){
    #(      \'xterm1 $PLUGINS_DIR/collaboration.sh &)
    $PLUGINS_DIR/collaboration.sh 
    #sleep1 30
}

reminder(){
    #notify_send1 'reminder'
    flite 'update  every cicle'
    $PLUGINS_DIR/reminder.sh 
}

game_essay(){
    $PLUGINS_DIR/game_essay.sh
}

learn_langs(){
    local file=$DATA_DIR/txt/conversation.txt
    local    cmd='tasker free_imagination $file'
    optional "$cmd" 
    local cmd1="xterm1 $PLUGINS_DIR/learn_langs.sh"
    detach "$cmd1"
    #play_lesson 
    #notify_send3 finish-task1
}


update_row(){

    local name="$1"
    local cmd=$(echo "zenity1 $DATA_DIR/txt/${name}.txt $name 'be smarter' " )
    local str=$(eval $cmd   )
    #local str=$(commander "$cmd")
    #- cfg|zenity1|$DATA_DIR/txt/glossary.txt,'glossary','be smarter','--editable'|dd
    #echo01 "$str"

    echo "update_row: $str"
} 

scp_android(){
    $(messageYN1 'backup db to android device ?' 'backup'  )
    answer=$?

    if [[ $answer -eq 1 ]];then
        $PLUGINS_DIR/android.sh 
    else
        echo 'skip backup'
    fi



}
update_readme(){
    #local file=$DATA_DIR/txt/dump.txt
    local readme=$DATA_DIR/md/README.md


    gedit $readme &
}
homework(){
    local dir=$DATA_DIR/homework/linux-edu
    local res=$(pick_file "$dir" )
    xdg-open "$res"

}


git_commit(){
    local answer=$(    gxmessage $GXMESSAGET -entry  "git commit ?" )
    if [ "$answer" ];then
        git rm -r --cached .
        update_readme &
        git add . 
        git commit -am "$answer"


        $(messageYN1 'push to remote?' 'github' )
        answer=$?

        if [[ $answer -eq $YES ]];then
            git push origin develop 
            exo-open 'https://github.com/brownman/magnify_the_small' &
        else
            echo 'skip pushing'

        fi

    fi
}

push_order_forward(){
    update_db "priorities"
}
deal_comparison(){
    $PLUGINS_DIR/deals.sh
}


############################### proxy for execution #####################

##works:
args=( "$@" )
#$(show_args "${args[@]}")
#eval show_args
res1=$(  "${args[@]}" )
echo "$res1" #must echo for testing to work
#assert_equal_str "$res1"
############################### proxy for execution #####################


