#sqlite> UPDATE Books SET Author='Lev Nikolayevich Tolstoy' WHERE Id=1;

#INSERT INTO snippet VALUES (1,1,1,1,1,1,1);

    #local cmd=$(echo "sqlite3 $file_db  \"insert into $table1 $fields values $values\";")
    file_db=logger.db
    table1="$1"
    fields="$2"
    values="$3"
sqlite3 $file_db  "insert into $table1 $fields values $values";
