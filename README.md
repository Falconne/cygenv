cygenv
======

Bash customisation for Cygwin, Linux and OSX

# Installation
## Windows
Clone this repo and run bash_install_win.bat. This will:
  1. Install Cygwin, or update any existing installation in C:\Cygwin, with required packages.
  2. Backup any existing Cygwin home directory and make Cygwin use the Windows home directory (usually your profile directory). This makes it easier for Cygwin to use Git for Windows.
  3. Add a default mintty configuration and shortcuts that improve on the default configuration.

:heavy_exclamation_mark: Do not delete the cloned repo after installation, as the various bash scripts will be referenced directly out of this clone (only a wrapper script is added to your home directory).

## Linux and OSX
Clone this repo and create a ~/.bashrc symlink to the .bashrc file in this repo.

# Usage
## Launching Cygwin Terminal
Run the shortcut called "Cygwin Terminal". This will open mintty.