#!/bin/bash 
#dir=package/do-for-others-first-0.0.1/usr/local/src/do-for-others-first/
#wrapper=$dir/breath.sh
###########################################  Directory structure:  ######################\
    pushd `dirname $0`>/dev/null
    path=`pwd`
    reset

trigger_runner(){
    if [ "$runner_name" = shunit2 ];then
    print_func
    #trigger_runner
    echo "[RUNNER] $runner"

        echo "$runner"
        sleep 5
        . $runner
    fi
}

step0(){
    print_func
 export   dir_target=$path/tests
    export -f trigger_runner
}

step1(){
    print_func
    echo 'decide which runner'
    export dir_runner=$dir_vendor/bash_koans
    export runner=$dir_runner/runner_all.sh
#    export runner=$dir_vendor/shunit2/src/shell/shunit2
    export     runner_name=`basename $runner`

    cmd="vi $dir_runner" 

    echo  "[CLIPBOARD] $cmd" 
    echo "$cmd" | /usr/bin/xsel --clipboard

    sleep 3
}

step3(){
    print_func
    if [ "$runner_name" = shunit2 ];then
        $dir_test/about_grep.sh
        $dir_test/about_sed.sh
    else
        $runner "$dir_target"
    fi
}

steps(){
    print_func
    step0
    step1
#    step2
    step3
}



steps

#$dir_test/about_grep_replace.sh
popd>/dev/null




