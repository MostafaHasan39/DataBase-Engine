
# #!/bin/bash
dbname=$1
tableName=$2
clear     # clear the screen
echo "***************************************************"
echo "                 DataBase Name: $dbname            "
echo "                  Table Name: $tableName           "
echo "                 Deleting Specific Row Data      "
echo "***************************************************"
echo

primaryKeyIndex=`head -2 ../DBs/$dbname/$tableName | tail -1 | cut -d ":" -f2`

echo "Do you have The primary key value of the row you need to delete?[y|n]"
read userInput 

if [[ "$userInput" =~ ^[y|Y] ]]
    then
        echo "Please enter this primary key:"
        read pk
        #Add deleting section
        Row_delete=$(awk -F: -v pk_index=$primaryKeyIndex -v u_input=$pk 'NR>3 && $pk_index==u_input {print $0}' ../DBs/$dbname/$tableName)
        if [ -z $Row_delete ] #Nothing to delete
            then 
                echo "This primary key is not existed!!."
                sleep 2
                . tableActionMenu.sh $dbname $tableName
            else #This PK is existed
                sed -i "/^$Row_delete$/d" ../DBs/$dbname/$tableName
                echo "Row deleted successfully. Press any key to Back to table action menu"
                read userInput2
                . tableActionMenu.sh $dbname $tableName
        fi
    else 
        . tableActionMenu.sh $dbname $tableName
fi











