rm(){
    echo 'rm()'
    str=`basename "$1"`
    mv -f "$1" ~/.Trash
    ls ~/.Trash/$str
}
rmdir(){
    echo 'rmdir()'
    str=`basename "$1"`
    mv -i "$1" ~/.Trash
    ls ~/.Trash/$str
}


