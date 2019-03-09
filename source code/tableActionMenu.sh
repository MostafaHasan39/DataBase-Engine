#!/bin/bash

dbname =$1
tableName =$2
clear     # clear the screen
echo "***************************************************"
echo "                 DataBase Name: $dbname            "
echo "*                  Table Name: $tableName         *"
echo "*                Select Table Actions             *"
echo "***************************************************"
echo
echo "Please Enter Your Selection:"

select choice in "Show Table's data" "insert New Row" "Delete Row" "Update Row" "Back to tableMenu" "Exit"
do
    case $REPLY in
        1) . selectData.sh ;;
        2) . insertRow.sh ;;
        3) . deleteRow.sh ;;
        4) . updateRow.sh ;;
        5) . tableMenu.sh ;; 
        6) exit;;
        *) echo "invalid option";;
    esac
done
