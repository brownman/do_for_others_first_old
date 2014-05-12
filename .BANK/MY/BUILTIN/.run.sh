set -e
step01(){
#local dir_self=`dirname $0`
local dir_self=`where_am_i $0`
#echo "[dir_self] $dir_self"
local file=$dir_self/BANK/SETUP/list.sh
local  cmd="$file"
#echo "[cmd] $cmd"
eval "$cmd"

#echo "[dir_self] $dir_self"
#sleep 1
#$dir_self/SETUP/BANK/REMINDER/list.sh


}
step01
