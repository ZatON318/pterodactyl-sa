#!/bin/bash

ARCH=$(uname -i)

if [ "$ARCH" != "aarch64" ]; then
    dpkg --add-architecture i386
    apt update -y ; apt upgrade -y
    apt install -y openssl fontconfig dirmngr dnsutils libstdc++6 libtbb2:i386 libtbb-dev:i386 libicu-dev:i386
fi