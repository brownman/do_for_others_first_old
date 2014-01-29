# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything

export EDITOR="vim"

export dir_project=~/JAIL/do_for_others_first
#alias bashrc="vi ~/.bashrc"
alias bashrc="vi $dir_project/bashrc.fun"
alias keyrc="vi $dir_project/1/hotkeys.sh/hotkeys.txt"
alias vimrc="vi ~/.vimrc"
set -o vi

alias save="history 2 | head -1 | sed 's/^ [0-9]*//g' |  tee -a .history ~/JAIL/save.txt; cat ~/JAIL/save.txt; clear; echo .history:; cat .history;"

move(){
    echo 'help: move file to projcect/src/subject/gist.sh'
    file="$1"
    subject="$2"
    if [ "$subject" ] && [ -f "$file" ] ;then
        mv $file $dir_project/2/ask.sh/src/subject/
    fi
}
export -f move
# pretty printing functions
# This allows us to get the name of the functionw where this function was called
# http://stackoverflow.com/questions/7650438/bash-funcname-value-expanding
#http://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

#export PATH=$PATH:~/JAIL/deb.sh/
export dir_project=~/JAIL/do_for_others_first
rm(){
    echo 'rm()'
    str=`basename "$1"`
    mv -f "$1" ~/.Trash
    ls ~/.Trash/$str
}
rmdir(){
    echo 'rmdir()'
    str=`basename "$1"`
    mv -i "$1" ~/.Trash
    ls ~/.Trash/$str
}


#export dir_cfg=~/JAIL/pilot.sh/cfg
lesser(){
    file=$1
    if [ -f $file ];then
        cat $file | less
    fi
}
alias question='cd $dir_project/2/ask.sh/src'
export -f rm
export -f rmdir
export -f lesser
