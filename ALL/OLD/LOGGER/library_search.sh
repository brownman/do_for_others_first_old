str_target=${1:-'search_for_this_word'}
file_target=${2:-$dir_root/1_require_min/SPLIT_ME/helper.cfg}
dir_target=${3:-$dir_root}
search_project(){
    local  dir_target="$dir_library"
#grep -r "$str\(" "$dir_target"

grep -rl $str\( "$dir_target" --exclude-dir='.git'

}
view_source(){

source "$file_target"
type "$str"

}

steps(){
proxy clear
    cmd="print_color_n 32 '[SEARCHING FUNCTION] '"


    proxy "$cmd"

    proxy "echo $str_target"
    echo
echo -en "[SEARCH PROJECT AT DIR] "
echo "$dir_target"
search_project "$str"
echo
echo -en "[CHECK IF FUNC EXIST IN FILE .cfg]  "
echo "$file_target"
view_source "$str"
}


if [ $# -gt 0 ];then
    str="$1"
steps
else
echo 'supply a funcname to search'
fi

#grep1 -r reason_of_death\( 
