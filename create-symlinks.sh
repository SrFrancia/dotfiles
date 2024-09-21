#!/bin/bash

function linkDotFile {
  file="$1"
  if [ ! -e ~/$file -a ! -L ~/$file ]; then
      yecho "$file not found, linking..." >&2
      ln -s ~/dotfiles/$file ~/$file
  else
      gecho "$file found, ignoring..." >&2
  fi
}

for file in $( ls -A .[a-zA-z]* | sed "s/[\&\;\|$$$$$$\{\}\$\`\~\!\@\#\%\^\*\+\=\-\/\:\;\"\'\ ]/\\\&/g" ); do
    linkDotFile "'$file'"
done
