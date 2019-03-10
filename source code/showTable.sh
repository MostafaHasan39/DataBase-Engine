#!/bin/bash

dbname = $1
while true
do
    clear
    echo "***************************************************"
    echo "                 DataBase Name: $1                 "
    echo "*                 List All Tables                 *"
    echo "***************************************************"
    echo
	echo Available Tables Are:
	ls ../DBs/$dbname
    echo
	echo Please Enter Table Name To Use or 1 to back to tableMenu:
	read tableName

    # Check if the user wants to back
  	if [ $tableName = 1 ]
      then
        . tableMenu.sh
      else
        # Check if this table is already exist
        if [ -e ../DBs/$dbname/$tableName ]
		    then
		        . tableActionMenu.sh $dbname $tableName 
		    else
                echo This Table does not exist in this list
                sleep 2 
        fi
    fi    		
done






