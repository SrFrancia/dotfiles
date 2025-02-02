#!/bin/bash

set -e
set -u

readonly RCol='\033[0m'
readonly Gre='\033[0;32m'
readonly Yel='\033[0;33m'
readonly DIRNAME=dotfiles

## printing functions ##
function gecho {
  echo "${Gre}[message] $1${RCol}"
}

function yecho {
  echo "${Yel}[warning] $1${RCol}"
}

function linkDotFile {
  file="$1"
  if [[ ! -e ~/$file -a ! -L ~/$file ]]; then
      yecho "$file not found, linking..." >&2
      ln -s ~/$DIRNAME/$file ~/$file
  else
      gecho "$file found, ignoring..." >&2
  fi
}

linkDotFile .bashrc
linkDotFile .bash_aliases

if [[ ! -d ~/.config || ! -d ~/.config/nvim ]]; then
  mkdir -p ~/.config/nvim
fi
linkDotFile .config/nvim/init.lua
