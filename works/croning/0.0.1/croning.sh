#!/bin/bash 
set -o nounset
pushd `dirname $0` >/dev/null
str="croning is alive"
path=`dirname  $0`

speak(){
    str="$1"
/usr/bin/flite -t "$str"
}
say(){
    str="$1"
    /usr/games/xcowsay "$str"
    /usr/bin/notify-send "$str"
}

if [ $# -gt 0 ];then
    num=$1
#    say "got $num"

   # /usr/bin/notify-send "$num"
    line=`cat $path/list.txt | head -$num | tail -1`

    str=`echo "$line" | sed 's/ /_/g'`
    #res=$(    gxmessage -entrytext "$line" -title croning )
    notify-send "$str"
    say "$line"
    cmd="$line"
    echo "$cmd"
    eval "$cmd"
else
    /usr/bin/notify-send 'no args'
fi

popd>/dev/null
