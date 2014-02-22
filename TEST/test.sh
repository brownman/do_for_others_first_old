#!/bin/bash 
#dir=package/do-for-others-first-0.0.1/usr/local/src/do-for-others-first/
#wrapper=$dir/breath.sh
###########################################  Directory structure:  ######################\
unset rm


dir=`pwd`
dir_test=$dir/TEST


export runner=$dir_test/shunit2/src/shell/shunit2
#export runner=$dir_test/shunit2/src/shell/shunit2
. $runner
#. $dir_test/about_grep.sh




