#echo 'logger.db'

if [ ! "$1" ];then
    echo 'no args'
    exit

fi
#name1="$1"
#file_name="$1"
file_name="logger.db"

#touch $file_name
#dir1=$PWD/backup
#mkdir -p $dir1
#file_absolute=$(echo "$dir1/$name1-$(date +%m_%d_%Y_%H_%M).db")
#cp $file_name $file_absolute &
#sqlite -init $name1.db

sqlite3 $file_name < create_table.sql
sqlite3 $file_name < update_table.sql
sqlite3 $file_name < select_from_table.sql



