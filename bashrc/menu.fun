
menu(){


    if [ $# -eq 1 ];then
        dumpfile="$1"
        while [[ 1 ]]
        do
            cat -n "$dumpfile"
            read -p "Please make a selection, select q to quit: " choice
            case $choice in
                # Check for digits
                [0-9] )   dtvariable=$(sed -n "$choice"p "$dumpfile")
                $dtvariable            ;;
            q|Q)
                break
                ;;
            *)
                echo "Invalid choice"
                ;;
        esac
    done
else 

    echo Dynamic menu generator
    echo 'please supply a file'
fi
}


export -f menu 
