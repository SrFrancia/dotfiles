#!/bin/bash


if [ "$EUID" -ne 0 ]
  then echo "Por favor ejecuta como root"
  exit
fi

set -e
set -u

function check_preq {
  (command -v $1 > /dev/null  && echo "$1 encontrado.") || 
    (echo "$1 no encontrado, instala antes de seguir." && exit 1)
}

check_preq nvim

apt update
apt install git curl gcc make clangd python3 python3-venv python-is-python3 pip python3-pynvim lua5.4 luarocks ripgrep fd-find stow -y
# python3-pip install --user --upgrade pynvim ## replaced with apt install python3-nvim

# Install JetBrainsMono Nerd Font
if [[ ! -e /usr/local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf ]]; then
  echo "Descargando JetBrainsMono Nerd Font..."
  curl --retry 5 --retry-delay 3 --retry-all-errors -L -o JetBrainsMono.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
  if [[ ! -d /usr/local/share/fonts ]]; then
    mkdir -p /usr/local/share/fonts
  fi
  tar -xf JetBrainsMono.tar.xz -C /usr/local/share/fonts
  rm JetBrainsMono.tar.xz
  echo "JetBrainsMono Nerd Font instalado!"
fi
