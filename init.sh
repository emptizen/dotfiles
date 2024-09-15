#! /usr/bin/env bash

# Add execute permission for all scripts
chmod +x init.sh
chmod +x sync.sh

# Add crontab entry to execute sync.sh every minute
# Check if the crontab entry already exists
if ! crontab -l 2>/dev/null | grep -q "$PWD/sync.sh"; then
    (crontab -l 2>/dev/null; echo "* * * * * $PWD/sync.sh") | crontab -
    echo "Crontab entry added to execute sync.sh every minute"
else
    echo "Crontab entry for sync.sh already exists"
fi


# Function to check if file exists and prompt for override
check_and_copy() {
    local source="$1"
    local target="$2"
    if [ -f "$target" ]; then
        read -p "File $target already exists. Override? (y/n): " choice
        case "$choice" in
            y|Y ) cp "$source" "$target"; echo "Copied $source to $target";;
            * ) echo "Skipped $target";;
        esac
    else
        cp "$source" "$target"
        echo "Copied $source to $target"
    fi
}

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
&& echo "Homebrew installed"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
&& echo "oh-my-zsh installed"

# Install vim-plug
curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
&& echo "vim-plug installed"

# Install sdkman
curl -s "https://get.sdkman.io" | bash \
&& echo "sdkman installed"

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash \
&& echo "nvm installed"


# Check and copy each dotfile
check_and_copy "git/.gitconfig" "$HOME/.gitconfig"
check_and_copy "vim/.vimrc" "$HOME/.vimrc"
check_and_copy "zsh/.zshrc" "$HOME/.zshrc"

echo "Dotfiles for git, vim, and zsh have been copied to your home directory."