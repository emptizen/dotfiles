# Dotfiles Management

This repository contains scripts and configuration files to manage your dotfiles across different machines.

## Features

- Initialize and sync dotfiles
- Install various development tools
- Set up cron jobs for automatic syncing local dotfiles to remote repository

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/emptizen/dotfiles.git
   cd dotfiles
   ```

2. Make the scripts executable:
   ```
   chmod +x init.sh sync.sh
   ```

## Usage

### Initialization

To set up your dotfiles and install development tools, run:
```zsh
./init.sh
```

### Syncing

To sync your dotfiles, run:
```zsh
./sync.sh
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.