#!/bin/bash 
#dir=package/do-for-others-first-0.0.1/usr/local/src/do-for-others-first/
#wrapper=$dir/breath.sh
###########################################  Directory structure:  ######################\
    unset rm


dir=`pwd`
dir_regular=$dir/REGULAR
export runner=$dir_regular/shunit2/src/shell/shunit2

$dir_regular/about_sed.sh
$dir_regular/about_grep.sh



#. $runner
