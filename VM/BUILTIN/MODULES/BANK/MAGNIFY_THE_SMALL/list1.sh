clear
exec 2>/tmp/err
trap trap_err ERR

trap_err(){
    str_caller=`caller`

    echo "TRAPPING ERROR"
    echo "[str_caller] $str_caller"

    local cmd0="gvim ${file_last}"
    #cmd0="$file_last"
    local cmd=$( gxmessage -entrytext "$cmd0" -file /tmp/err )
    eval "$cmd"
}
set_env(){
    export dir_self=`pwd`
    echo "[dir_self]: $dir_self"
    export file_list=$dir_self/.list1.txt
    echo "[file_list]: $file_list"
}
eat(){
    local    cmd="$@"
    echo "[cmd] $cmd"
    eval   "$cmd" 
    sleep  2
}


single(){
    while read line;do
        if [ -n "$line" ];then
            task_name=$( echo $line | cut -d' ' -f1 )
            args=$( echo $line | cut -d' ' -f2- )
            local file_task=$dir_self/SINGLES/BANK/$task_name/${task_name}.sh
            #[ -s "$file_task" ] && { eat "$file_task" ;} || { echo "[file not exist] $file_task";ls -l $file_task; }
            eat "$file_task $args"
        else 
            break
        fi

    done<$file_list
}

loop(){
    local counter=1
    while :;do
        flite -t "round $counter"
        xcowsay "round $counter"
        single
        let 'counter += 1'
    done
}
steps(){
    set_env
    loop
}

export -f trap_err
steps
