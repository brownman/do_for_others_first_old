path=`dirname $0`
shopt -s expand_aliases

file=$path/alias_cd_dynamic.cfg
echo -n '' > $file


list1=` cat exports.cfg |grep dir_ | grep export | tr -s ' ' | cut -d' ' -f3 | cut -d'=' -f1 `

#list2=` cat exports.cfg |grep dir_ | grep export | tr -s ' ' | cut -d' ' -f3 | cut -d'=' -f2`

arr1=( $list1 )
#arr2=( $list2 )

max="${#arr1[@]}"


echo "After @ quoted expansion: ${#arr1[*]}"
for ix in ${!arr1[*]}
do



    item="${arr1[$ix]}"
col2=`echo "$item" `
col1=`echo "$item" | sed 's/dir_//g'`

    #        printf "cd%s\n" "$item"
    #item_content=`eval echo "\$$item"`
    #echo -n "$item :"
    echo "alias cd_$col1=\"cd \$$col2\"" >> $file

done
echo $file
cat $file
source $file
