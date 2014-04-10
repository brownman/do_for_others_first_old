#reason: if you want to watch a lecture - and it is only get farther away from you - put it just after the suspension
set -o nounset



intro(){
local  str=$( selfish_script reason )
present pv "$str"
}


step1(){

file=$1
( cmp good/suspend_trap.sh  /tmp/suspend.sh )
res=$?
if [ $res -eq 1 ];then
    echo updating the file used to suspension
ln -s  $file /tmp/suspend.sh
ls /tmp/suspend.sh
else
    echo the 2 files are already the same
fi

echo DONE
}


steps(){
export -f intro
intro
step1

}
steps
