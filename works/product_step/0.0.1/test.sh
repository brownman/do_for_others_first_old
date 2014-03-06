#!/bin/bash -e
reset
pushd `dirname $0` >/dev/null
set -o nounset
export path=`dirname $0`
source $path/stepper.cfg
popd >/dev/null
