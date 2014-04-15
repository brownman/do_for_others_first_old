#!/bin/bash -e
#help:a  random   bash    prompt
set -o nounset
#alias promptE="gvim $dir_rc/lib/private/random/prompt.cfg"


export file_list_random=$dir_workspace/lists/random_command.txt
#$dir_workspace/lists/random.txt
alias randomE="gvim $file_list_random"
echo "randomE installed !"
randomE(){
    echo 'edit random!'
    sleep 1
    if [ -f "$file_list_random" ];then
        gvim $file_list_random &
    fi
}
test_something(){
    assertEqual 1 2
}
step1(){
    #info: pick a random line from the list 
    #get _
    #use _
    #set line
    num=` wc -l $file_list_random | cut -d' ' -f1`
    let 'num+=1'
    let "num1 = $RANDOM % $num"
    let 'num1+=1'
    let "num2 = $RANDOM % $num1"
    let 'num2+=1'
    line="cat -s $file_list_random | head -$num2 | tail -1"
}

step2(){
    #use: line
    #do:  parse+print the choosen line
    str=`eval "$line"`
 #trace   "str:  $str"
    cmd=`echo "$str" | cut -d'#' -f1`
 #trace   "cmd:  $cmd"
    msg=`echo "$str" | cut -d'#' -f2`
 #trace   "msg: $msg"
    echo -e "random command:\t\t$msg"
    #echo "eval: $cmd"
   # echo -n "dice:  $num:"
   # sleep 2
  #  echo "$num2"
   # sleep 2
}
step3(){
#use: $cmd
#do : evaluate the command
echo
    echo ----------------------------------------

    if [ -n "$cmd" ];then
    #    echo  "$cmd"
        eval  "$cmd"
    else
        echo "got empty line from: " "$file_list_random"
    fi
    echo
    echo ----------------------------------------

}
steps(){
#    echo 'steps()'
    step1
    step2
    step3
}

steps


