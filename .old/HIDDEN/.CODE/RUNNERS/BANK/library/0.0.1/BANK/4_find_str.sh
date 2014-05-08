#info: search a str from root dir
#http://unix.stackexchange.com/questions/18811/how-to-obtain-inverse-behavior-for-tail-and-head
set -o nounset
clear
echo '[HELP] supply: str | dir | filename'
counter=0

source_and_type(){
#set -x
    local file=$1
    local str=$2
    local file_new=/tmp/${str}.cfg.${counter}  
#set +x
    ( source "$file"; \
        echo -e "\n\n\t\t\t----[ $file_new ]----"; \
        type "$str" | tail -n +2 | tee $file_new \
     ) 
    sleep 5
}
#export -f source_and_type
step1(){

#

local     str=$1
   local  dir=${2:-$dir_root}
   local  file_name="${3:-''}"

    local delay=0
    echo "str: _${str}_"
    echo "dir: $dir"
    echo "file_name: $file_name"
    echo

    echo start to scan in $delay seconds
    sleep $delay


   local  cmd="grep --exclude-dir='.git' -lr \"${str}\" $dir | grep $file_name"
    echo "$cmd"
    echo '---'
    echo "[ RESULTS ] "
    eval "$cmd" > /tmp/res 
    cat -n /tmp/res
    sleep 2
    counter=1
    while read line;do
        echo "[ $counter ]"
#echo         source_and_type "$line" "$str" 
        let 'counter += 1'
    done</tmp/res


}
if [ $# -gt 0 ];then
str=$1
step1 $str
else
    echo '[ERROR] supply a string name to search for'
fi
#| xargs ls | xargs source 
#&& type $str
#type $str"


#found: /home/dao04/JAIL/TREE/BANK/CFG/REGULAR/.old/PRE-LIB/SPLIT_ME/helper.cfg

