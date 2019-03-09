#!/bin/bash
clear     # clear the screen
echo "***************************************************"
echo "                 DataBase Name: $1                 "
echo "*                    Table Menu                   *"
echo "***************************************************"
echo
echo "Please Enter Your Selection:"

select choice in "Create New Table" "Show and Use already existed Tables" "Delete Table" "Back to DatabaseMenu" "Exit"
do
    case $REPLY in
        1) . createTable.sh $1;;
        2) . showTable.sh $1;;
        3) . deleteTable.sh $1;;
        4) . dbMenu.sh;; 
        5) exit;;
        *) echo "invalid option";;
    esac
done
