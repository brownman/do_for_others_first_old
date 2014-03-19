#!/bin/bash  -e
set -o nounset
pushd `dirname $0` >/dev/null
str="croning is alive"
path=`dirname  $0`
update_clipboard(){
    notify-send 'update the clipboard' 'croning.sh'
echo "$1" | /usr/bin/xsel --clipboard
}
speak(){
    str="$1"
    /usr/bin/flite -t "$str"
}
say(){
    str="$1"
    /usr/games/xcowsay "$num : $str"
    flite -t "$str"
    /usr/bin/notify-send "$num : $str"
}
run(){
    cmd1="vi $0"
    update_clipboard "$cmd1"
    line=`cat $path/list.txt | head -$num | tail -1`
    notify-send "croning: $num" "$line"
    desc=`echo "$line" | cut -d'|' -f1`
    cmd=`echo "$line" | cut -d'|' -f2`
    #    str=`echo "$line" | sed 's/ /_/g'`
    #res=$(    gxmessage -entrytext "$line" -title croning )
    notify-send "$desc"
    say "$desc"
    echo "$cmd"
    eval "$cmd"

}
if [ $# -gt 0 ];then
    num=$1

    run
else
    /usr/bin/notify-send 'no args'
fi


popd>/dev/null
