#reason: update /tmp/suspend.sh  for cron jobs
#advice: if you want to watch a lecture - and it is only get farther away from you - put it just after the suspension
#set -o nounset
reset



intro(){
    local  str=$( cat $0 | grep reason  -m 1 )
    echo "$str"
}


step1(){
    local dir=`pwd`
    #dir=where_am_i $0`
    local file=$dir/good/suspend_trap.sh 

        echo [check] if file /tmp/suspend.sh exist 
    ls /tmp/suspend.sh 1>/dev/null 2>/dev/null
    local res=$?
    if [ $res -eq 0 ];then
        echo [check] comparing /tmp/suspend.sh against the newer version:
        ( cmp $file /tmp/suspend.sh  )
        res=$?
    fi

    if [ $res -ne 0 ];then
        echo [ updating ] the file used to suspension
        [ -f /tmp/suspend.sh ] && { mv /tmp/suspend.sh /tmp/suspend.sh.1; }
        ln -sf  $file /tmp/suspend.sh
        ls /tmp/suspend.sh
        ls $file

    echo [  DONE!  ]
    else
        echo [OK] the 2 files are the same
    fi


}


steps(){
    export -f intro
    intro
    step1

}
steps
