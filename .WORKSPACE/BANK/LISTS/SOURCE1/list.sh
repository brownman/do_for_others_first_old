#depand_vars: dir_root
sourcing(){
    local file=$1
    source $file
}
aliasing_file(){
    local file=$1
    filename=`basename $file | cut -d'.' -f1`
    echo -e "\t\t [ $filename ] "
    cmd="alias ${filename}E='vi $file'"
    eval "$cmd"
    cmd="alias ${filename}S='source $file'"
    eval "$cmd"
}

aliasing_dir(){
    local dir=$1
    dirname=`basename $dir`
    cmd="alias cd_${dirname}='cd $dir'"
    eval "$cmd"
    echo -e "\t [ $dirname ]"
}



clear
shopt -s expand_aliases
file_runner=${BASH_SOURCE:-$0}
alias source1="vi $file_runner"

dir_self=`where_am_i $file_runner`
dir_prefix=$dir_root/.CODE
file_list=$dir_self/list.txt



eat(){
    local dir=$1
    files=`ls  $dir/BANK/*.cfg`

    aliasing_dir $dir
    for file in $files;do
        aliasing_file $file
        sourcing $file
    done

}


while read line;do
    echo -n "[ $line ] "
    dir="$dir_prefix/$line"
    #echo "[dir] $dir"
    #tree $dir
    eat $dir
done<$file_list
