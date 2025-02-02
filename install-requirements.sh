#!/bin/bash

set -e
set -u

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt update
apt install git curl gcc make clangd python3 python3-venv python-is-python3 pip python3-pynvim lua5.4 luarocks ripgrep fd-find -y
# python3-pip install --user --upgrade pynvim ## replaced with apt install python3-nvim

# Install JetBrainsMono Nerd Font
if [[ ! -e /usr/local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf ]]; then
  echo "Downloading JetBrainsMono Nerd Font..."
  set +e
  curl --retry 5 --retry-delay 3 -L -o JetBrainsMono.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
  [[  $? -ne 0 ]] && echo "Failed to download JetBrainsMono Nerd Font!" && exit 1
  set -e
  if [[ ! -d /usr/local/share/fonts ]]; then
    mkdir -p /usr/local/share/fonts
  fi
  tar -xf JetBrainsMono.tar.xz -C /usr/local/share/fonts
  rm JetBrainsMono.tar.xz
  echo "JetBrainsMono Nerd Font installed!"
fi
