#!/bin/bash

ARCH=$(uname -i)

if [ "$ARCH" == "aarch64" ]; then
    apt update -y ; apt upgrade -y ; apt install -y build-essential cmake make python3
    dpkg --add-architecture armhf ; apt update -y ; apt upgrade -y ; apt install -y libc6:armhf gcc-arm-linux-gnueabihf
    git clone https://github.com/ptitSeb/box86 && cd box86 ; mkdir build ; cd build ; cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo ; make -j2 ; make install && cd .. ; cd .. ; rm -rf box86
fi