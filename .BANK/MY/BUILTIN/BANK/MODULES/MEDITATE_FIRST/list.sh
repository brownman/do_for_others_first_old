#info:  mind the big stones first
#reason: imagine before doing anything
#depend_package: pv xcowsay

set +e
#set -x
set -o nounset
random(){
    local num=$1
    let "r=$RANDOM % $num"
    return $r
}
random_line(){
    local file=$1
    if [ -f "$file" ];then
        local max=`cat $file | wc -l`
        random $max
        local res=$?
        local str=$( cat $file | tail -${res} | head -1 )
        echo $str
    else
        echo "[error] not a file" "$file"
    fi
}
print_color () 
{ 
    echo -e "\x1B[01;$1m[*]\x1B[0m $2 "
}
print_color_n () 
{ 
    echo -en "\x1B[01;$1m[*]\x1B[0m $2 "
}


pv1(){
    echo "$@" | pv -qL 10
}
set_env(){
    dir_self=`dirname $0`
    file_language=$dir_self/languages.txt
    file_robot=$dir_self/robot.txt
}
install_depend(){
    local str=$( cat $0 | grep "#depend_package" -m1 | sed 's/#depend_package//g' )
    for item in $str;do
        dpkg -S $item &>/dev/null || { echo >&2 "[X] sudo apt-get install $item";exit 0; }
    done

}
translate_it(){
local     lang=$1
local     str="$2"
 local   cmd="$dir_self/bin/translate.sh $lang $str"
#    echo "[cmd] $cmd"
    eval "$cmd"
}
say_something(){
    clear
    echo 'speak recognition'
}

are_you_a_chicken(){
    local str=$( random_line $file_robot )
    local line=''
    if [ -n "$str" ];then
        while read lang;do
            if [ -n "$lang" ];then
                translate_it $lang "$str"
            else 
                echo "[error] empty line on file " "$file_language"
            fi
        done < $file_language
    else 
        echo "[Error] empty string" "$str"
    fi
}
loop(){


    local str1=''
    local str2=''
    local counter=32
    while read line;do
        if [ -n "$line" ];then
            str1=`   echo $line | cut -d'|' -f1`
            str2=`   echo $line | cut -d'|' -f2`
            print_color_n $counter "$str2"
            pv1 "$str1"
            echo
            echo
            cat $dir_self/BANK/$str2
            sleep 1
            clear
        else
            echo "-The End-"
            break
        fi
        let 'counter += 1'
    done<$dir_self/list.txt
}
steps(){
    clear
    set_env
    install_depend

            are_you_a_chicken
            say_something
    loop
}

steps
