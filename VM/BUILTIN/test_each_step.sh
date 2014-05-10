clear
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
    else
        print_color 31 "[X]"
        cat /tmp/err
    fi
}
steps(){
    step source source.cfg
    step source struct.cfg
    step ./run.sh
}

    trap trap_err00 ERR
export MODE_SUBSHELL=false
#export MODE_SUBSHELL=true
steps
