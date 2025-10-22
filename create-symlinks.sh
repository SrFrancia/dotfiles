#!/bin/bash

set -e
set -u

# Function to handle conflicts
# Receives the target file path as an argument
# returns: 1 if the user chooses to skip, 0 otherwise
handle_conflict() {
    local target="$1"
    echo "Conflicto encontrado: $target ya existe"
    while true; do
        read -rp "¿Qué quieres hacer con él? [b]ackup/[r]emove/[s]kip: " choice
        case "$choice" in
            b|B)
                if [[ ! -d "$HOME/.backup" ]]; then
                    echo "Creado ~/.backup..."
                    mkdir -p "$HOME/.backup"
                fi
                mv "$target" "$HOME/.backup/${target##*/}"
                echo "Creada copia en ~/.backup/${target##*/}"
                break
                ;;
            r|R)
                rm -rf "$target"
                echo "Borrado $target"
                break
                ;;
            s|S)
                echo "Saltando $target"
                break
                ;;
            *)
                echo "Opción inválida"
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
        if [ ! -e "$target" ]; then
            ln -s "$PWD/$file" "$target"
            echo "Creado link para: $target"
        fi
    elif [ -L "$target" ]; then
        echo "El link ya estaba creado: $target"
    else
        ln -s "$PWD/$file" "$target"
        echo "Creado link para: $target"
    fi
done
