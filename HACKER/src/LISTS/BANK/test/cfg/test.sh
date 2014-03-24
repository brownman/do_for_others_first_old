#!/bin/bash -e
path=`pwd`
pushd "$path">/dev/null
    dir_units=$path/units
    file_test=$dir_units/test_error.sh
    ls $file_test
    cmd="$file_test"
    eval "$cmd"
popd>/dev/null
