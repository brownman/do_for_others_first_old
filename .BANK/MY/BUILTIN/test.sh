clear
set  -x
#info: test the stepper (run,source)
#motivation: debug technic: step VS trapping -> know the step  the bug is happend -> then dip farther - no quick goto but safer and clearer
print_color () 
{ 
        echo -e "\x1B[01;$1m[*]\x1B[0m $2 "
}
trap_err00(){
local str_caller=`caller`
echo
echo
    print_color 33 "[TRAP ERR]"
    echo "$str_caller"

}
step(){


    local cmd="$@"
    echo  -n "[ step ] $cmd"
    if [ "$MODE_SUBSHELL" = true ];then
    (    eval "$cmd" 1>/tmp/out 2>/tmp/err )
else
        eval "$cmd" 1>/tmp/out 2>/tmp/err 
    fi
    local res=$?

    if [ $res -eq 0 ];then
        print_color 32 "[V]"

    cat -n /tmp/out
    else
        print_color 31 "[X]"
        cat -n /tmp/err
        exit 1
    fi
}
steps(){    
    file_self=${BASH_SOURCE:-$0}
    dir_self=`dirname $file_self`
    while read line;do
        if [ -n "$line" ];then
        eval "$line"
    else
        echo "[Empty Line]"
        break
    fi
    done <$dir_self/list.txt
}

    trap trap_err00 ERR
export MODE_SUBSHELL=false
#export MODE_SUBSHELL=true
steps
