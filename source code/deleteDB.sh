#!/bin/bash

while true
do
    clear
    echo "***************************************************"
    echo "*              Delete Existed DataBase            *"
    echo "***************************************************"
    echo
	echo "Available DataBases Are:"
	ls ../DBs
    echo
	echo "Please Enter Database Name To delete or (1) to Back":
	read dbname

    # Check if the user wants to back to dbMenu
    if [ $dbname = 1 ]
        then
        . dbMenu.sh
        else 
        # Check if this database is already exist
        if [ -e ../DBs/$dbname ]
		    then
            # hint: don't use rmdir to remove the directory because if it has data it won't be deleted
		    rm -rf ../DBs/$dbname
            . deleteDB.sh
		    else
            echo "This DataBase does not exist in this list"
            sleep 2 
        fi
    fi        		
done