#!/bin/bash

# Function to display the welcome banner
display_banner() {
    echo "-------------------------------------------"
    echo "Welcome to GPG Key Management Script"
    echo "-------------------------------------------"
    echo "Press 1 to create GPG keys"
    echo "Press 2 to sign GPG key to Git and GitHub"
    echo "Press 3 to delete any other previous GPG keys"
    echo "Press 0 to quit"
    echo "-------------------------------------------"
    echo "Current gpg keys are as follows"
    gpg --list-secret-keys --keyid-format=long
}