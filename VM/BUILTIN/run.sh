step01(){
#local dir_self=`dirname $0`
local dir_self=`where_am_i`
echo "[dir_self] $dir_self"
$dir_self/SETUP/list.sh

echo "[dir_self] $dir_self"
sleep 1
$dir_self/SETUP/REMIND_DO_FOR_OTHERS_FIRST/list.sh


}
step01
