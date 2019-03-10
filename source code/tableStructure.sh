#!/bin/bash
dbname=$1
tableName=$2
isPrimaryKeySet=0
primaryKeyIndex=1

while true 
do 
clear     # clear the screen
echo "***************************************************"
echo "                 DataBase Name: $dbname            "
echo "                  Table Name: $tableName           "
echo "*                Set Table Structure              *"
echo "***************************************************"
echo

echo -e "please enter the number of columns in this table or (b) to back to tableMenu \n"
read noColumns

if [[ "$noColumns" = b ]]
    then
        . tableMenu.sh
fi

if [[ "$noColumns" =~ ^[1-9]+$ ]]
    then 
        # Getting and validating number of columns 
        echo "Number of columns = $noColumns"
    else 
        echo Please insert non zero Number
        sleep 2
        continue 
fi 

for ((i=1;i<=$noColumns;i++))
do 
    echo
    echo -e "Please select column $i name :"
    read columnName
    #Validating column name
    if ! [[ "$columnName" =~ ^[a-zA-Z][0-9|a-z|A-Z|_|\d]*$ ]]
        then 
            i=$i-1
            echo "Please Insert valid Name starting with letters only" 
            sleep 2
            continue
    fi

    # Getting index of the primary key 
    if  [[ $isPrimaryKeySet -eq 0 ]]
        then
           echo "Note: in case you don't choose any field to be Primary key, the default is first field."
           echo "Is this field primary Key?[y for yes | any key to cancel]"
           read primaryKeyConfirm
           if [[ "$primaryKeyConfirm" =~ ^[y|Y] ]]
              then
              primaryKeyIndex=$i
              isPrimaryKeySet=1
            fi
    fi
               
    echo
    echo "Please select column $i data type :"
    select choice in "Number" "String"
    do
        case $REPLY in
            1) printf "$columnName Number:" >> ../DBs/$dbname/$tableName
                break;;
            2) printf "$columnName String:" >> ../DBs/$dbname/$tableName
                break;;
            *) echo "Please Insert bumber between 1 and 3";;
        esac
    done

done

 
echo "All columns created successfully"
printf "\nPK_Index:$primaryKeyIndex" >> ../DBs/$dbname/$tableName
printf "\nNoColumns:$noColumns" >> ../DBs/$dbname/$tableName
sleep 2
. tableActionMenu.sh $dbname $tableName

 done



