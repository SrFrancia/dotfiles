#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Por favor ejecuta como root"
  exit
fi

set -e
set -u

# Add Neovim unstable ppa
echo "Neovim unstable PPA va a ser añadido, dale a ENTER cuando se pida"
add-apt-repository ppa:neovim-ppa/unstable

apt update
apt install git neovim curl gcc make shellcheck lua5.4 ripgrep fd-find bat -y

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
else
  echo "JetBrainsMono Nerd Font ya estaba instalado!"
fi
