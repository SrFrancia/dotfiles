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
linkDotFile .config/nvim/init.lua
linkDotFile .bashrc

# for file in $( ls -A .[a-zA-z]* | sed "s/[\&\;\|$$$$$$\{\}\$\`\~\!\@\#\%\^\*\+\=\-\/\:\;\"\'\ ]/\\\&/g" ); do
#     linkDotFile "'$file'"
# done
