every 2 "set -x"

every 2 "set -u"
every 2 "set -e"
proxy  print_color 4 hi
sleep 3
step1(){
    local file=$dir_root/0/first.cfg  
    echo Running In A sub-shell - saving time
    source $file  ; 
    res=$?
    if [ $res -eq 0 ];then
        proxy print_color 32 PASS
        echo "source $file" | xsel --clipboard
    else
        proxy print_color 31 FAIL
        echo "vi $file" | xsel --clipboard
    fi
    echo "[clipboard updated]"
    #echo "res: $?" ; echo now source yourself; 
}
step2(){
    proxy update_clipboard "source $file";  
}

sub_shell(){
#    echo "$( step1 )"
    step1
}

reminder(){
    cat -n $dir_root/plan.txt | head -2
    sleep 3
    #| xargs echo
}

steps(){
    #    dir_self=`dirname $0`
    reminder
    sub_shell
}
steps
