
#!/bin/bash
let primfield=0
dbname = $1
tbname = $2

while true
do        
    clear
    echo "***************************************************"
    echo "                 DataBase Name: $dbname            "
    echo "*                  Table Name: $tablename         *"
    echo "*                    Delete Row                   *"
    echo "***************************************************"
    echo

    sed -n '2p' ../DBs/$dbname/.$tbname.meta 
    sed -n 'p' ../DBs/$dbname/$tbname | sort -t: -k"$[ $(sed -n '1p' ../DBs/$dbname/.$tbname.meta) + 1 ]" 

    echo  Enter Value of Primary Key to Delete
    read primaryKey
    primfield="$(sed -n "1p" ../DBs/$dbname/.$tbname.meta)"
    primfield=$(( $primfield+1 ))
    myx="$(sed -n "/.*:$primaryKey$/p" ../DBs/$dbname/$tbname | cut -d: -f$primfield )" 

    if [ "$primaryKey" != "$myx" ] 
        then
        echo Primary Key $primaryKey Does not Exist
        read a
        exit
        else
        sed -i "/.*:$primaryKey$/d" ../DBs/$dbname/$tbname 2>/dev/null
        sed -i "/$primaryKey$/d" ../DBs/$dbname/$tbname 2>/dev/null
    fi

    echo "Successfully deleted row identified by $primaryKey ,table name: $tbname in $dbname database"
    read a
done