#info: file server
#pending: combine with proxy.sh
#imagine: register every request
#dir_self=`dirname $0`


#( ls $dir_self/$item 1>/dev/null 2>/dev/null )
update_proxy_workspace(){
    file_update /tmp/proxy_workspace "$@"
}
update_proxy_workspace "$@"
cat -n /tmp/proxy_worspace
proxy sleep 4
type="$1"
location="$2"
str_assert="${type}_exist"
assert $str_assert $location
