# #!/bin/bash
dbname=$1
tableName=$2
clear     # clear the screen
echo "***************************************************"
echo "                 DataBase Name: $dbname            "
echo "                  Table Name: $tableName           "
echo "                 Updating Specific Row Data      "
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

echo "Do you have The primary key value of the row you need to update?[y for yes | any key to cancel]"
read userInput 
if [[ "$userInput" =~ ^[y|Y] ]]
    then
        echo "Please enter this primary key:"
        read pk
        Row_found=$(awk -F: -v pk_index=$primaryKeyIndex -v u_input=$pk 'NR>3 && $pk_index==u_input {print $0}' ../DBs/$dbname/$tableName)
        Row_updated=""
        if [ -z $Row_found ] #Nothing to update
            then 
            echo "This primary key is not existed!!."
            sleep 2
            . tableActionMenu.sh $dbname $tableName
            else #This PK is existed
                for ((i=1;i<=$noColumns;i++))#For loop to loop through fields to check if user needs to update
                do
                if [[ $i -eq $primaryKeyIndex ]]
                    then 
                    PK=$(echo $Row_found | cut -d ":" -f$i)
                    Row_updated=$Row_updated$PK":"
                    else 
                        current=$(echo $Row_found | cut -d ":" -f$i) 
                        echo "Do you want to update column: ${columnsNames[$i-1]} of type: ${columnsTypes[$i-1]} and its current value: $current ?[y for yes | any key to cancel]"
                        read userInput2
                        if [[ "$userInput2" =~ ^[y|Y] ]]
                            then
                            echo "Enter your updated value then press Enter:"
                            read fieldToUpdate
                            if [[ ${columnsTypes[$i-1]} == "Number" ]]
                                then
                                if [[ "$fieldToUpdate" =~ ^[0-9]+$ ]]  #Validation successeded for number data type
                                    then 
                                         Row_updated=$Row_updated"$fieldToUpdate"":"
                                    else 
                                        echo "Please enter a valid number. This field is of type Number"
                                        sleep 2
                                        i=$i-1
                                        continue
                                fi
                                else
                                    Row_updated=$Row_updated"$fieldToUpdate"":" 
                            fi
                            else # The user doesn't need to update
                                Row_updated=$Row_updated"$current"":"
                        fi
                fi
                done
             sed -i 's/'$Row_found'/'$Row_updated'/g' ../DBs/$dbname/$tableName
             echo "Updating row is done successfully"
             sleep 2
            . tableActionMenu.sh $dbname $tableName
        fi
    else 
        . tableActionMenu.sh $dbname $tableName
fi