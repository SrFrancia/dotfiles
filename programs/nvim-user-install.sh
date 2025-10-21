#!/bin/bash
if [[ ! -d "$HOME"/.local/bin/ ]]; then
  mkdir -p "$HOME"/.local/bin/
fi
wget https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage -O "$HOME"/.local/bin/nvim
chmod +x "$HOME"/.local/bin/nvim

# Comprobamos si existe el alias vim=nvim en .bash_aliases
# o .bashrc en su defecto, y si no está lo añadimos
if [[ 
  -e "$HOME"/.bash_aliases &&
  $(grep -c "alias vim='nvim'" "$HOME"/.bash_aliases) -eq 0 ]] \
  ; then
  echo "alias vim='nvim'" >>"$HOME"/.bash_aliases
elif [[ 
  -e "$HOME"/.bashrc &&
  $(grep -c "alias vim='nvim'" "$HOME"/.bashrc) -eq 0 ]] \
  ; then
  echo "alias vim='nvim'" >>"$HOME"/.bashrc
fi
