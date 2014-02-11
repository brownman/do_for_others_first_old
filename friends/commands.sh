#!/bin/bash -e
path=`dirname $0`
env(){
print_func
dir_first=vm
package_name='do_for_others_first'
}

build(){
    print_func
cmd="dpkg-deb --build  $dir_first $path/$package_name.deb"
confirm "$cmd"
}

if [ $# -gt 0 ];then
env
cmd="$1"
eval "$cmd"
else
show_funcs
fi
