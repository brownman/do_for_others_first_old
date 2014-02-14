#!/bin/bash -e
path=`pwd`
#source $path/loader.cfg

echo "path: $path"
confirm

package_name='do-for-others-first'
dir_first=$package_name-0.0.1
SUDO=''
inst_dir=test1
root_dir=/tmp
args_extra="--force-not-root"

build(){
    print_func
cmd="dpkg-deb --build  $dir_first $root_dir/$package_name.deb"
confirm "$cmd"
}
install(){
    print_func
   if [ ! -d "$inst_dir" ];then
mkdir -p $inst_dir
fi 

cmd="$SUDO dpkg -i $args_extra $package_name.deb --root=$root_dir --instdir=$inst_dir"
confirm "$cmd"
}
remove(){
$SUDO dpkg -r $package_name
}
info(){
$SUDO dpkg -L $package_name
}
steps(){
print_func
show_funcs
}
if [ $# -gt 0 ];then
env
cmd="$1"
eval "$cmd"
else
echo Show steps:
steps
fi
#dpkg-deb --build gmail-group-0.0.1 /tmp/first_package.deb