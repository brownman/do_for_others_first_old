set -e 
set -o nounset
eat(){
    local cmd="$@"
    eval "$cmd"
    res=$?
    if [ $res -eq 0 ];then
        print_color 32 "OK"
    else
        print_color 31 "ERROR"
        return 1
    fi

}
step1(){
    local dir_self=`where_am_i $0`
    while read line;do


        if [ -n "$line" ];then

         trace   echo "[line] $line"
            local   weight=`echo $line | cut -d':' -f1`
            local   file_relative=`echo $line | cut -d':' -f2`


            local file=$dir_self/$file_relative

            #echo $weight
            #echo $file
            local res=0
            if  [ -f "$file" ];then
trace                echo "[file exist] $file" 
                #every $weight $file
                local    cmd="every $weight $file"
     trace           echo "[cmd] $cmd"
                eat "$cmd"
            else
                echo "[ERROR] no such file " "$file"
            fi
        else
            echo "[ERROR] reached empty line ! - stacked?"
        fi
    done<$dir_self/list.txt
}

step1
