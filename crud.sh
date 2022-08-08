#!/bin/bash

#Empty array initalize to dynamically store values input by user.
declare -A nurse
declare -A patient
# userdata=()
# nurse=()
# patient=()

# deleteNurse=() #deleting list of nurses.
# updateNurse=()

assign_nurse_to_patient(){

    nurse_list=() #ID of Nurse
    patient_list=() #ID of patient

    patientA=()
    patientB=()
    declare -A assign
    

    for i in "${!patient[@]}"; do
            patient_list+=($i)
    done

    for i in "${!nurse[@]}"; do
        nurse_list+=($i)
    done
    
    patientA+=(${patient_list[@]::$((${#patient_list[@]} / 2 ))})
    patientB+=(${patient_list[@]:$((${#patient_list[@]} / 2 ))})

    if [[ -z ${nurse[@]} ]] && [[ -z ${patient[@]} ]]; then
        echo "No Nurse and Patient Registered!!"
    else
        for ((i=0 ; i < ${#nurse_list[@]} ; ++i)) ; do
            nur=${nurse_list[i]}
            pat="${patientA[i]} ${patientB[i]}"
            # echo  $nur $pat
            # nurse+=([$user_ID]=$name)
            assign+=([$nur]=$pat)
        done
    fi
    echo "-----------------------------------"
    for userid in "${!assign[@]}"; do
        echo "Nurse ID = $userid -> Patient ID = ${assign[$userid]}"
    done


}



# List nurse
list_nurse(){
    #checking zero length of array. 
    if [[ -z ${nurse[@]} ]]; then
        echo "No Nurse Registered!!"
    else
        for userid in "${!nurse[@]}"; do
            echo "USER_ID = $userid -> Nurse Details = ${nurse[$userid]}"
        done
    fi
}

#add nurse
add_nurse(){
    echo "Enter First Name In Small Letters:"
    read name
    #Random Number as ID
    user_ID=$[RANDOM%40+1]
   
    user_key=() #Storing all available keys for validating the user..
    for i in "${!patient[@]}"; do
       user_key+=($i)
    done

    # if [[ "$name" =~ ^[a-zA-Z]+$ ]] || [[ -z ${nurse[@]} ]];then
    if [[ "$name" =~ ^[a-zA-Z]+$ ]];then
        # echo "No Nurse Registered!!"
        
        if [[ "${user_key[*]}" =~ "${user_ID}" ]]; then
            echo "$user_ID is already registerd."      
        else
            echo "Registering ... $name"
            # nurse+=($name)
            nurse+=([$user_ID]=$name)
        fi
    else 
        echo "Inputs must be a valid string"
            
    fi

}

#Delete Nurse
delete_nurse(){

    echo "Enter USER_ID To Delete Nurse!"
    read user_ID

    user_key=() #Storing all available keys for validating the user..
    for i in "${!nurse[@]}"; do
       user_key+=($i)
    done

    if [[ "${#nurse[@]}" == 0 ]] || ! [[ "${user_key[*]}" =~ "${user_ID}" ]]; then
        echo "No Such Nurse Registered!!"
    else
        echo "Deleting Nurse Details ... ${nurse[$user_ID]}"
        unset nurse[$user_ID]
    fi
}

update_nurse() {

    echo "Enter USER_ID To Update Nurse!"
    read user_ID
    user_key=() #Storing all available keys for validating the user..
    for i in "${!nurse[@]}"; do
       user_key+=($i)
    done

    if [[ "${#nurse[@]}" == 0 ]] || ! [[ "${user_key[*]}" =~ "${user_ID}" ]]; then
        echo "No Such Nurse Registered!!"
    else
        echo "Enter Updated Nurse details"
        echo "Enter Name: "
        read name
        # userInfo="$name,$age,$disease"
        echo "Updating New Nurse details...  $name"
        nurse[$user_ID]=$name
    fi
}


########################################################################
##################  Patient Code Update        #########################
########################################################################

# List patient
list_patient(){
    #checking zero length of array. 
    if [[ -z ${patient[@]} ]]; then
        echo "No patient Registered!!"
    else
        for userid in "${!patient[@]}"; do
        echo "USER_ID = $userid -> Patient Details = ${patient[$userid]}"
    done
    fi
}

#add patient
add_patient(){
    echo "Enter Name: "
    read name
    echo "Enter Age: "
    read age
    echo "Enter Disease: "
    read disease

    #Random Number as ID
    userID=$[RANDOM%40+1]

    userInfo="$name,$age,$disease"
    
    echo "Registering patient...: $userInfo"
    
    patient+=([$userID]=$userInfo)    
}

#deleting patient
delete_patient(){

    echo "Enter USER_ID To Delete Patient!"
    # userInfo="$name,$age,$disease"
    read user_ID

    user_key=() #Storing all available keys for validating the user..
    for i in "${!patient[@]}"; do
       user_key+=($i)
    done

    if [[ "${#patient[@]}" == 0 ]] || ! [[ "${user_key[*]}" =~ "${user_ID}" ]]; then
        echo "No Such patient Registered!!"
    else
        echo "Deleting User Details With User_ID: $user_ID"
        unset patient[$user_ID]
    fi
}

#Update patient
update_patient() {

    echo "Enter USER_ID To Delete Patient!"
    read user_ID
    user_key=() #Storing all available keys for validating the user..
    for i in "${!patient[@]}"; do
       user_key+=($i)
    done

    if [[ "${#patient[@]}" == 0 ]] || ! [[ "${user_key[*]}" =~ "${user_ID}" ]]; then
        echo "No Such patient Registered!!"
    else
        echo "Enter Updated Patient details"
        echo "Enter Name: "
        read name
        echo "Enter Age: "
        read age
        echo "Enter Disease: "
        read disease
        userInfo="$name,$age,$disease"
        echo "Updating New Patient details...  $userInfo"
        patient[$user_ID]=$userInfo
    fi
}

while  :
do
    echo ""
    echo "CRUD Operation Using Array."
    echo ""
    echo "1) List Nurses"
    echo "2) Add Nurse"
    echo "3) Delete Nurse"
    echo "4) Update Nurse"
    echo ""
    echo "5) List Patient"
    echo "6) Add Patient"
    echo "7) Delete Patient"
    echo "8) Update Patient"
    echo "9) assign nurse to patient"
    echo "CRTL + C To EXIT!"
    echo ""

    read userInput
    if [[ "$userInput" != [1-9] ]];then
    echo "Please Enter Value FROM 1 - 10"
    else
    case "$userInput" in
            1) list_nurse;;
            2) add_nurse;;
            3) delete_nurse;;
            4) update_nurse;;
            5) list_patient;;
            6) add_patient;;
            7) delete_patient;;
            8) update_patient;;
            9) assign_nurse_to_patient;;
            10) exit;;    
        esac
    fi
    
done
