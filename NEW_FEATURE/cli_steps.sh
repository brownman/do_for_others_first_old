#!/bin/bash
TRANSLATE=true

translate(){
        $dir_root/
}

while [ 1 ];do
    read answer
    echo "$answer" >> .LOG/cli_steps.txt
    if [ "$TRANSLATE" = true ];then
        translate "$answer"
    fi
done
