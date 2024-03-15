

# Function to create GPG keys
create_gpg_keys() {
    echo "Creating GPG key..."
    gpg --full-generate-key
    GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | awk '{print substr($0, 9, 16)}' | tail -n 1)
    echo "GPG Key created with ID : $GPG_KEY_ID"
    sign_gpg_key $GPG_KEY_ID
}

# Function to sign GPG key to Git and GitHub
sign_gpg_key() {
    local GPG_Key=$1
    git config --global user.signingkey $GPG_Key
    git config --global commit.gpgsign true
    
    echo "------------------------------------------------------------"
    gpg --armor --export "$GPG_Key"
    echo "----------------------------------------------------------"
    echo "Copy And Paste this Key in GitHub"
}

# Function to delete previous GPG keys
delete_previous_keys() {
    echo "Enter Secret_key :- "
        read ID
        gpg --delete-secret-key $ID
        gpg --delete-key $ID
}