shopt -s expand_aliases
#pushd `dirname $0`
first_dir=`dirname $0`
path=$first_dir/cfg

step1(){
    echo 'step1()'
    source $path/loader.cfg
}



steps(){
step1
print_color 32 OK 
}
steps
#popd
