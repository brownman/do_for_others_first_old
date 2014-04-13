#./wrapper.sh singles/single.sh awake $1

reset
print_mode(){
    local num=$1
echo   "PRESENTATION MODE IS..."
    echo "$num"
    proxy sleep 1
}

steps(){

    dir_self=`dirname $0`
    local str=$dir_self/bin/1_tasker/tasker.sh
    local file=''
    local cmd=''
    echo 'how do you want to handle an Error?'
    echo '1) trap'
    echo '2) forgive'
    read answer 
answer=${answer:-0}
    print_mode $answer

    case "$answer" in
    1)
        file="$dir_self/chase_the_problem.sh"
    ;;
2)
    file="$dir_self/loop_fallback_for_easy_life.sh"
    ;;
    *)
    file="$dir_self/wrapper.sh"
    ;;
    esac

cmd="$file $str"
confirm "$cmd"
#    proxy "$cmd"

}
steps
