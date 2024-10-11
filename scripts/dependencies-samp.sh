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
    else
        dpkg --add-architecture i386
        apt update -y ; apt upgrade -y
        apt install -y libstdc++6 lib32stdc++6 tar wget curl iproute2 openssl fontconfig dirmngr ca-certificates dnsutils tzdata zip
        if [ "$(uname -m)" = "x86_64" ]; then \
            wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_i386.deb && \
            dpkg -i libssl1.1_1.1.0g-2ubuntu4_i386.deb && \
            rm libssl1.1_1.1.0g-2ubuntu4_i386.deb; \
        fi
    fi
}

main() {
    install_box86
}

main