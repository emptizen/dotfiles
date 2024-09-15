#! /usr/bin/env bash

# Add execute permission for all scripts
chmod +x init.sh
chmod +x sync.sh

function add_cronjob() {
    # Add crontab entry to execute sync.sh every minute
    local script_path="${PWD}/sync.sh"
    # Check if the crontab entry already exists
    if ! crontab -l 2>/dev/null | grep -q "$script_path"; then
        (
            crontab -l 2>/dev/null
            echo "* * * * * $script_path"
        ) | crontab -
        echo "Crontab entry added to execute $script_path every minute"
    else
        echo "Crontab entry for $script_path already exists"
    fi
}

# Function to check if file exists and prompt for override
check_and_copy() {
    local source="$1"
    local target="$2"
    if [ -f "$target" ]; then
        read -p "File $target already exists. Override? (y/n): " choice
        case "$choice" in
        y | Y)
            cp "$source" "$target"
            echo "Copied $source to $target"
            ;;
        *) echo "Skipped $target" ;;
        esac
    else
        cp "$source" "$target"
        echo "Copied $source to $target"
    fi
}
# Function to install Homebrew
install_homebrew() {
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &&
        echo "Homebrew installed"
}

# Function to install oh-my-zsh
install_oh_my_zsh() {
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
        echo "oh-my-zsh installed"
}

# Function to install vim-plug
install_vim_plug() {
    echo "Installing vim-plug"
    curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&
        echo "vim-plug installed"
}

# Function to install sdkman
install_sdkman() {
    echo "Installing sdkman"
    curl -s "https://get.sdkman.io" | bash &&
        echo "sdkman installed"
}

# Function to install nvm
install_nvm() {
    echo "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash &&
        echo "nvm installed"
}

# Call the functions to install each tool
# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --cronjob)
            add_cronjob
            shift
            ;;
        --homebrew)
            install_homebrew
            shift
            ;;
        --oh-my-zsh)
            install_oh_my_zsh
            shift
            ;;
        --vim-plug)
            install_vim_plug
            shift
            ;;
        --sdkman)
            install_sdkman
            shift
            ;;
        --nvm)
            install_nvm
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# If no arguments were provided, print usage
if [ $# -eq 0 ]; then
    echo "Usage: $0 [--cronjob] [--homebrew] [--oh-my-zsh] [--vim-plug] [--sdkman] [--nvm]"
    echo "Use one or more options to install the desired tools."
fi

# Check and copy each dotfile
check_and_copy "git/.gitconfig" "$HOME/.gitconfig"
check_and_copy "vim/.vimrc" "$HOME/.vimrc"
check_and_copy "zsh/.zshrc" "$HOME/.zshrc"



echo "Dotfiles for git, vim, and zsh have been copied to your home directory."
