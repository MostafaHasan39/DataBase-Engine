#!/bin/bash

dbname=$1;

while true
do
    clear
    echo "***************************************************"
    echo "                 DataBase Name: $1                 "
    echo "*                Create New Table                 *"
    echo "***************************************************"
    echo
    echo "Available Tables Are:"
	  ls ../DBs/$dbname
	  echo
    printf "Please enter the new table name or 1 to back to tableMenu: \n"
    read tableName

    # Check if the user wants to back
  	if [ $tableName = 1 ]
      then
        . tableMenu.sh $dbname
      else
        # Check if the tableName is valid
        if [[ "$tableName" =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
          then
            # Valid Name
			      # Check if the tableName is already exist 
            if [ -e ../DBs/$dbname/$tableName ]
              then 
                echo "This table is already existed"
                sleep 2
              else
              # No errors found , then create a file which represents the table 
              touch ../DBs/$dbname/$tableName
              echo "Table Created Successfully"
              sleep 2
              . tableStructure.sh $dbname $tableName
            fi 
          else
          # Name isn't Valid 
          echo "The table name must start with alphapet"
          sleep 2
        fi
    fi
done
