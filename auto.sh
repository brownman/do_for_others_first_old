str=`export | grep dir_ | cut -d' ' -f3 | cut -d'=' -f1`
arr=( "$str"  )
for_each_element 'echo cd'
