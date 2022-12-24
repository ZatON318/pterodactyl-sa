#!/bin/bash

# GET INTERNAL IP ADDRESS
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')

# EXPORT INTERNAL IP ADDRESS
export INTERNAL_IP

# GO TO THE DIRECTORY
cd /home/container

# CHECK IF "START.SH" EXISTS
if test -f start.sh;
then # IF IT EXISTS

    #WE DELETE WHAT EXISTS
    rm start.sh

    # WE DOWNLOAD THE FILE AGAIN
    wget wget https://raw.githubusercontent.com/daniscript18/pterodactyl/master/scripts/start-mta.sh --no-hsts

    # WE RENAME IT
    mv start-mta.sh start.sh

    # WE MAKE IT EXECUTABLE
    chmod +x start.sh

    # CONSOLE CLEAN
    clear
    
else # IF NOT EXISTS

    # WE DOWNLOAD THE FILE AGAIN
    wget wget https://raw.githubusercontent.com/daniscript18/pterodactyl/master/scripts/start-mta.sh --no-hsts

    # WE RENAME IT
    mv start-mta.sh start.sh

    # WE MAKE IT EXECUTABLE
    chmod +x start.sh

    # CONSOLE CLEAN
    clear
    
fi

# CREATING START COMMAND
MODIFIED_STARTUP=$(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')

# RUN START COMMAND
eval ${MODIFIED_STARTUP}