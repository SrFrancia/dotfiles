#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Por favor ejecuta como root"
  exit
fi

installTerminator() {
  apt install terminator
  # Sets the default terminal to termiantor
  if [ "$XDG_CURRENT_DESKTOP" == "X-Cinnamon" ]; then
    gsettings set org.cinnamon.desktop.default-applications.terminal exec 'terminator'
  fi
}

apt update
installTerminator
