#!/bin/bash

set -e
set -u

# Function to handle conflicts
handle_conflict() {
    local target="$1"
    echo "Conflict found: $target already exists"
    while true; do
        read -pr "What would you like to do? [b]ackup/[r]emove/[s]kip: " choice
        echo "You entered: '$choice'" # Debugging line
        case "$choice" in
            b|B)
                if [[ ! -d "$HOME/.backup" ]]; then
                    echo "Creating ~/.backup..."
                    mkdir -p "$HOME/.backup"
                fi
                mv "$target" "$HOME/.backup/${target##*/}"
                echo "Backed up to ~/.backup/${target##*/}"
                break
                ;;
            r|R)
                rm -rf "$target"
                echo "Removed $target"
                break
                ;;
            s|S)
                echo "Skipping $target"
                break
                ;;
            *)
                echo "Invalid choice"
                ;;
        esac
    done
}

# Convert .stow-global-ignore patterns to `find` arguments
# 1. sed -e 's/^\/\?//'     : Remove optional leading '/' from patterns
# 2. sed -e 's/\.\*/\*/'    : Convert '.*' to '*' for shell globbing
# 3. grep -v '^$'           : Remove empty lines
# 4. sed 's/^/! -path "\.\//'   : Prefix each pattern with find's exclusion syntax
# 5. sed 's/$/"/'           : Add closing quote to pattern
# 6. tr '\n' ' '            : Join all patterns with spaces for find command
ignore_patterns=$(sed -e 's/^\/\?//' -e 's/\.\*/\*/' .stow-global-ignore | \
                 grep -v '^$' | \
                 sed 's/^/! -path "\.\//' | \
                 sed 's/$/"/' | \
                 tr '\n' ' ')

# Use find with the transformed patterns to list files
# - mindepth 1: Skip current directory
# - maxdepth 1: Only direct children
# - printf '%P\n': Print filenames without './' prefix
# - sed 's:/*$::': Remove trailing slashes from directory names
files_to_link=$(eval "find . -mindepth 1 -maxdepth 1 $ignore_patterns -printf '%P\n'" | \
                sed 's:/*$::')

# Check for conflicts
for file in $files_to_link; do
    [[ -z "$file" ]] && continue
    target="$HOME/$file"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        handle_conflict "$target"
    fi
done

# Use stow to create all symlinks
stow -v .
