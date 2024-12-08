#!/bin/bash

# A launcher for the phoebus container that allows X11 forwarding

# To customise for your own kubernetes namespace change the following variables
OPIS_IP=172.23.168.169          # IP address of the epics-opis service
GATEWAYS_IP=172.23.168.200      # IP address of the gateways service

# These should not need to be changed:
CA=9064 PVA=9065

if [[ -n $TUNNEL ]]; then
    echo "Tunneling through $GATEWAYS_IP ..."
    GATEWAYS_IP=localhost
    echo
    echo "make sure you are running this command in another terminal:"
    echo "ssh -L $CA:$GATEWAYS_IP:$CA -L $PVA:$GATEWAYS_IP:$PVA YOUR_FED_ID@YOUR_WORKSTATION sleep 99d"
    echo
fi

# decide on docker or podman based on what is available
if [[ $(docker --version 2>/dev/null) == *Docker* && -z $PODMAN ]]; then
    docker=docker
    args="--user $(id -u):$(id -g) "
    xhost +SI:localuser:$(id -un) # allow local user uid to access X11 server
else
    docker=podman
fi

x11="-e DISPLAY -v /tmp:/tmp --net=host"
args+="--rm --name phoebus --security-opt label=disable"

echo "
org.phoebus.pv.pva/epics_pva_name_servers=$GATEWAYS_IP:$PVA
org.phoebus.pv.ca/name_servers=$GATEWAYS_IP:$CA
" > /tmp/settings.ini

# settings for p47
settings="
-resource http://$OPIS_IP/t03-beamline.bob
-settings /tmp/settings.ini
"

echo "Starting phoebus container ..."
set -x
$docker run ${args} ${x11} \
  ghcr.io/epics-containers/ec-phoebus:latest \
  ${settings} "${@}" &> /tmp/phoebus.log &
