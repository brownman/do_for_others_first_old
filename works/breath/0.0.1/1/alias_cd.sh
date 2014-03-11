
list1=` cat exports.cfg  | grep export | tr -s ' ' | cut -d' ' -f3 | cut -d'=' -f1`
list2=` cat exports.cfg  | grep export | tr -s ' ' | cut -d' ' -f3 | cut -d'=' -f2`

arr1=( $list1 )
arr2=( $list2 )

max="${#arr1[@]}"


echo "After @ quoted expansion: ${#arr1[*]}"
for ix in ${!arr1[*]}
do

        item="${arr1[$ix]}"
#        printf "cd%s\n" "$item"
item_content=`eval echo "\$$item"`
echo -n "$item :"
echo "$item_content"

    done
