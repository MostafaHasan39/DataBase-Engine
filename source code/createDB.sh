#!/bin/bash

while true
do
	clear
	echo "***************************************************"
    echo "*                Create New DataBase              *"
    echo "***************************************************"
	echo
	echo "Available DataBases Are:"
	ls ../DBs
	echo
	echo "Please Enter Database Name To Create or 1 to back to dbMenu:"
	read dbname

  	# Check if the user wants to back
  	if [ $dbname = 1 ]
		then
		. dbMenu.sh
		else
		# Check if the databaseName is valid
		if [[ "$dbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]]                      
			then
			# Valid Name
			# Check if the databaseName is already exist
			if [ -e ../DBs/$dbname ]
				then
				echo "Database Name Selected Already Exists"
				sleep 2
				else
				# No errors found , then create a directory which represents the dataBase
				mkdir ../DBs/$dbname
				echo "Database Created Succefully."
				sleep 2
				. tableMenu.sh $dbname
				break
			fi
			else
			# Name isn't Valid
			echo "Error: Must start with letter, only AlphaNumeric is Allowed"
			sleep 2
		fi
	fi
done

