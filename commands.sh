str=${1:-'search_for_this_word'}
file_target=${2:-$dir_root/1_require_min/SPLIT_ME/helper.cfg}

view_source(){

grep -r "$str" "$file_target"
grep -rl "$str" "$file_target"
source "$file_target"
type "$str"

}

steps(){
view_source "$str"
}



steps
