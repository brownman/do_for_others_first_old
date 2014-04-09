str=$( cat commands.txt | head -1 )

echo $str
eval "$str"

echo $str
