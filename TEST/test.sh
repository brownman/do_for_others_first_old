#!/bin/bash 
#dir=package/do-for-others-first-0.0.1/usr/local/src/do-for-others-first/
#wrapper=$dir/breath.sh
###########################################  Directory structure:  ######################\
pushd `dirname $0`
unset rm
dir=`pwd`
dir_test=$dir/tests
export runner=$dir/lib/shunit2/src/shell/shunit2
$dir_test/about_grep.sh
$dir_test/about_sed.sh
popd




