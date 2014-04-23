#info: file server
#pending: combine with proxy.sh
#imagine: register every request
dir_self=`dirname $0`
file=$1
if [ -f $file ];then
    echo "$file" 
else
    str_caller=`caller`
    proxy update_clipboard "gvim +${str_caller}"
    echo "error - file not found" "$file"
    go_home
fi
