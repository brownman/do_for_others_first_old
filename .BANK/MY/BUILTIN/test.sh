clear
set -o nounset
#info: test the stepper (run,source)
#motivation: debug technic: step VS trapping -> know the step  the bug is happend -> then dip farther - no quick goto but safer and clearer
#test_error="touch /sdjflksdjkffff"
print_color () 
{ 
    echo -e "\x1B[01;$1m[*]\x1B[0m $2 "
}
trap_err00(){
    #####
    ##notice: echo/print_color/etc doesn't always work when testing sub-shells - but - notify-send/flite does
    ##solution: for printing the caller - we can use a gui - And - avoid printing to the console
    ######
#   local str_caller=$0
#question: how to indicate that BASH_SOURCE is not applicable 
#set +u
#max="${#BASH_SOURCE[@]:-0}"
#set -x
  #      echo "max: $max"
 #   if [ $max -gt 0 ];then

notify-send "TRAP_ERR"
 local        str_caller=`caller`
 notify-send  "$str_caller"
 #   fi


#    type print_color &>/dev/null && { print_color 33 "[TRAP ERR]" ; } || { echo "[TRAP_ERR]"; }
#    echo "${str_caller:-}"
    [ -f /tmp/err ] && { echo /tmp/err;cat /tmp/err; }
        echo error | flite
    exit 1

}
step(){
    trap trap_err00 ERR
#    export -f trap_err00

    local cmd="$@"
    echo  -n "[ step ] $cmd"
    if [ "$MODE_SUBSHELL" = true ];then
        (    eval "$cmd" 1>/tmp/out 2>/tmp/err )
    else
              eval "$cmd" 1>/tmp/out 2>/tmp/err 
#        eval "$test_error" 1>/tmp/out 2>/tmp/err 
    fi
    local res=$?

    if [ $res -eq 0 ];then
        print_color 32 "[V]"

        #    cat -n /tmp/out
    else
        print_color 31 "[X]"
        #cat -n /tmp/err
        return 1
    fi
}
set_env(){
    file_self=${BASH_SOURCE:-$0}
    dir_self=`dirname $file_self`
    echo "[file_self] $file_self"
    echo "[dir_self] $dir_self"
}
loop(){
    local line=''
    while read line;do
        if [ -n "$line" ];then
            echo "[line] $line"
            eval "$line"
        else
            echo "[Empty Line]"
            break
        fi
    done <$dir_self/list.txt

}
cleanup(){
    touch /tmp/err
[ -f /tmp/err ] && { /bin/rm /tmp/err ; }
[ -f /tmp/out ] && { /bin/rm /tmp/out ; }
}
steps(){    
    cleanup
    set_env
    loop
}

export MODE_SUBSHELL=false
#export MODE_SUBSHELL=true
steps
