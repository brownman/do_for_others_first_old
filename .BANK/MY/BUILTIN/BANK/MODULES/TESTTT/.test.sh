dir_self=`dirname $0`
files=`ls $dir_self/*.sh`
echo $files
echo "bash -e $dir_self/list.sh"
file_self=`where_am_i $0`
update_clipboard "vi $file_self/.test.sh"
