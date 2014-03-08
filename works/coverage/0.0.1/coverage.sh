#!/bin/bash
set -o nounset
step00(){
    print_func
    path=${path:-''}
    if [[ -z "$path" ]];then
        reason_of_death  "\$path must be set" "$path"
    else
        export path=$path
        echo '[PATH:]  ' $path
        sleep 2
    fi
    # echo '[STEPS]'
    #    echo "path:$path"
    #    file="$path/steps.cfg"
    #    ls -l $file
}

step0(){
print_func

    #source settings.cfg
    #depend_package: xsel
    let 'counter=1'
    set -o nounset
    echo -e " \t\t\t[LOADER] "
    #export GUI=${BASH_GUI:-false}
    export GUI=false
    export SHOW_PASSED=true
    show_passed=$SHOW_PASSED
    #path=${path:-$dir_product_step}

    #####################file know its name:
    #file_this=$path/loader.cfg
    #######################################
    ################## clean the log file:

    export file_log=$path/log/log.txt
    export file_eval_res=$path/log/eval_res.txt
    export file_test_ok=$path/log/test_ok.txt
    export file_test_err=$path/log/test_err.txt
    export file_trace=$path/log/trace.txt
    export file_clip=$path/log/clipboard.txt
    #source $path/share/color.cfg
    #source $path/share/proxy.cfg

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
        reason_of_death 'supply a function to evaluage'
    fi
    echo ============
}

print_file(){
    print_func
    local file=$1
    #    echo "File:         $file"
    cat $file
}

details(){
    echo -n '' > $file_trace
    echo -e [$str_ptrn] "File:\t\t$file_cfg"  >> $file_trace
    echo -e [$str_ptrn] "Function:\t\t$func_name" >> $file_trace
    echo -e [$str_ptrn] "Test:\t\t$str_res" >> $file_trace
    str_goto=`grep $func_name $file_cfg -n | cut -d ':' -f1 `
    local cmd="vi $file_cfg +$str_goto"
    echo -e "[$str_ptrn]" "Clipboard:\t\t$cmd" >> $file_trace
    ##create a lazy file - for fast opening the error line
    cmd="echo $cmd | /usr/bin/xsel --clipboard"
    echo "$cmd" > $file_clip
    eval "$cmd"
}
coverage(){
    print_func
    local str_ptrn="$1"
    let 'res=0'
    str_res=`cat $file_cfg | grep $func_name -A 3 | grep $str_ptrn |  sed "s/#$str_ptrn://g" | tr -s ' '`
    #notify-send "=${str_res}="
    if [ "$str_res" ] && [ "$str_res" != ' ' ] ;then
        if [ "$str_ptrn" = check ];then
            #we are interested only if there is an error case
            print_color_n 37 '[TEST]'
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
                reason_of_death 'test failed'
            fi


            #{ print_eval_res;print_line;details;echo -e >&2 "\n___________________[ERROR] while testing:\n";cat $file_clip;exit 1; } || echo evaluation ok
        elif [ "$str_ptrn" = info ];then
            print_color 35 "\t\t$str_res"
        else
            details
            reason_of_death "[TAG] is not recognized - please add an handler for it before continue" "$str_ptrn"
        fi
    else
        echo [UNCOVERED:]
        details
        reason_of_death "Empty tag: $str_ptrn" "$func_name" 
    fi

}

step1(){
    #info: run all steps: use the index values to determine the amount of allowed steps
print_func
    file_level="$path/level.txt"

    file_cfg=$path/steps.cfg

    str=`cat $file_level` 
    source $file_cfg
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
        reason_of_death 'no file' "$file_level"
    fi
}
steps(){
    print_func
    echo step00
    step00
    echo step0
    step0
    echo step1
    step1
    #print_color_n 32 '[END]' 
    #xcowsay "WoW! $counter  Steps!"
}
steps


