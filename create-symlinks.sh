#!/bin/bash
readonly DIRNAME=dotfiles

function linkDotFile {
  file="$1"
  if [ ! -e ~/$file -a ! -L ~/$file ]; then
      yecho "$file not found, linking..." >&2
      ln -s ~/$DIRNAME/$file ~/$file
  else
      gecho "$file found, ignoring..." >&2
  fi
}

linkDotFile .bashrc
linkDotFile .bash_aliases
linkDotFile .bashrc

mkdir -p ~/$DIRNAME/.config/nvim/
linkDotFile .config/nvim/init.lua


# for file in $( ls -A .[a-zA-z]* | sed "s/[\&\;\|$$$$$$\{\}\$\`\~\!\@\#\%\^\*\+\=\-\/\:\;\"\'\ ]/\\\&/g" ); do
#     linkDotFile "'$file'"
# done
