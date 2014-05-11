file_self=${BASH_SOURCE:-$0}
export dir_root=`dirname $file_self`
num=${1:-3}
dir=${2:-$dir_root/.BANK/MY}
tree $dir -L $num
