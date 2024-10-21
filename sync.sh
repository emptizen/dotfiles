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
sync_file "$HOME/.ideavimrc" "idea/.zshrc"

echo "Dotfiles have been synced from your home directory to the "$PWD" directory."

# Check if there are changes to commit
if git diff-index --quiet HEAD --; then
    echo "No changes to commit"
else
    # Add all changes
    git add .

    # Commit changes with timestamp
    if git commit -m "Sync dotfiles $(date "+%Y-%m-%d %H:%M:%S")"; then
        # Push changes if commit was successful
        if git push; then
            echo "Changes pushed successfully"
        else
            echo "Failed to push changes"
        fi
    else
        echo "Failed to commit changes"
    fi
fi
