#!/bin/bash 
set -o nounset
dir_self=`pwd`
steps(){
    mkdir $dir_self/bin
    mkdir -p $dir_self/lib/python2.7
    mkdir -p $dir_self/local/lib/python2.7/dist-packages
    wget http://peak.telecommunity.com/dist/virtual-python.py
    python virtual-python.py --no-site-packages
    wget http://peak.telecommunity.com/dist/ez_setup.py $dir_self
    $dir_self/bin/python $dir_self/ez_setup.py
    $dir_self/local/bin/easy_install virtualenv
    $dir_self/local/bin/virtualenv --no-site-packages thereyouare
}
steps

set +o nounset
