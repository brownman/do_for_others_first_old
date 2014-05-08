pushd `dirname $0` >/dev/null
while read line;do
    echo "[line] $line"
    eval "$line"
done <list.txt
popd >/dev/null
