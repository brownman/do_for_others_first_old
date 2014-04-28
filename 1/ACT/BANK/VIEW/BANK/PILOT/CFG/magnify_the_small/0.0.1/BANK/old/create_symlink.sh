#str='method'
#pushd `dirname $0` > /dev/null
#cd pre../public





#1/testing/python2/koans
#newer=recent_koan.py

do_random(){

dir=/TORRENTS/CODE/abs-guide-6.5
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
#do_koan
#popd > /dev/null
