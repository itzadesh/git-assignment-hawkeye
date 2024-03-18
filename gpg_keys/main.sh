#!/bin/bash

source banner.sh
source gpg_manager.sh





# Main function
gpg_state=0

if which gpg >/dev/null; then 
    gpg_state=1
else
    gpg_state=0
    echo Please install gpg first.
    exit
fi



main() {
    while true; do
        display_banner
        read -p "Please enter your choice: " choice
        case $choice in
            1) create_gpg_keys ;;
            2) 
            echo "Signing GPG key to Git and GitHub..."
            existing_keys
            echo  -n "Enter the index of key which you want to sign: "
            read GPG_KEY_INDEX
            sign_gpg_key ${keys_array[GPG_KEY_INDEX-1]} ${keys_users[GPG_KEY_INDEX-1]};;
            3) delete_previous_keys ;;
            4) current_status ;;
            5) existing_keys ;;
            0) echo "Exiting... Thanks for using the gpg key manager"; exit ;;
            *) echo "Invalid choice. Please try again." ;;
        esac
    done
}

# Start the script
read_keys
main
