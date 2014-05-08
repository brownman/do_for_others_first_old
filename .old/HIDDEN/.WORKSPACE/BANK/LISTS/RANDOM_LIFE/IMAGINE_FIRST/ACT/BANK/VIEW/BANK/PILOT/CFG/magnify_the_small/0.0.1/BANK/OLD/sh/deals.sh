#!/bin/bash
# about file: deals.sh
# desc: find deals with free shipping worldwide, price comparison, save google queries 



worldwide(){
    url='http://www.storeswithfreeshipping.net/free-shipping-stores-list.php'
    exo-open $url
}

step1(){
    #gxmessage -file "$DATA_DIR/tmp/deals.tmp"

    local from="$DATA_DIR/tmp/deals.tmp"
    lines=() 


    #local cmd='echo4'
    local cmd='exo-open'
    #notify_send1'
    file_to_lines "$from"

    execute_lines

assert_equal_str "${lines[0]}"
    #local msg=$(    execute_lines )
    #local msg=$(file_to_lines "$from")
    echo "$msg"
    echo "zz"

}


step1
