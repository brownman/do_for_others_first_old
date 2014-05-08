dir_self=`dirname $0`
file_list=$dir_self/url.txt
while read line;do
exo-open  $line
done<$file_list
