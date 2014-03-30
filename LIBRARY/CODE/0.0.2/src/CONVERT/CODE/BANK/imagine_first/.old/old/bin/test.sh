#!/bin/bash -e

    source $dir_cfg/support.cfg
# Load all files in src
run(){
local dir=$dir_spec
for file in `ls $dir | grep .sh$`; do
print_status "$file"
    source $dir/$file

    # OMG this is a bash test runner!! <3 <3 <3
    # functions=`declare -F | cut -d ' ' -f 3 | grep ^test_`
    # This style allows us to run tests in order
#    file_txt=`echo $file | sed 's/sh/txt/g'`
   # cat $path/idea/$file_txt
    
    functions=`grep -h test_ $dir/$file | cut -d '(' -f 1`
    for i in $functions; do
       # rm -rf $dir_base/tmp/*
        $i
        print_good "  $i"
    done

done

}
run
