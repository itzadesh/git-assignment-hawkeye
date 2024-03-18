read_keys () {
    mapfile -t keys_array < <(gpg --list-secret-keys --keyid-format=long | awk '/sec/ {print $2}' | awk -F '/' '{print $2}')
    mapfile -t keys_dates < <(gpg --list-secret-keys --keyid-format=long | awk '/sec/ {print $3}')
    mapfile -t keys_users < <(gpg --list-secret-keys --keyid-format=long | awk '/uid/ {print $3 ","$4}')

}

current_status () {
    echo 
    echo "---------------------------------------------------------"
    echo -n "CURRENT-USER: " 
    git config --list | awk -F '=' '/user.name/ {print $2}'
    echo -n "CURRENT-EMAIL: " 
    git config --list | awk -F '=' '/user.email/ {print $2}'
    echo -n "CURRENT-KEYID: " 
    git config --list | awk -F '=' '/user.signingkey/ {print $2}'
}

existing_keys() {
    echo 
    echo "---------------------------------------------------------"
    echo "Current gpg keys are as follows: "
    echo 
    i=1
    for key in ${keys_array[@]}
    do
    echo "$i | KEY-ID - ${keys_array[$((i - 1))]} | DATE-CREATED - ${keys_dates[$((i - 1))]}  | USER-ID - ${keys_users[$((i - 1))]} "
    ((i++))
    done
}


# Function to create GPG keys
create_gpg_keys() {
    echo "Creating GPG key..."
    gpg --full-generate-key
    read_keys
    GPG_KEY_ID=${keys_array[-1]}
    USER_ID=${keys_users[-1]}
    echo 
    echo "--------------------------------------------"
    echo "GPG Key created with ID : $GPG_KEY_ID"
    echo "--------------------------------------------"
    sign_gpg_key $GPG_KEY_ID $USER_ID
    
}
#Keys array and dates array need to update after the new key generation process

# Function to sign GPG key to Git and GitHub
sign_gpg_key() {
    local GPG_Key=$1
    local USER_ID=$2
    local USER_NAME=$(echo $USER_ID | awk -F ',' '{print $1}')
    local USER_EMAIL=$(echo $USER_ID | awk -F ',' '{print $2}' | tr -d '<>')
    echo "------------------------------------------------------------"
    git config --global user.signingkey $GPG_Key
    git config --global user.name $USER_NAME
    git config --global user.email $USER_EMAIL
    git config --global commit.gpgsign true
    echo
    echo "Copy And Paste the following PGP Public Key Block in GitHub"
    echo "------------------------------------------------------------"
    gpg --armor --export "$GPG_Key"
    echo "----------------------------------------------------------"
    echo "Congrats your key is fully set and ready to be used."
    
}

# Function to delete previous GPG keys
delete_previous_keys() {
    existing_keys
    echo "Enter index of key which you want to delete : "
    read ID_index
    gpg --delete-secret-key ${keys_array[$((ID_index - 1))]}
    gpg --delete-key ${keys_array[$((ID_index - 1))]}
    read_keys
}