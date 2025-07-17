#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Por favor ejecuta como root"
  exit
fi

installSteam() {
  apt install steam
}

apt update
installSteam
