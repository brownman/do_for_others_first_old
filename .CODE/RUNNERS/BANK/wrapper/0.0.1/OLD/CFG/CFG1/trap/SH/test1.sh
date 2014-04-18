#set -e
#2>/tmp/err
trap_err(){
    local res=$?
    echo "[TRAP] $res"
    local caller=`caller`
    echo "[caller] $caller"
    if [ -s /tmp/err ];then
        cat /tmp/err
    else
        echo 'run the script using the tool: debug'    
    fi
    return $res
}


trap trap_err ERR
bla bla
test1(){
    
    sdf
[    $? -ne 0 ] && { echo 'dont trap it';return 0; }
}

steps(){

    rm /tmp/err
    test1 2>/tmp/err
    #test1
}

steps
