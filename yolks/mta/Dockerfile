##      BASE IMAGE
FROM    --platform=$TARGETOS/$TARGETARCH ubuntu:latest

##      SOME LABELS SO YOU KNOW I DID IT :D
LABEL   author="Dᥲᥒιᥱᥣ" maintainer="daniscript18@outlook.com"

##      DEFAULT RESPONSE FOR EACH INTERACTION WHILE INSTALLING
ENV     DEBIAN_FRONTEND noninteractive

##      UPDATE OF THE LIST OF REPOSITORIES
RUN     apt update -y ; apt upgrade -y

##      INSTALLATION OF SOME GENERAL ROOMS
RUN     apt install -y gcc g++ libgcc1 libc++-dev gdb libc6 git wget curl tar zip unzip binutils xz-utils liblzo2-2 cabextract iproute2 net-tools netcat telnet libatomic1 libsdl1.2debian libsdl2-2.0-0 libfontconfig icu-devtools libunwind8 sqlite3 libsqlite3-dev libmariadb-dev libzip4 locales ffmpeg apt-transport-https init-system-helpers libcurl3-gnutls liblua5.1-0 libluajit-5.1-2 libsqlite3-0 bzip2 zlib1g libevent-dev systemd

##      INSTALLING BOX64 FOR ARM PROCESSORS
RUN     wget https://raw.githubusercontent.com/daniscript18/pterodactyl-tools/master/scripts/install-box64.sh && \
        bash install-box64.sh && \
        rm install-box64.sh

##      MTA BRANCHES
RUN     apt install -y libncursesw5 ; \
        wget -P /usr/lib/ https://nightly.mtasa.com/files/modules/64/libmysqlclient.so.16

##      CREATION OF THE "CONTAINER" USER
RUN     useradd -m -d /home/container -s /bin/bash container

##      VARIABLES THAT WILL BE USED LATER IN PTERODACTYL
ENV     USER=container HOME=/home/container

##      ESTABLISHMENT OF THE WORK AREA
WORKDIR /home/container

##      WE COPY THE EXECUTABLE TO THE CONTAINER
COPY    ./entrypoint.sh /entrypoint.sh

##      MAIN GOAL
CMD     [ "/bin/bash", "/entrypoint.sh" ]