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


lesser(){
    file=$1
    if [ -f $file ];then
        cat $file | less
    fi
}
finder(){

    str="$1"
    path="${2-.}"
    echo "search string: $str"
    cmd="grep  --exclude-dir=.git $str $path -r"
    echo "$cmd"
    eval "$cmd"
}

export -f finder
export -f lesser
export -f replace 

