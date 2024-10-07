#!/bin/bash
cd /home/container

export INTERNAL_IP=`ip route get 1 | awk '{print $(NF-2);exit}'`

if test -f start.sh;
then
    rm start.sh
    wget https://raw.githubusercontent.com/daniscript18/pterodactyl/master/scripts/start-samp.sh --no-hsts -q
    mv start-samp.sh start.sh
    chmod +x start.sh

else
    wget https://raw.githubusercontent.com/daniscript18/pterodactyl/master/scripts/start-samp.sh --no-hsts -q
    mv start-samp.sh start.sh
    chmod +x start.sh
fi

MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

eval ${MODIFIED_STARTUP}