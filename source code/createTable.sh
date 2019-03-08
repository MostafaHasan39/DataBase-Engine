#!/bin/bash

dbName=$1;
validator = ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$

while true

do
clear
echo -e "--------You are now using $dbName DataBae --------\n\n\n"
printf "Please enter the new table name : \n"
read tableName


if [[ "$tableName" =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
then 
  if [ -e ./DBs/$dbName/$tableName ]
  then 
  echo "This table is already existed"
  sleep 5
  else 
  touch ./DBs/$dbName/$tableName
  echo "This is New Table"
  sleep 5
  break
  fi 
else 
  echo "The table name must start with alphapet"
  sleep 5
fi
done

. tableMenu.sh







#Table Name Validation 
#if [ -e ./DBs/$dbName/$tableName ]
#then 
#echo "This table is already existed"
#sleep 2
#else 
#touch ./DBs/$dbName/$tableName
#echo "This is New Table"
#break
#fi
#done






















