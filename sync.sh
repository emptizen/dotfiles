#! /usr/bin/env bash

# Change to the directory of the current script
cd "$(dirname "$0")"

# Function to merge files
sync_file() {
    local source="$1"
    local target="$2"
    if [ ! -f "$source" ]; then
        echo "Source file $source does not exist. Skipping."
    elif [ ! -f "$target" ]; then
        echo "Target file $target does not exist. Skipping."
    else
        echo "Syncing $source to $target"
        cp "$source" "$target"
    fi
}

sync_file "$HOME/.gitconfig" "git/.gitconfig" 
sync_file "$HOME/.vimrc" "vim/.vimrc"
sync_file "$HOME/.zshrc" "zsh/.zshrc"

echo "Dotfiles have been synced from your home directory to the "$PWD" directory."

git add . 
git commit -m "Sync dotfiles $(date "+%Y-%m-%d %H:%M:%S")"
git push
