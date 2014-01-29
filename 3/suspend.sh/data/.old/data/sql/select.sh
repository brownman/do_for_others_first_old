table=$1
file_db=logger.db

#sqlite3 -csv /home/dao01/magnify_the_small/data/sql/logger.db "select * from $table order by id desc;"
sleep 2
row=$(sqlite3 -header -list $file_db "select * from $table;" )
#| head -n 2 | tail -1 )
echo "row:$row"

#sqlite3 -csv /home/dao01/magnify_the_small/data/sql/logger.db 'select * from koan order by id desc;'
