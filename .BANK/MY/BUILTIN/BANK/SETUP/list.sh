step1(){
    local dir_self=`where_am_i $0`
    set -e 
    set -o nounset
    while read line;do


        if [ -n "$line" ];then

            echo "[line] $line"
            local   weight=`echo $line | cut -d':' -f1`
            local   file_relative=`echo $line | cut -d':' -f2`


            local file=$dir_self/$file_relative

            #echo $weight
            #echo $file
            local res=0
            if  [ -f "$file" ];then
                echo "[file exist] $file" 
                #every $weight $file
                local    cmd="every $weight $file"
                echo "[cmd] $cmd"
                eval "$cmd"
                res=$?
                if [ $res -eq 0 ];then
                    print_color 32 "OK"
                else
                    print_color 31 "ERROR"
                fi
            else
                echo "[ERROR] no such file " "$file"
            fi
        else
            echo "[ERROR] reached empty line ! - stacked?"
        fi
    done<$dir_self/list.txt
}

step1
