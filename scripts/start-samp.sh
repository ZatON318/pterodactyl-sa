#!/bin/bash

START_FILE="samp03svr"
CONFIG_FILE="server.cfg"
SAMPVOICE_START="sampvoice.out"
SAMPVOICE_CONFIG_0="voice.cfg"
SAMPVOICE_CONFIG_1="control.cfg"

SERVER_PORT=$1
MAX_PLAYERS=$2
SAMPVOICE=$3
SAMPVOICE_PORT=$4

YELLOW="\033[0;32m"
ERRORS=0

report_error() {
    echo -e "${YELLOW}$1"
    ERRORS=$((ERRORS + 1))
}

report_info() {
    echo -e "${YELLOW}$1"
}

check_variables() {
    [ -z "$SERVER_PORT" ] && report_error "The variable 'SERVER_PORT' is undefined"
    [ -z "$MAX_PLAYERS" ] && report_error "The variable 'MAX_PLAYERS' is undefined"
    [ -z "$SAMPVOICE" ] && report_error "The variable 'SAMPVOICE' is undefined"
    [ -z "$SAMPVOICE_PORT" ] && report_error "The variable 'SAMPVOICE_PORT' is undefined"
    
    [ $ERRORS -gt 0 ] && exit 1
}

check_file_exists() {
    local file=$1
    local description=$2
    local create_if_missing=$3

    if [ ! -f "$file" ]; then
        if [ "$create_if_missing" = true ]; then
            touch "$file"
            report_info "The $description file did not exist and was created."
        else
            report_error "The $description file does not exist."
            exit 1
        fi
    fi
}

update_config_value() {
    local key=$1
    local expected_value=$2
    local uconfig_file=$3
    local separator=$4

    local current_value=$(sed -n "s/^$key$separator//p" "$uconfig_file")
    
    if [ -z "$current_value" ]; then
        echo "$key$separator$expected_value" >> "$uconfig_file"
        report_info "The '$key' entry did not exist in your configuration file and was created with the value '$expected_value'."
    elif [ "$current_value" != "$expected_value" ]; then
        sed -i "s/^$key$separator.*/$key$separator$expected_value/" "$uconfig_file"
        report_info "The '$key' value in the configuration file was different from the expected value. It has been modified."
    fi
}

sampvoice_files() {
    if [ -f "$SAMPVOICE_START" ]; then
        rm ./"$SAMPVOICE_START"
    fi
    curl -Lo sv_voice.zip https://github.com/CyberMor/sampvoice/releases/latest/download/sv_voice.zip
    unzip -n sv_voice.zip
    rm sampvoice.exe voice.cfg sv_voice.zip
    chmod 755 sampvoice.out
}

main() {
    check_variables
    
    check_file_exists "$START_FILE" "start" false
    check_file_exists "$CONFIG_FILE" "configuration" false

    update_config_value "port" "$SERVER_PORT" "$CONFIG_FILE" " "
    update_config_value "maxplayers" "$MAX_PLAYERS" "$CONFIG_FILE" " "
    update_config_value "output" "1" "$CONFIG_FILE" " "

    if [ "$SAMPVOICE" == "1" ]; then
        sampvoice_files

        check_file_exists "$SAMPVOICE_CONFIG_0" "sampvoice voice configuration" true
        check_file_exists "$SAMPVOICE_CONFIG_1" "sampvoice control configuration" true

        update_config_value "control_host" "localhost" "$SAMPVOICE_CONFIG_0" " = "
        update_config_value "control_port" "$SAMPVOICE_PORT" "$SAMPVOICE_CONFIG_0" " = "
        update_config_value "voice_host" "0.0.0.0" "$SAMPVOICE_CONFIG_0" " = "
        update_config_value "voice_port" "$SAMPVOICE_PORT" "$SAMPVOICE_CONFIG_0" " = "

        update_config_value "control_host" "localhost" "$SAMPVOICE_CONFIG_1" " = "
        update_config_value "control_port" "$SAMPVOICE_PORT" "$SAMPVOICE_CONFIG_1" " = "
        update_config_value "voice_host" "0.0.0.0" "$SAMPVOICE_CONFIG_1" " = "
        update_config_value "voice_port" "$SAMPVOICE_PORT" "$SAMPVOICE_CONFIG_1" " = "
        
        update_config_value "sv_port" "$SAMPVOICE_PORT" "$CONFIG_FILE" " "

        if [ $(dpkg --print-architecture) = "arm" ] || [ $(dpkg --print-architecture) = "arm64" ]; then
            box86 ./"$SAMPVOICE_START" &
        else
            ./"$SAMPVOICE_START" &
        fi
    fi
    if [ $(dpkg --print-architecture) = "arm" ] || [ $(dpkg --print-architecture) = "arm64" ]; then
        box86 ./"$START_FILE"
    else
        ./"$START_FILE"
    fi
}

main
