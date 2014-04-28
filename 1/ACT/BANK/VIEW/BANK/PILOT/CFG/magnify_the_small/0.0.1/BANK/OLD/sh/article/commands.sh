#!/bin/bash


create_htmls(){

    local file_from="$1"
    local service='google'
    local langs=(it ru ar hi tl)

    for lang in "${langs[@]}"
    do
        local filename_to="$lang.html"
        translate-bin -s $service  -t $lang $file_from > $DATA_DIR/html/$filename_to
    done

    #google-chrome $DATA_DIR/html/all.html &
    notify_send1  'updated' 'all.html'
}
create_htmls "$1"

