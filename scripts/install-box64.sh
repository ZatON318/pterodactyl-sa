#!/bin/bash

ARCH=$(uname -i)

if [ "$ARCH" == "aarch64" ]; then
    apt update -y ; apt upgrade -y ; apt install -y gpg
    wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list && wget -O- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor | tee /usr/share/keyrings/box64-debs-archive-keyring.gpg
    apt update -y ; apt upgrade -y ;apt install box64 -y
fi