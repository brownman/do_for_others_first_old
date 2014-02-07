save(){
    cmd="history 2 | head -1 | sed 's/^ [0-9]*//g' "
    line=`eval "$cmd"`


    echo "$line" | grep 'vi ' -m1 >> .history.edit || \
        echo "$line" | grep 'robot' -m1 >> .history.robot || \
        echo "$line" | grep 'http' -m1 >> .history.url || \
        echo "$line" | grep '.sh' -m1 >> .history.run  || \
        echo "$line" | grep 'http ' -m1 >> .history


}

history1(){
    amount=20
    if [ $# -eq 1 ];then
        str="$1"
        cmd="history $amount | grep \"$str\"" 
        confirm "$cmd"
        results=$(  eval "$cmd" )
        echo "$result"
    else
        echo "Please supply a subject"
        echo "I will grep the last $amount history commands for you.."
    fi

}

export -f save
export -f history1 

