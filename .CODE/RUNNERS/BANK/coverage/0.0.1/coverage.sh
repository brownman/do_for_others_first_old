#!/bin/bash 
#info: cover functions
set -o nounset
#depend_func: print_color print_color_n proxy reason_of_death
path_self=`dirname $0`
path=${path:-$PWD}
echo '[COVERAGE]'
echo "path: $path"
echo "path_self: $path_self"
sleep 3
pushd `pwd` >/dev/null


dependencies(){
    cat $0 | grep depend_func
    sleep 2
}


set_vars(){
    #    print_func

    #source settings.cfg
    #depend_package: xsel
    let 'counter=1'
    set -o nounset
    #    echo -e " \t\t\t[LOADER] "
    #export GUI=${BASH_GUI:-false}
    export GUI=false
    export SHOW_PASSED=true
    show_passed=$SHOW_PASSED
    #path_self=${path_self:-$dir_product_step}

    #####################file know its name:
    #file_this=$path_self/loader.cfg
    #######################################
    ################## clean the log file:
    echo "$path_self"
    ls "$path_self/log"
    export file_log=$path_self/log/log.txt
    export file_eval_res=$path_self/log/eval_res.txt
    export file_test_ok=$path_self/log/test_ok.txt
    export file_test_err=$path_self/log/test_err.txt
    export file_trace=$path_self/log/trace.txt
    export file_clip=$path_self/log/clipboard.txt
    #source $path_self/share/color.cfg
    #source $path_self/share/proxy.cfg

}
log_update(){
    #print_func

    echo -n '' > $file_trace
    echo -e [$str_ptrn] "File:\t\t$file_cfg"  >> $file_trace
    echo -e [$str_ptrn] "Function:\t\t$func_name" >> $file_trace
    echo -e [$str_ptrn] "Test:\t\t$str_res" >> $file_trace

    cmd="grep \"$func_name\" \"$file_cfg\" -n -m 1 | cut -d ':' -f1 "
    str_goto=$( eval "$cmd" )
    #echo "str_goto: $str_goto"
    cmd="vi $file_cfg +$str_goto"
    echo -e "[$str_ptrn]" "Clipboard:\t\t$cmd" >> $file_trace
    ##create a lazy file - for fast opening the error line


    echo "$cmd" > $file_clip


}
log_print(){
    print_file $file_clip
    print_file $file_trace
}
log_use(){
    print_func
    echo
    update_clipboard "$cmd"
    exiting
}

details(){

    echo '[DETAILS]'
    log_update
    #log_print
    print_line
    log_use
}


coverage(){
    #    print_func


    local file_cfg="$1"
    local func_name="$2"
    local str_ptrn="$3"

    let 'res=0'
    str_res=`cat $file_cfg | grep $func_name -A 3 | grep \#$str_ptrn |  sed "s/#$str_ptrn://g" | tr -s ' '`
    #notify-send "=${str_res}="
    if [ "$str_res" ] && [ "$str_res" != ' ' ] ;then
        if [ "$str_ptrn" = check ];then
            #we are interested only if there is an error case
            print_color_n 37 '[CHECK]'
            echo "$str_res"

            #1>$file_trace

            rm $file_test_err
            rm $file_test_ok
            eval "$str_res" 1>$file_test_ok 2>$file_test_err
            [ -s $file_test_err ] && let 'res=1' || let 'res=0'
            if [ "$res" -eq 0 ];then
                print_color 32 '[OK]'
                if [ "$show_passed" = true  ];then
                    print_file $file_test_ok
                fi
            else
                print_color 31 '[ERROR]'
                print_file $file_test_err
                details
                proxy reason_of_death 'test failed'
            fi


            #{ print_eval_res;print_line;details;echo -e >&2 "\n___________________[ERROR] while testing:\n";cat $file_clip;exit 1; } || echo evaluation ok
        elif [ "$str_ptrn" = info ];then

            print_color_n 37 '[INFO]'
            print_color 35 "\t\t$str_res"
        else
            details
            proxy reason_of_death "[TAG] is not recognized - please add an handler for it before continue" "$str_ptrn"
        fi
    else
        #        echo [UNCOVERED:]
        details
        proxy reason_of_death "Empty tag: $str_ptrn" "$func_name" 
    fi

}


ensure_path(){
    #   print_func

    if [[ -z "$path" ]];then
        proxy reason_of_death  "path must be set" "$path"
    else
        export path_self=$path_self
        #      echo '[path_self:]  ' $path_self
        #     sleep 2
    fi


    # echo '[STEPS]'
    #    echo "path_self:$path_self"
    #    file="$path_self/steps.cfg"
    #    ls -l $file
}

##################
evaluate(){
    #info: run the next stepX()
    print_func

    echo ============
    print_color 37 '[RUNNING]'
    if [ $# -gt 0 ];then
        cmd="$1"
        #        echo "cmd: $cmd"
        eval "$cmd" > $file_eval_res
        print_file $file_eval_res
    else
        proxy reason_of_death 'supply a function to evaluage'
    fi
    echo ============
}

print_file(){
    print_func
    local file=$1
    #    echo "File:         $file"
    cat $file
}

step1(){
    #info: run all steps: use the index values to determine the amount of allowed steps
    print_func
    file_level="$path_self/level.txt"



    str=`cat $file_level` 
    if [ -f "$file_cfg" ];then

        source $file_cfg
    else
        proxy reason_of_death "file not exist" "$file_cfg"
    fi


    if [ "$str" != '' ];then
        let "max=$str"
        echo -e "\t\t\t\t[TOTAL STEPS] $max"

        START=1
        END=$max
        ## save $START, just in case if we need it later ##
        index=$START
        while [[ $index -le $END ]]
        do
            print_line
            func_name="step${index}"
            echo
            #print_color_n 37 "[STEP]"
            echo -e "$index/$max" 
            #"$file_cfg" "$func_name"

            coverage info 
            str_step="step${index}"
            evaluate "$str_step"
            coverage check 
            ((index = index + 1))
            let 'counter+=1'
        done
    else
        proxy reason_of_death 'invalid level' "$str"
    fi
}
steps(){
    print_func
    echo step00
    step00
    echo step0
    step0

    echo step01
    step01

    echo step1
    step1
    #print_color_n 32 '[END]' 
    #xcowsay "WoW! $counter  Steps!"
}

#path_self=${1:-"$PWD"}
steps_new(){
    #dependencies
    #ensure_path
    set_vars
    if [ -f "$file_cfg" ];then

        source $file_cfg
    else
        proxy reason_of_death "file not exist" "$file_cfg"
    fi

    str=`   cat $file_cfg | grep '(){' | sed 's/(){//g'`
    arr=( $str )

    max="${#arr[@]}"


    echo "funcs: ${arr[@]}"
    echo "max funcs: $max"
    sleep 2
    if [ "$max" -gt 0 ];then
        funcs="${arr[@]}"
        for func in $funcs;do
            echo "func: $func"
            coverage $file_cfg $func info
            coverage $file_cfg $func check
        done
    else
        cmd="vi $path_self/$file_cfg"
        update_clipboard "$cmd"
        proxy reason_of_death 'file has 0 functions' "$file_cfg"
    fi


}
if [ $0 = $BASH_SOURCE];then

    if [ $# -gt 0 ];then


        filename=$1

        file_cfg=$path/$filename
    else
        proxy reason_of_death 'supply a .cfg file'
    fi

    steps_new


fi
popd >/dev/null
