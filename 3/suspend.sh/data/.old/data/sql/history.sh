
 4760  sqlite3 -csv /home/dao01/magnify_the_small/data/sql/logger.db 'select * from koan order by id desc;' |  tr ','  ' '  |  tr '\n' ' ' 
 4761  sqlite3 -csv /home/dao01/magnify_the_small/data/sql/logger.db 'select * from koan order by id desc;' |  tr ','  ' '  |  tr '\n' ' ' xargs zenity --width=1280 --height=800 --list --title=koan --column="id"  --column="route"  --column="method"  --column="input"  --column="expect"  --column="result"  --timeout=340

 4764  v=${sqlite3 -csv /home/dao01/magnify_the_small/data/sql/logger.db 'select * from koan order by id desc;' |  tr ','  ' '  |  tr '\n' ' ' | xargs zenity --width=1280 --height=800 --list --title=koan --column="id"  --column="route"  --column="method"  --column="input"  --column="expect"  --column="result"  --timeout=340}
 4765  sqlite3 -csv /home/dao01/magnify_the_small/data/sql/logger.db 'select * from koan order by id desc;' |  tr ','  ' '  |  tr '\n' ' ' | xargs zenity --width=1280 --height=800 --list --title=koan --column="id"  --column="route"  --column="method"  --column="input"  --column="expect"  --column="result"  --timeout=340
 4766  sqlite3 -csv /home/dao01/magnify_the_small/data/sql/logger.db 'select * from words order by id desc;' |  tr ','  ' '  |  tr '\n' ' ' 
 4767  sqlite3 -csv /home/dao01/magnify_the_small/data/sql/logger.db 'select * from koan order by id desc;' |  tr ','  ' '  |  tr '\n' ' ' 

