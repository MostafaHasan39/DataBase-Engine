#!/bin/bash

dbName=$1;

while true
  do
  clear
  echo -e "--------You are now using $dbName DataBae --------\n\n\n"
  printf "Please enter the new table name : \n"
  read tableName


  if [[ "$tableName" =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
  then 
      if [ -e ../DBs/$dbName/$tableName ]
      then 
        echo "This table is already existed"
        sleep 2
      else 
        touch ../DBs/$dbName/$tableName
        echo "Table Created Successfully"
         sleep 2
         break
      fi 
  else 
    echo "The table name must start with alphapet"
    sleep 2
  fi
done

. tableMenu.sh
