# Bigcommerce using WSL

## Install WSL command

    wsl --install

By default, the installed Linux distribution will be Ubuntu.

## Lanch WSL

    wsl

## Lanch specific WSL

    wsl -d [Distro]

## Basic Linux setup

    sudo apt update && sudo apt upgrade -y
    
    sudo apt install build-essential git curl wget unzip -y

## Git config

    git config --global user.name "Your Name"

    git config --global user.email "your@email.com"

## generate ssh key (optional)

    ssh-keygen -t ed25519 -C "your@email.com"
    
    # Copy public key and add to git plateform
    cat ~/.ssh/id_ed25519.pub

    # Start the SSH agent
    eval "$(ssh-agent -s)"

    # Add ssh key
    ssh-add ~/.ssh/id_ed25519

## Install Node

    # Download and install nvm 
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    
    # Reload .bashrc so nvm command works
    source ~/.bashrc

    # Install and use supported node version
    nvm install 22

    nvm use 20.16.0

    # Check node version
    node -v

## Install BigCommerce Stencil

    npm install -g @bigcommerce/stencil-cli 

    #Check version
    stencil -V

## Organize projects under /home/username directory

    # ~ = /home/username
    mkdir ~/projects

## Create Stencil API credentials

- Go to Settings -> Store-level API accounts in the BigCommerce Admin
- Click on "Create API Accounts"
- Select Token type to "Stencil CLI token"
- Save the changes.

## Download theme from BigCommerce Admin and paste to the local repo

    mkdir -p ~/projects/project-name

    cd ~/projects/project-name
    
    cp /mnt/c/Users/WINDOWS-USERNAME/Downloads/theme-name.zip .

    unzip theme-name.zip

    rm theme-name.zip

## Connect to store

    # move into the theme's directory
    cd ~/projects/project-name

    # install theme modules
    npm install

    # create `.stencil` or `config.stencil.json` configuration file (if using Stencil V3.1 release or later)
    stencil init --url https://yourstore.com/ --token 19d3ae6-dc15-4af9-bead-a2c703aa7b --port 3000

    # Serve a live preview of the theme
    stencil start

## Useful Commands

    # Start development server
    stencil start

    # Bundle theme
    stencil bundle

    # Pulls the configuration from the active theme
    stencil pull

    # Push theme
    stencil push