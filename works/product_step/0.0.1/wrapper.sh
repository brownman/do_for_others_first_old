#!/bin/bash 
reset
pushd `dirname $0` >/dev/null

set -o nounset
export path=`dirname $0`
breakpoint(){
    echo error | flite
    echo error
    exit 1
}
trap breakpoint ERR

source $path/stepper.cfg

popd >/dev/null
