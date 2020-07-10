cygenv
======

Bash customisation for Cygwin, Linux and OSX, specifically for Git use. Includes vundle setup for vim.

# Primary Installation
## Windows
Clone this repo and run `bash_install_win.bat`. That is all. This script automatically:
  1. installs Cygwin, or updates any existing installation in `C:\Cygwin`, with required packages.
  2. backs up any existing Cygwin home directory and makes Cygwin use the Windows home directory (usually your profile directory). This makes it easier for Cygwin to use Git for Windows.
  3. adds a default mintty configuration and shortcuts that improve on the default configuration.
  4. adds a .bashrc wrapper to your new home directory that calls the .bashrc file in this repo. This script is run every time you open a bash shell and contains customisations, enhancements and aliases (explained in the "cygenv Enhancements" section below).

:warning: Do not delete the cloned repo after installation, as the various bash scripts will be referenced directly out of this clone (only a wrapper script is added to your home directory).

Running `bash_install_win.bat` regularly will update Cygwin with the latest packages.

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

# Vundle Installation
## Windows
Run `install_vundle_win.bat`
## POSIX
* Create a symlink `~/.vimrc` to `_vimrc` in this repo
* Run: `git clone https://github.com/VundleVim/Vundle.vim.git ~/vimfiles/bundle/Vundle.vim`

## Setup Vundle on First Run
* Start vim and type `:PluginInstall`
