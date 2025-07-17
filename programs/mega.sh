#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Por favor ejecuta como root"
  exit
fi

installMega() {
  wget https://mega.nz/linux/repo/xUbuntu_24.04/amd64/megasync-xUbuntu_24.04_amd64.deb && apt install "$PWD/megasync-xUbuntu_24.04_amd64.deb" && rm megasync-xUbuntu_24.04_amd64.deb
}

installMega
