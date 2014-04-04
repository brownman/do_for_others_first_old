
#http://unix.stackexchange.com/questions/18811/how-to-obtain-inverse-behavior-for-tail-and-head

clear
source_and_type(){
    local file=$1
    local func=$2
    ( source "$file"; \
        echo '-----';type "$func" | tail -n +2  2>&1 ) 
}
export -f source_and_type
set -o nounset
echo '[HELP] supply: func | dir | filename'

delay=0
func=${1:-print_script}
dir=${2:-$dir_root}
file_name="${3:-''}"
echo "func: $func"
echo "dir: $dir"
echo "file_name: $file_name"
echo

echo start to scan in $delay seconds
sleep $delay


cmd="grep --exclude-dir='.git' -lr \"${func}()\" $dir | grep $file_name"
echo "$cmd"
echo '---'
echo "[ RESULTS ] "
eval "$cmd" > /tmp/res 
cat -n /tmp/res
sleep 2
while read line;do
    source_and_type "$line" "$func"
done</tmp/res


#| xargs ls | xargs source 
#&& type $func
#type $func"


#found: /home/dao04/JAIL/TREE/BANK/CFG/REGULAR/.old/PRE-LIB/SPLIT_ME/helper.cfg

