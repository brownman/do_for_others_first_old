shortcut(){
    local dir=`pwd`
    cd ~/Desktop/
    ln -s $dir .
}



tree1(){
    tree > /tmp/tree.txt
    cat /tmp/tree.txt
    echo 'create new file? .tree ?'
    read answer
    if [ "$answer" = y ];then
        cat /tmp/tree.txt >> .tree
    fi
}


export -f shortcut
export -f tree1
export -f rm
export -f rmdir

