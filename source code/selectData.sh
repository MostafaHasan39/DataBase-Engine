#!/bin/bash

dbname =$1
tableName =$2
clear     # clear the screen
echo "***************************************************"
echo "                 DataBase Name: $dbname            "
echo "                  Table Name: $tableName           "
echo "*                  Displaying All Table Data      *"
echo "***************************************************"
echo

noColumns=`head -3 ../DBs/$dbname/$tableName | tail -1 | cut -d ":" -f2`
primaryKeyIndex=`head -2 ../DBs/$dbname/$tableName | tail -1 | cut -d ":" -f2`
columnsNames=()
columnsTypes=()

for ((i=1;i<=$noColumns;i++))
do
  columnsNames=("${columnsNames[@]}" "`head -1 ../DBs/$dbname/$tableName | cut -d ":" -f$i | cut -d " " -f1`")
  columnsTypes=("${columnsTypes[@]}" "`head -1 ../DBs/$dbname/$tableName | cut -d ":" -f$i | cut -d " " -f2`")
done

echo "Data Format:"
echo "${columnsNames[@]}"
echo "${columnsTypes[@]}"
echo 
echo "Table Data:"

awk -F: 'NR>3' ../DBs/$dbname/$tableName

echo 
echo "Press any key to return to table action menu"
read userinput
. tableActionMenu.sh $dbname $tableName



