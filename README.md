cygenv
======

Bash customisation for Windows, Linux and OSX.

# Primary Installation
## Windows
Clone this repo and run `bash_install_win.bat`.

## Linux and OSX
Clone this repo and create a `~/.bashrc` symlink to the `.bashrc` file in this repo. Create a `~/bashrc_custom` file and add any custom commands in there; it is run after .bashrc finishes.

## Usage and Enhanced Functionality
See [Usage.md](Usage.md)

# Configure Git
```
git config --global user.email "falconne@gmail.com"
git config --global user.name "Anuradha Dissanayake"
git config --global push.default simple
```

# Font Installation
## Windows
Install fonts from `fonts` directory.

## Ubuntu
sudo apt-get install -y ttf-anonymous-pro
