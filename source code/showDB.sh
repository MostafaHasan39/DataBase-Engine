#!/bin/bash

while true
do
    clear
    echo "***************************************************"
    echo "*               List Existed DataBases            *"
    echo "***************************************************"
    echo
	echo "Available DataBases Are:"
	ls ../DBs
    echo
	echo "Please Enter Database Name To Use or 1 to back to dbMenu:"
	read dbname

    # Check if the user wants to back
  	if [ $dbname = 1 ]
      then
      . dbMenu.sh
      else
        # Check if this database is already exist
        if [ -e ../DBs/$dbname ]
		    then
		    . tableMenu.sh $dbname 
		    else
            echo "This DataBase does not exist in this list"
            sleep 2 
        fi
    fi    		
done