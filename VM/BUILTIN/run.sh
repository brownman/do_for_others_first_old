step01(){
#local dir_self=`dirname $0`
local dir_self=`where_am_i`
echo "[dir_self] $dir_self"
local file=$dir_self/SETUP/list.sh
local  cmd="bash -c $file"
echo "[cmd] $cmd"
eval "$cmd"

#echo "[dir_self] $dir_self"
#sleep 1
#$dir_self/SETUP/BANK/REMINDER/list.sh


}
step01
