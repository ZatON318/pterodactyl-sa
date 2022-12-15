FROM    --platform=$TARGETOS/$TARGETARCH ubuntu:20.04

LABEL   author="Dᥲᥒιᥱᥣ" maintainer="daniscript18@outlook.com"

ENV     DEBIAN_FRONTEND noninteractive

RUN     apt update -y ; apt upgrade -y
RUN     apt install -y libc++-dev libc6 git wget curl tar zip unzip binutils xz-utils liblzo2-2 cabextract iproute2 net-tools libatomic1 libsdl1.2debian libsdl2-2.0-0 libfontconfig icu-devtools libunwind8 libssl-dev sqlite3 libsqlite3-dev libmariadbclient-dev-compat libduktape205 locales ffmpeg gnupg2 apt-transport-https software-properties-common ca-certificates libz-dev rapidjson-dev tzdata libevent-dev libsdl2-mixer-2.0-0 libsdl2-image-2.0-0 build-essential cmake libgdiplus
RUN     apt install -y gcc g++ libgcc1 gdb netcat telnet init-system-helpers libcurl3-gnutls libjsoncpp1 liblua5.1-0 libluajit-5.1-2 libsqlite3-0 bzip2 zlib1g

RUN     dpkg --add-architecture armhf ; \
        apt update -y ; apt upgrade -y ; \
        apt install -y libc6:armhf ; \
        apt install -y gcc-arm-linux-gnueabihf ; \
        git clone https://github.com/ptitSeb/box86 ; \
        cd box86 ; \
        mkdir build; cd build; cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo ; \
        make -j2 ; \
        make install

RUN     useradd -d /home/container -m container
USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ./entrypoint.sh /entrypoint.sh
CMD     ["/bin/bash", "/entrypoint.sh"]