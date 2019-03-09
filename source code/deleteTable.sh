#!/bin/bash


dbname = $1
while true
do
    clear
    echo "***************************************************"
    echo "                 DataBase Name: $1                 "
    echo "*                    Delete Table                 *"
    echo "***************************************************"
    echo
	echo Available Tables Are:
	ls ../DBs/$dbname
    echo
	echo "Please Enter Table Name To delete or (1) to Back to tableMenu":
	read tableName

    # Check if the user wants to back to tableMenu
    if [ $tableName = 1 ]
        then
        . tableMenu.sh
        else 
        # Check if this table is already exist
        if [ -e ../DBs/$dbname/$tableName ]
		    then
		    rm ../DBs/$dbname/$tableName
            . deleteTable.sh 
		    else
            echo This Table does not exist in this list
            sleep 2 
        fi
    fi        		
done