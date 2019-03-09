#!/bin/bash

clear     # clear the screen

echo "***************************************************"
echo "*              Welcome To DataBase Engine         *"
echo "*                 Bash Shell  script              *"
echo "***************************************************"
echo
echo "Please Enter Your Selection:"

select choice in "Create New DataBase" "Show and Use already existed DataBases" "Delete DataBase" "Exit"
do
    case $REPLY in
        1) . createDB.sh;;
        2) . showDB.sh;;
        3) . deleteDB.sh;; 
        4) exit;;
        *) echo "invalid option";;
    esac
done


