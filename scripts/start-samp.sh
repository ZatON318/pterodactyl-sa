#!/bin/bash

START_FILE="samp03svr"
CONFIG_FILE="server.cfg"
SERVER_PORT=$1
MAX_PLAYERS=$2

YELLOW="\033[0;32m"
ERRORS=0

report_error() {
    echo -e "${YELLOW}$1"
    ERRORS=$((ERRORS + 1))
}

check_variables() {
    [ -z "$SERVER_PORT" ] && report_error "The variable 'SERVER_PORT' is undefined"
    [ -z "$MAX_PLAYERS" ] && report_error "The variable 'MAX_PLAYERS' is undefined"
    
    [ $ERRORS -gt 0 ] && exit 1
}

check_file_exists() {
    local file=$1
    local description=$2
    if [ ! -f "$file" ]; then
        report_error "The $description file does not exist."
        exit 1
    fi
}

update_config_value() {
    local key=$1
    local expected_value=$2
    local current_value=$(sed -n "s/^$key //p" "$CONFIG_FILE")
    
    if [ -z "$current_value" ]; then
        echo "$key $expected_value" >> "$CONFIG_FILE"
        echo -e "${YELLOW}The '$key' entry did not exist in your configuration file and was created with the value '$expected_value'."
    elif [ "$current_value" != "$expected_value" ]; then
        sed -i "s/^$key .*/$key $expected_value/" "$CONFIG_FILE"
        echo -e "${YELLOW}The '$key' value in the configuration file was different from the expected value. It has been modified."
    fi
}

main() {
    check_variables
    check_file_exists "$START_FILE" "start"
    check_file_exists "$CONFIG_FILE" "configuration"
    update_config_value "port" "$SERVER_PORT"
    update_config_value "maxplayers" "$MAX_PLAYERS"
    update_config_value "output" "1"

    ./"$START_FILE"
}

main
