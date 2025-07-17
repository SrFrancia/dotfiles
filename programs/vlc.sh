#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Por favor ejecuta como root"
  exit
fi

installVLC() {
  apt install vlc
}

apt update
installVLC
