#!/bin/bash

set -e
set -u

# Function to handle conflicts
# Receives the target file path as an argument
# returns: 1 if the user chooses to skip, 0 otherwise
handle_conflict() {
    local target="$1"
    echo "Conflict found: $target already exists"
    while true; do
        read -p "What would you like to do? [b]ackup/[r]emove/[s]kip: " choice
        case "$choice" in
            b|B)
                if [[ ! -d "$HOME/.backup" ]]; then
                    echo "Creating ~/.backup..."
                    mkdir -p "$HOME/.backup"
                fi
                mv "$target" "$HOME/.backup/${target##*/}"
                echo "Backed up to ~/.backup/${target##*/}"
                return 0
                ;;
            r|R)
                rm -rf "$target"
                echo "Removed $target"
                return 0
                ;;
            s|S)
                echo "Skipping $target"
                return 1
                ;;
            *)
                echo "Invalid choice"
                ;;
        esac
    done
}

files_to_link=$(cat files-to-link.txt)

# Check for conflicts
for file in $files_to_link; do
    # Skip if the file is empty
    [[ -z "$file" ]] && continue
    target="$HOME/$file"
    # Check if the target exists and is not a symlink to handle conflicts
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        handle_conflict "$target"
        if [ $? -eq 0 ]; then
            ln -s "$PWD/$file" "$target"
            echo "Linked: $target"
        fi
    elif [ -L "$target" ]; then
        echo "Already linked: $target"
    else
        ln -s "$PWD/$file" "$target"
        echo "Linked: $target"
    fi
done
