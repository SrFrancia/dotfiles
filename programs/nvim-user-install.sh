#!/bin/bash
if [[ ! -d "$HOME"/.local/bin/ ]]; then
  mkdir -p "$HOME"/.local/bin/
fi

kernel=$(uname -s)
arch=$(uname -i)
if [[ "$arch" -ne "x86_64" || "$kernel" -ne "Linux" ]]; then
  echo "Arquitectura o Kernel no soportados"
  exit 1
fi
echo "[1] v0.11.4"
echo "[2] v0.10.4"
echo "[3] v0.9.5"
read -rp "Indique la versión por su índice: " version
case "$version" in
  1)
    wget https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage -O "$HOME"/.local/bin/nvim
    chmod +x "$HOME"/.local/bin/nvim
    break
    ;;
  2)
    wget https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.appimage -O "$HOME"/.local/bin/nvim
    chmod +x "$HOME"/.local/bin/nvim
    break
    ;;

  3)
    wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage -O "$HOME"/.local/bin/nvim
    chmod +x "$HOME"/.local/bin/nvim
    break
    ;;
  *)
    echo "Opcion no reconocida, saliendo"
    exit 1
    ;;
esac

# Comprobamos si existe el alias vim=nvim en .bash_aliases
# o .bashrc en su defecto, y si no está lo añadimos
if [[ 
    -e "$HOME"/.bash_aliases &&
    $(grep -c "alias vim='nvim'" "$HOME"/.bash_aliases) -eq 0
  ]]; then
  echo "alias vim='nvim'" >>"$HOME"/.bash_aliases
elif [[ 
    -e "$HOME"/.bashrc &&
    $(grep -c "alias vim='nvim'" "$HOME"/.bashrc) -eq 0
  ]]; then
  echo "alias vim='nvim'" >>"$HOME"/.bashrc
fi

# Comprobamos que $HOME/.local/bin esté en $PATH
if [[ $(echo "$PATH" | grep -c "$HOME/.local/bin") -eq 0 ]]; then
  export PATH="$PATH:$HOME/.local/bin"
fi
