#!/bin/bash

dbname =$1
tableName =$2
clear     # clear the screen
echo "***************************************************"
echo "                 DataBase Name: $dbname            "
echo "                  Table Name: $tableName           "
echo "                 Displaying Specific Row Data      "
echo "***************************************************"
echo

primaryKeyIndex=`head -2 ../DBs/$dbname/$tableName | tail -1 | cut -d ":" -f2`

echo "Do you have The primary key value of the row you need to show?[y|n]"
read userInput 

if [[ "$userInput" =~ ^[y|Y] ]]
    then
        echo "Please enter this primary key:"
        read pk
        awk -F: -v pk_index=$primaryKeyIndex -v u_input=$pk 'BEGIN{data_exist=0} NR>3 && $pk_index==u_input {print $0;data_exist=1}END{if(!data_exist) print"This Primary Key is not existed"}' ../DBs/$dbname/$tableName 
        echo "Press any key to Back to table action menu"
        read userInput2
        . tableActionMenu.sh $dbname $tableName
        
    else 
        . tableActionMenu.sh $dbname $tableName
fi

