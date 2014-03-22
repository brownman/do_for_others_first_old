

notify_send "homework" "$0"

#${1:-'essay_generator|story_a_day|funny'}
#subject="$1"
delay=5
file_locker=/tmp/homework


run(){
    local dir=$DATA_DIR/homework/linux-edu
local res=$(pick_file "$dir" )
xdg-open "$res"
}
unlocker
