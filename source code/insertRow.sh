#!/bin/bash
dbname=$1
tableName=$2

clear     # clear the screen
echo "***************************************************"
echo "                 DataBase Name: $dbname            "
echo "                  Table Name: $tableName           "
echo "*                  Inserting new Row              *"
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

echo "please insert your new row in the following order and press enter for submitting each field"
echo "knowing that ${columnsNames[$primaryKeyIndex-1]} is the primary key and shouldnot be repeated"
echo
echo "${columnsNames[@]}"
echo "${columnsTypes[@]}"
echo 
echo

userInputs=()
for ((i=0;i<=$noColumns-1;i++))
    do
    echo "Insert ${columnsNames[$i]} of type ${columnsTypes[$i]}"
    read userInput
    if [[ ${columnsTypes[$i]} == "Number" ]]
        then
            if [[ "$userInput" =~ ^[0-9]+$ ]]  #Validation successeded for number data type
                then 
                        if [[ $i -eq $primaryKeyIndex-1 ]] #Check if this field is primary key (then we should check if this value is repeated or not)
                            then
                                noLines=`wc -l ../DBs/$dbname/$tableName | cut -d " " -f1`
                                for ((j=4;j<=$noLines+1;j++))
                                do 
                                    if [[ $userInput -eq `head -n $j ../DBs/$dbname/$tableName | tail -1 | cut -d ":" -f$primaryKeyIndex` ]]
                                        then
                                            #userInputs=()
                                            i=$i-1
                                            echo "Your value is repeated. Note this field is primary key"
                                            sleep 2
                                        continue 2
                                    fi
                                done
                        fi
                userInputs=("${userInputs[@]}" "$userInput")
                else
                echo "Please enter a valid number. This field is of type Number"
                i=$i-1
                continue
            fi
        else   # then this field is of type string
            if [[ $i -eq $primaryKeyIndex-1 ]] #Check if this field is primary key (then we should check if this value is repeated or not)
                then
                    noLines=`wc -l ../DBs/$dbname/$tableName | cut -d " " -f1`
                    for ((j=4;j<=$noLines+1;j++))
                    do 
                        echo `head -n $j ../DBs/$dbname/$tableName | tail -1 | cut -d ":" -f$primaryKeyIndex`
                            if [[ "$userInput" == `head -n $j ../DBs/$dbname/$tableName | tail -1 | cut -d ":" -f$primaryKeyIndex` ]]
                                then
                                    #userInputs=()
                                    i=$i-1
                                    echo "Your value is repeated. Note this field is primary key"
                                    sleep 2
                                    continue 2
                            fi
                    done
            fi
        userInputs=("${userInputs[@]}" "$userInput")
    fi
done


printf "\n" >> ../DBs/$dbname/$tableName
for ((i=0;i<=$noColumns-1;i++))
    do 
    printf "${userInputs[i]}:" >> ../DBs/$dbname/$tableName
done

echo "Row saved successfully. Back to table action menu"
sleep 2
. tableActionMenu.sh $dbname $tableName
        


















