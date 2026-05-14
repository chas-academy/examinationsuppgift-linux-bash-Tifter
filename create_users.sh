#!/bin/bash
# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Måste köras som root"
    exit
fi


# List of all beforehand created users with home directories
ALL_USERS=$(ls /home/)


# Create users
for user in $@
do
    # Check if user already exists
    if id "$user" &>/dev/null; then
        echo "User $user already exists"
        
    # Create user if it does not exist
    else
        useradd -m "$user"
        mkdir "/home/$user/Documents/"
        mkdir "/home/$user/Downloads/"
        mkdir "/home/$user/Work/"
        echo "Välkommen $user" > "/home/$user/welcome.txt"
        echo "$ALL_USERS" >> "/home/$user/welcome.txt"       
        chown -R "$user:$user" "/home/$user/"
        chmod -R 700 "/home/$user/"
        echo "User $user created"
    fi
done
