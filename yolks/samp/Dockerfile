FROM        --platform=$TARGETOS/$TARGETARCH ubuntu:22.04

LABEL       author="daniscript18" maintainer="daniscript18@outlook.com"

ENV         DEBIAN_FRONTEND=noninteractive

RUN         apt update -y ; apt upgrade -y
RUN         apt install -y gpg gcc g++ libgcc1 libc++-dev gdb libc6 git wget curl tar zip unzip binutils xz-utils liblzo2-2 cabextract libatomic1 libsdl1.2debian libsdl2-2.0-0 libfontconfig icu-devtools libunwind8 sqlite3 libsqlite3-dev libmariadb-dev libzip4 locales apt-transport-https init-system-helpers libcurl3-gnutls liblua5.1-0 libluajit-5.1-2 libsqlite3-0 bzip2 zlib1g libevent-dev systemd iproute2 openssl dirmngr ca-certificates dnsutils tzdata tini
RUN         curl -s https://raw.githubusercontent.com/daniscript18/pterodactyl/master/scripts/dependencies-samp.sh | sh

RUN         useradd -d /home/container -m container
RUN         mkdir -p /run/systemd && echo 'docker' > /run/systemd/container
RUN         rm -rf /var/lib/apt/lists/*

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL  SIGINT

COPY        --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT  ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]