#!/bin/bash

install_box86() {
    if [ $(dpkg --print-architecture) = "arm" ] || [ $(dpkg --print-architecture) = "arm64" ]; then
        if [ -f /etc/apt/sources.list.d/box86.list ]; then
            rm -f /etc/apt/sources.list.d/box86.list || exit 1
        fi
        if [ -f /etc/apt/sources.list.d/box86.sources ]; then
            rm -f /etc/apt/sources.list.d/box86.sources || exit 1
        fi
        if [ -f /usr/share/keyrings/box86-archive-keyring.gpg ]; then
            rm -f /usr/share/keyrings/box86-archive-keyring.gpg
        fi
        mkdir -p /usr/share/keyrings
        wget -qO- "https://pi-apps-coders.github.io/box86-debs/KEY.gpg" | gpg --dearmor -o /usr/share/keyrings/box86-archive-keyring.gpg
echo "Types: deb
URIs: https://Pi-Apps-Coders.github.io/box86-debs/debian
Suites: ./
Signed-By: /usr/share/keyrings/box86-archive-keyring.gpg" | tee /etc/apt/sources.list.d/box86.sources >/dev/null
        apt update -y
        if [ $(dpkg --print-architecture) = "arm64" ]; then
            dpkg --add-architecture armhf && apt-get update -y
            apt-get install libc6:armhf -y
            apt install box86-generic-arm:armhf -y
        else
            apt install box86-generic-arm -y
        fi
    fi
}

main() {
    install_box86
}

main