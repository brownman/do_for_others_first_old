#!/bin/bash
reset
trap_sigint(){
    echo $FUNCNAME
    #exec gvim $file_list 
    proxy update_clipboard "cd $dir"
    exit 0
}
trap_err(){
echo `caller`
exit
}
parse_tag(){
    file=$1
    tag=$2
    present=${3:-false}
    str=$(   cat $file | grep $tag | sed "s/#$tag//g" )
    if [ $MODE_FAST = true ] || [ $present = false ] ;then
        if [ $tag = info ];then
            #echo -en "\t\t [ $tag ] "
            #   print_color 34    "$str"
            echo "$str"
        else
            echo -e "\t\t [ $tag ] $str"
        fi
    else
        echo -en "\t\t [ $tag ]"
        pv1 "$str"
    fi
}
step1(){
    #    print_color 34 " - - - - - - -  - - -[PENDING] - - - - - - "
    toilet1 GENIUS
    #flite1 "your are a genius - trust me - i know what i say - it is a long, long  time since I notice you and .... anyway ..... fuck off" &
    flite1 success
    while read line;do
        echo -n "[ $line ] "
        dir=$dir_self/BANK/$line
        dirname=`basename $dir`
update_clipboard "cd $dir"
#echo        eval "alias cd_${dirname}='cd $dir'"
        file=$dir/.README.md
        #assert file_exist "$file"
        #echo res -  $?
        parse_tag $file info
        parse_tag $file pending
        parse_tag $file imagine true
        #    if [ $MODE_FAST = false ];then
        #fi
        #sleep 2
    done<$file_list
}
steps(){

trap trap_sigint SIGINT
trap trap_err ERR
file_runner=${BASH_SOURCE:-$0}
dir_self=`where_am_i $file_runner`
file_list_tmp=$dir_self/list.txt
str_focus=`cat focus`
pv1 "[ focus ] $str_focus"
str_res=`cat $file_list_tmp | grep $str_focus`

file_list=/tmp/list
echo $str_res > $file_list


step1

}

export MODE_FAST=${1:-true}
steps
