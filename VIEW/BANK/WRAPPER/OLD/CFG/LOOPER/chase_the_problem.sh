#!/bin/bash 
export CRAZY_CHASE=false
exec 2>/tmp/err
cmd_trap="trap trap_err ERR"
eval "$cmd_trap"


breaking(){


    local str0=`caller`
    local str="gvim +$str0"
    echo "goto : $str"

    proxy print_color 31 'breaking'
    echo breaking
    break
}

trap_err(){
    echo "[trap_err] $0"
    # local num=1
    #  echo "${BASH_SOURCE[$num]}"


    echo "bash_source.length: ${#BASH_SOURCE[@]}"

    echo "${BASH_SOURCE[@]}" >/tmp/bash_source
    echo "${BASH_LINENO[@]}" >/tmp/bash_lineno
    # cat -n /tmp/bash_source
    #  cat -n /tmp/bash_source
    pr -m -t /tmp/bash_source /tmp/bash_lineno
echo     http://www.commandlinefu.com/commands/using/pr



    if [ "$CRAZY_CHASE" = true ];then
        notify-send "trap_err"
        local cmd=$( gxmessage -entrytext "$str" -file /tmp/err -title "trap_err: $0 " )
        if [ -n "$cmd" ];then
            echo "[cmd] $cmd"
            proxy sleep 3
            eval "$cmd"
        fi
    fi

    echo no-gui
    cat -n /tmp/proxy | tail -5
    echo
    cat -n /tmp/err

    go_home
}



single(){
    local dir_self=`dirname $0`
    local input="$input"
    if [ -n "$input" ];then
        local file="$dir_self/wrapper.sh"
        #zbab
        if [ -f "$file" ];then
            # local cmd="proxy \"$cmd_trap\" &&
                {        \
#                    proxy "$cmd_trap"; \
                    local cmd="bash -xc  \"$file $input\""; \ 
        }
        echo "[ try ] $cmd"
        proxy sleep 4
        eval "$cmd"
    else
        echo 'no such file ' "$file"
    fi
else
    echo no input
    breaking

fi





}


loop(){
    #zbab1
    local counter_death=0
    while [ 1 ];do
        local cmd="set -o nounset"
        proxy "every 5 \"$cmd\""
        proxy "cowsay \"new life: $counter_death\""
        #local   cmd="./wrapper.sh bin/1_tasker/tasker.sh"

        #    gxmessage -title "died young: $counter_death" -file /tmp/err -timeout 5
        single
cowsay "counter  death: $counter_death"
        proxy sleep 2
        let 'counter_death+=1'
    done
}


steps(){
    eval "$cmd_trap"
    loop 
}
args=( $@ )
input="${args[@]}"
steps 
