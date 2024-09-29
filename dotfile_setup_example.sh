#!/bin/bash
# This function is adapted from dotfiles by bushalin https://github.com/bushalin/dotfiles

set -e
set -u

readonly RCol='\033[0m'
readonly Gre='\033[0;32m'
readonly Red='\033[0;31m'
readonly Yel='\033[0;33m'
readonly DIRNAME=dotfiles

## printing functions ##
function gecho {
  echo "${Gre}[message] $1${RCol}"
}

function yecho {
  echo "${Yel}[warning] $1${RCol}"
}

function wecho {
  # red, but don't exit 1
  echo "${Red}[error] $1${RCol}"
}


function recho {
  echo "${Red}[error] $1${RCol}"
  exit 1
}

## install functions ##

# check for pre-req, fail if not found
function check_preq {
  (command -v $1 > /dev/null  && gecho "$1 found...") || 
    recho "$1 no encontrado, instala antes de seguir."
}

# function for linking dotfiles
function linkdotfile {
  file="$1"
  if [ ! -e ~/$file -a ! -L ~/$file ]; then
      yecho "$file not found, linking..." >&2
      ln -s ~/$DIRNAME/$file ~/$file
  else
      gecho "$file found, ignoring..." >&2
  fi
}

# are we in right directory?
[[ $(basename $(pwd)) == "dotfiles" ]] || 
  recho "doesn't look like you're in dotfiles/"

# check that the key pre-requisites are met:
# since this script is system agnostic, we fail if 
# these aren't installed, and ask user to install
# manually
check_preq nvim

# link over .gitconfig
linkdotfile .gitconfig
linkdotfile .gitattributes

# link over .tmux.conf
linkdotfile .tmux.conf

# se crea la carpeta .config/nvim
mkdir -p ~/.config/nvim/init.lua
# link NeoVim settings
linkdotfile .config/nvim/init.lua


# create a global Git ignore file
if [ ! -e ~/.global_ignore ]; then
    yecho "~/.global_ignore not found, curling from Github..." >&2
    curl \
      https://raw.githubusercontent.com/github/gitignore/main/Global/Linux.gitignore \
      https://raw.githubusercontent.com/github/gitignore/main/Global/Vim.gitignore \
      https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore \
      https://raw.githubusercontent.com/github/gitignore/main/C++.gitignore \
      https://raw.githubusercontent.com/github/gitignore/main/Global/LibreOffice.gitignore \
    > ~/.global_ignore 2> /dev/null
    git config --global core.excludesfile ~/.global_ignore && 
      yecho "[message] adding ignore file to Git..." >&2
else
    gecho "~/.global_ignore found, ignoring..." >&2
fi
