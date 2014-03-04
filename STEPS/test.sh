#!/bin/bash -e
print_shlvl
pushd `dirname $0`
set -o nounset

source loader.cfg
popd
