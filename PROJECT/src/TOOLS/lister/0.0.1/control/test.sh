#!/bin/bash -e
print_shlvl
pushd `dirname $0`
set -o nounset

source steps.cfg
popd
