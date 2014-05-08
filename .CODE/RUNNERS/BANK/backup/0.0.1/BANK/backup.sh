#info: backup the proxy 
#details: watch if any progress has been made - if not : advice to go to google, etc
backup_proxy(){
    echo "[BACKUP PROXY]"

    #local cmd="cowsay \"$msg\""
    #eval "$cmd"
    file=/tmp/proxy
    file_old=/tmp/proxy.old

    if [ -f  $file ];then
        if [ -f  $file_old ];then
            cmp $file $file_old
            local    res=$? 
            if [ $res -eq 1 ];then
                echo  you made some progress
                echo making a backup..
                mv $file $file_old
            else 


                echo files are identical

                present toilet "write a test or run breath as script"

                #go_home
                proxy sleep 4
            fi
        else
            mv $file $file_old
        fi
        proxy sleep 2
    else
        echo 'file not found: ' "$file"
    fi
    proxy sleep 3
}


steps(){
    backup_proxy
}

steps
