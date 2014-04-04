0_set_env(){
dir_library=~/JAIL/TREE/BANK/TOOLS/BANK/library
script=./gmail-group/script.sh
func=$( cat /tmp/func 2>/dev/null )
}

1_next_missing_func(){
str0=$( eval "$script" 1>/dev/null 2>/tmp/err || cat /tmp/err | cut -d':' -f3 ) 
func=$(echo "$str0" | sed -e 's/^ *//g' -e 's/ *$//g');
echo -n $func > /tmp/func
}

2_find_func(){
    local  str=$func
#| xargs echo )
echo "looking for function: _${str}_"
sleep 6
cmd="$dir_library/0_search_from_root.sh $str"
echo "$cmd"
sleep 2
eval "$cmd"
}

3_overrite_file(){
    files=$( ls /tmp/$func)
    for file in $files;do
        ls $file
    done
}



if [  $# -gt 0 ];then
cmd=$1
echo "[ $cmd ]"
sleep 1 
eval "$cmd"
else
    echo which step do you want to run?
    cat $BASH_SOURCE | grep "(){" | grep -v grep | sed 's/(){//g'
fi

