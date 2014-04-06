#!/bin/bash -e
pushd `dirname $0`
path=`pwd`
$dir_vendor/bash_koans/runner_single.sh $path/$1
popd
