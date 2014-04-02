#str='method'
#pushd `dirname $0` > /dev/null
#cd pre../public
dir2=/TORRENTS/CODE/abs-guide-6.5
dir=../../1/testing/python2/koans
newer=recent_koan.py



step1_old(){
#local str="$1"
ans1=$(gxmessage "grep for:" -entry)
#echo "$ans1"
res=$(ls -1 $dir | grep "$ans1")
#echo "$res"
ans=$(gxmessage "$res" -entrytext "$ans1" )
echo "$ans"
}
step1(){
local ans=$(list_dir $dir true) #true-use grep
echo "$ans"
}

step2(){
local str="$1"
ln -sf $dir/$str $newer
ls -l $newer
cat $newer | head -10
}

do_koan(){

ans1=$(step1)
#ans1=$(step1_old)
echo "creating symlink for: $ans1"
sleep 3
step2 "$ans1"
}

do_run_all(){
xterm -e ./prespective/scripts/timer.sh & 
sleep1 5
xterm -e ./prespective/scripts/ensure_suspension.sh &
sleep1 5
xterm -e ./prespective/scripts/ensure_higher_self.sh & 
}

do_upload(){
cd prespective/public
export TIMERTXT_CFG_FILE=$PWD/cfg/user.cfg
. $TIMERTXT_CFG_FILE

export DEBUG=true 
export file1=$CFG_DIR/blank.yaml
export file2=$CFG_DIR/txt/assosiation.txt

upload $file1
upload $file2
}

upload(){
    local file="$1"
    local cmd=$( echo "$PLUGINS_DIR/blogger.sh $file" )
    commander "$cmd"
}

$1 "$2"
#popd > /dev/null
