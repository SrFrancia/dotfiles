#!/bin/bash

set -e
set -u

# Create required directories if they don't exist
mkdir -p ~/.config/nvim

# Use stow to create all symlinks
stow -v .
