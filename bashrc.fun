# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#source $dir_root/cfg/general/color/color.cfg
export EDITOR="vim"

#export dir_root=~/JAIL/do_for_others_first
#alias bashrc="vi ~/.bashrc"
alias bashrc="vi $dir_root/bashrc.fun"
alias keyrc="vi $dir_root/1/hotkeys.sh/hotkeys.txt"
alias vimrc="vi ~/.vimrc"
set -o vi



add(){
    clear
    filename="$1"
    shift
    title="$1"
    shift
    content="$@"

    local file="$filename.txt"
    touch $file
    if [ -f "$filename" ];then

        if [ "$title" ];then
            echo "$title" >>  $file
            if [ "$content" ];then

                echo "$content" >> $file
            fi

            echo "" >> $file
        else
            echo "no title"
        fi

        echo "Added successfuly!"
        echo "file: $file" 
        #       cat $file | grep "$content"
        cat $file 
    else
        echo '-------------------------'
        green "Help:"
        blue "arguments: filename, title, content"
        green 'printing *.txt :'
        echo '-------------------------'
        cat *.txt
    fi
}
move(){
    echo 'help: move file to projcect/src/subject/gist.sh'
    file="$1"
    subject="$2"
    if [ "$subject" ] && [ -f "$file" ] ;then
        mv $file $dir_root/2/ask.sh/src/subject/
    fi
}
export -f move
# pretty printing functions
# This allows us to get the name of the functionw where this function was called
# http://stackoverflow.com/questions/7650438/bash-funcname-value-expanding
#http://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

#export PATH=$PATH:~/JAIL/deb.sh/

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
clip(){
    echo "$@" | xsel --clipboard
}
replace(){
    exclude_dir='.git'
    path=. 
    old_string="$1"
    new_string="$2"

    cmd="grep --exclude-dir=$exclude_dir -rl '$old_string' $path | xargs sed -i s@$old_string@$new_string@g"

    echo "$cmd"
    echo 'execute?'

    read answer
    if [ "$answer" = y ];then
        echo 'evaluating..'
        eval "$cmd"
        echo 'Results:'
        grep --exclude-dir=$exclude_dir -r $new_string $path 
    fi
}

hotkeys(){
    #xfce desktop:
    xfconf-query -c xfce4-keyboard-shortcuts -p /commands/default/XF86Display -s 'test'
    xfconf-query -c xfce4-keyboard-shortcuts -l
    
    cmd="$1"
    echo "$1"
    xfce4-settings-manager
}
finder(){

    str="$1"
    path="${2-.}"
    echo "search string: $str"
    cmd="grep  --exclude-dir=.git $str $path -r"
    echo "$cmd"
    eval "$cmd"
}
alias udebug='set +x'
alias debug='set -x'


export -f clip


save(){
    cmd="history 2 | head -1 | sed 's/^ [0-9]*//g' "
    line=`eval "$cmd"`


    echo "$line" | grep 'vi ' -m1 >> .history.edit || \
    echo "$line" | grep 'robot' -m1 >> .history.robot || \
        echo "$line" | grep 'http' -m1 >> .history.url || \
        echo "$line" | grep '.sh' -m1 >> .history.run  || \
        echo "$line" | grep 'http ' -m1 >> .history


}
save1(){
    if [ $# -eq 1 ];then
        subject="$1"

        file="$dir_root/.tmp/$subject.txt"
        touch $file
        cmd="history 2 | head -1 | sed 's/^ [0-9]*//g' "
        line=`eval "$cmd"`
        echo -e "Add this line?\n "
        echo -e "line: $line"
        read
        cmd="echo "$line" | tee -a .history $file ; echo \"File: $filer\";echo '-----' ;cat $file;"
        eval "$cmd"
        show "$subject"
    else
        subject=$1
        shift
        cmd="$@"
        file="$dir_root/.tmp/$subject.txt"

        echo "$cmd" >> $file
        echo "updated File: $file"
        cat $file
        confirm
        eval "$cmd"

    fi
}
last(){
    clear
    if [ $# -eq 0 ];then
        echo 'supply a subject'
    else
        subject="$1"
        file="$dir_root/.tmp/$subject.txt"
        cmd="cat $file | tail -1"
        line=`eval "$cmd"`
        echo -e "Execute command?\n $line" 
        #| xsel --clipboard
        confirm
        eval "$line"
    fi

}
menu(){


    if [ $# -eq 1 ];then
        dumpfile="$1"
        while [[ 1 ]]
        do
            cat -n "$dumpfile"
            read -p "Please make a selection, select q to quit: " choice
            case $choice in
                # Check for digits
                [0-9] )   dtvariable=$(sed -n "$choice"p "$dumpfile")
                $dtvariable            ;;
            q|Q)
                break
                ;;
            *)
                echo "Invalid choice"
                ;;
        esac
    done
else 

    echo Dynamic menu generator
    echo 'please supply a file'
fi
}
show(){
    if [ $# -eq 0 ];then
        echo 'supply a subject'
    else
        subject="$1"
        file="$dir_root/.tmp/$subject.txt"
        echo "$file"
        cat $file
    fi

}



alias question='cd $dir_root/src/0/ask.sh/QUESTION/src'
tree1(){
    tree > /tmp/tree.txt
    cat /tmp/tree.txt
    echo 'create new file? .tree ?'
    read answer
    if [ "$answer" = y ];then
        cat /tmp/tree.txt >> .tree
    fi
}
confirm(){
    echo
    echo
    echo Press Y to continue
    read answer
    if [ "$answer" != y ];then
        exit
    fi

}
query(){
    echo "Let's Surf the Web!"
    cd $dir_root
    relative_sh="src/0/ask.sh/ask.sh"
    ./wrapper.sh $relative_sh  "$1"
}
shortcut(){
    local dir=`pwd`
    cd ~/Desktop/
    ln -s $dir .
}
history1(){
    amount=20
    if [ $# -eq 1 ];then
    str="$1"
results=$(    history $amount | grep "$str" )
echo "$result"
else
    echo Please supply a subject 
    echo I will grep the last $amount history commands for you..
fi

}
alias project="cd $dir_root"
export -f shortcut
export -f query
export -f confirm
export -f tree1

export -f save
export -f show
export -f last

export -f rm
export -f rmdir
export -f lesser


export -f add
export -f finder

export -f replace 

export -f menu 
export -f history1 
#alias finder='echo grep -r \$file \$dir'
