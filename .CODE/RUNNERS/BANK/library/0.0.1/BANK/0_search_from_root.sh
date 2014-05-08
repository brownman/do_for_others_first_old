#info: search a func from root dir
#http://unix.stackexchange.com/questions/18811/how-to-obtain-inverse-behavior-for-tail-and-head
set -o nounset
clear
echo '[HELP] supply: func | dir | filename'
counter=0

source_and_type(){
#set -x
    local file=$1
    local func=$2
    local file_new=/tmp/${func}.cfg.${counter}  
#set +x
    ( source "$file"; \
        echo -e "\n\n\t\t\t----[ $file_new ]----"; \
        type "$func" | tail -n +2 | tee $file_new \
     ) 
    sleep 5
}
#export -f source_and_type
step1(){



local     func=$1
   local  dir=${2:-$PWD}
   local  file_name="${3:-''}"

    local delay=0
    echo "func: _${func}_"
    echo "dir: $dir"
    echo "file_name: $file_name"
    echo

    echo start to scan in $delay seconds
    sleep $delay


   local  cmd="grep --exclude-dir='.git' -lr \"${func}()\" $dir | grep $file_name"
    echo "$cmd"
    echo '---'
    echo "[ RESULTS ] "
    eval "$cmd" > /tmp/res 
    cat -n /tmp/res
    sleep 2
    counter=1
    while read line;do
        echo "[ $counter ]"
        source_and_type "$line" "$func" 
        let 'counter += 1'
    done</tmp/res


}
if [ $# -gt 0 ];then
func=$1
step1 $func
else
    echo '[ERROR] supply a function name to search for'
fi
#| xargs ls | xargs source 
#&& type $func
#type $func"


#found: /home/dao04/JAIL/TREE/BANK/CFG/REGULAR/.old/PRE-LIB/SPLIT_ME/helper.cfg

