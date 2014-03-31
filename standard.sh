expose_script(){
    cat $file_target | grep $tag
}

expose_func(){
    #cat $file_target | grep $tag

    local cmd="coverage $file"
    proxy "$cmd"

}


cover(){
    #depand_var: file_target

    type=$1
    tag=$1
    if [ "$type" =  'script' ];then
        expose_script "$tag" 
    else
        expose_func "$tag"
    fi
}


steps(){
    cover script title
    cover script desc
    cover script use

#    cover script test
}


if [ $# -gt 0 ];then
    file_target="$1"
else
    echo 'supply a file to scan'
fi


steps
