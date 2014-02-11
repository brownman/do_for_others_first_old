required(){


    local cmd="$1"
    if [ $# -gt 1 ];then
        shift
        local pkg="$@"
    else
        #Assume: package name identical to the execution file
        local pkg="$cmd"
    fi


    #type $1 >/dev/null 2>&1 || { echo >&2 "in order to run: $cmd: please install package: $@ "; exit 1; }
    #idea: write it in other color
    type $cmd >/dev/null 2>&1 || { echo -e >&2 "$pkg" >> $file ;let 'result += 1'; }
    #|| { echo >&2 "required package: $pkg"; exit 1; }
}




####################
test_dependencies(){

file=/tmp/dependencies.txt
let    'result=0'
echo -n '' > $file 



install_dependencies_cli
install_dependencies_gui
install_dependencies_sound
if [ $result -ne 0 ];then
print_hint "please install the following $result packages:"
echo
    cat $file
    print_hint 'and try again'
    exiting
fi
assertEqual $result 0
}

install_dependencies_cli(){

    required bash bash
    required pstree pstree
    required vim vim
    required xsel xsel
    required flite flite
    required gmail-notify
}

install_dependencies_gui(){

    #libnotify1
    if [ "$EDITOR" = 'gvim' ];then
    required gvim vim-gnome
fi
    
    required notify-send libnotify-bin
    required gxmessage gxmessage
    required xcowsay xcowsay
    required zenity zenity
}
install_dependencies_sound(){
    required flite flite
#    required mpg321 mpg321
    required play sox libsox-fmt-all
}

pending_static_files(){
#libsox-fmt-mp3: 
#dpkg -S sox
file=/usr/lib/sox/libsox_fmt_mp3.so
if [ ! -f "$file" ];then
    echo install it
    required 'sox_mp3_something' libsox-fmt-all
else
assertEqual 1 1
fi

}


