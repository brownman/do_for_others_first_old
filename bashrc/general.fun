alias spell='aspell -a'
export EDITOR="vim"

#set -o vi


# pretty printing functions
# This allows us to get the name of the functionw where this function was called
# http://stackoverflow.com/questions/7650438/bash-funcname-value-expanding
#http://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

#export PATH=$PATH:~/JAIL/deb.sh/

#export dir_cfg=~/JAIL/pilot.sh/cfg



confirm(){


    if [ $# -gt 0 ];then
        cmd="$@"
        echo "cmd: $cmd"
        echo
        /usr/bin/flite -t 'confirm' &
    fi

    echo Press Y to continue
    read answer
    if [ "$answer" != y ];then
        exit
    fi


}
clip(){
    echo "$@" | xsel --clipboard
}

export -f clip
export -f confirm


#project

#alias finder='echo grep -r \$file \$dir'

