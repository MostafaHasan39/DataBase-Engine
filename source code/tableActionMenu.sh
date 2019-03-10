#!/bin/bash

dbname =$1
tableName =$2
clear     # clear the screen
echo "***************************************************"
echo "                 DataBase Name: $dbname            "
echo "                  Table Name: $tableName           "
echo "*                Select Table Actions             *"
echo "***************************************************"
echo
echo "Please Enter Your Selection:"

select choice in "Show Table's data" "Show specific row data" "insert New Row" "Delete Row" "Update Row" "Back to tableMenu" "Exit"
do
    case $REPLY in
        1) . selectData.sh $dbname $tableName;;
        2) . showRow.sh $dbname $tableName;;
        3) . insertRow.sh $dbname $tableName;;
        4) . deleteRow.sh $dbname $tableName;;
        5) . updateRow.sh $dbname $tableName;;
        6) . tableMenu.sh $dbname;; 
        7) exit;;
        *) echo "invalid option";;
    esac
done
