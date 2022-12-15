FROM    --platform=$TARGETOS/$TARGETARCH ubuntu:20.04

LABEL   author="Dᥲᥒιᥱᥣ" maintainer="daniscript18@outlook.com"

ENV     DEBIAN_FRONTEND noninteractive

RUN     apt update -y ; apt upgrade -y
RUN     apt install -y libc++-dev libc6 git wget curl tar zip unzip binutils xz-utils liblzo2-2 cabextract iproute2 net-tools libatomic1 libsdl1.2debian libsdl2-2.0-0 libfontconfig icu-devtools libunwind8 libssl-dev sqlite3 libsqlite3-dev libmariadbclient-dev-compat libduktape205 locales ffmpeg gnupg2 apt-transport-https software-properties-common ca-certificates libz-dev rapidjson-dev tzdata libevent-dev libsdl2-mixer-2.0-0 libsdl2-image-2.0-0 build-essential cmake libgdiplus
RUN     apt install -y gcc g++ libgcc1 gdb netcat telnet init-system-helpers libcurl3-gnutls libjsoncpp1 liblua5.1-0 libluajit-5.1-2 libsqlite3-0 bzip2 zlib1g

RUN     wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list ; \
        wget -O- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor | tee /usr/share/keyrings/box64-debs-archive-keyring.gpg ; \
        apt update -y ; apt upgrade -y ; apt install box64 -y
        
RUN     useradd -d /home/container -m container
USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ./entrypoint.sh /entrypoint.sh
CMD     ["/bin/bash", "/entrypoint.sh"]
