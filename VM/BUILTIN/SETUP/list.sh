pushd `dirname $0` >/dev/null
while read line;do
    echo "[line] $line"
    item1=`echo $line | cut -d':' -f1`
    item2=`echo $line | cut -d':' -f2`
    cmd="every $item1 \"$item2\""
    echo "[cmd] $cmd"
    eval "$cmd"
done <list.txt
popd >/dev/null
