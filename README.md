cygenv
======

Bash customisation for Cygwin, Linux and OSX, specifically for Git use.

# Installation
## Windows
Clone this repo and run `bash_install_win.bat`. That is all. This script automatically:
  1. installs Cygwin, or updates any existing installation in `C:\Cygwin`, with required packages.
  2. backs up any existing Cygwin home directory and makes Cygwin use the Windows home directory (usually your profile directory). This makes it easier for Cygwin to use Git for Windows.
  3. adds a default mintty configuration and shortcuts that improve on the default configuration.
  4. adds a .bashrc wrapper to your new home directory that calls the .bashrc file in this repo. This script is run every time you open a bash shell and contains customisations, enhancements and aliases (explained in the "cygenv Enhancements" section below).

:warning: Do not delete the cloned repo after installation, as the various bash scripts will be referenced directly out of this clone (only a wrapper script is added to your home directory).

Running `bash_install_win.bat` regularly will update Cygwin with the latest packages.

## Linux and OSX
Clone this repo and create a `~/.bashrc symlink` to the `.bashrc` file in this repo. Create a `~/bashrc_custom` file and add any custom commands in there; it is run after .bashrc finishes.

# Usage
## Launching Cygwin Terminal
Run the shortcut called "Cygwin Terminal" (in the Start Menu and the Desktop). This will open mintty.

## Terminal Basics
If you haven't used a Linux terminal much, this section explains some differences between Cygwin terminals and the Windows terminal.
  * Selecting text automatically copies it to the clipboard.
  * Middle click or `Shift-Insert` pastes clipboard contents.
  * Selection works like a standard editor (double click to select words, triple click to select lines, etc).
  * Right click brings up a context menu. You can bring up the program's Options menu from here.
  * Left click moves the cursor around.
  * The terminal is free sizeable. `Alt-Enter` toggles full screen mode.
  * `Shift-PgUp/PgDn` and scrollwheel scrolls.
  
Note that in Cygwin all paths start from `/cygdrive`. So `C:\temp` in Cygwin is `/cygdrive/c/temp`. If you want, you can create symlinks directly your drives like so:

````
ln -s /cygdrive/c /c
````

Now `/c/temp` is a valid path.
  
## cygenv Enhancements
This section describes the features added by the .bashrc in this repo.

### Bash Enhancements
 * Minor spelling errors in a `cd` command are automatically corrected. This also works during tab expansion.
 * You can cd to a directory just by typing a path, i.e.:
 
 ````
 /cygdrive/c/temp
 ````
 
 is equivalent to:
 
  ````
 cd /cygdrive/c/temp
 ````
 
 * You can use `**` in a path or expression in the way globstar works in an Ant script. You can use this to cd down a deep directory structure without typing. For example, if you wanted to cd to `foo/bar/baz/qux`, you can just run:
 
 ````
 cd foo/**/qux/
 ````
 
 will take you there (or to the first hit if there are multiple possibilities).

 Note that you cannot combine this with the previous tip (i.e., you cannot ommit `cd` when using `**`)

 * If you are doing a history search with the Up Arrow for a previously used command, type the first few characters of that command first. Then only the history lines that begin with that text will be scrolled through.
 * `Alt-Left` does a `cd` back through your directory history (similar to going backwards in Explorer). This can be used in conjunction with bash's built in `cd -` command to toggle between the current and previous directories.
 * `Alt-Up` will cd up one level.
 * `Ctrl-Left/Right` moves the cursor over whole words.
 * `Ctrl-Backspace` deletes a word (as does `Ctrl-w`).
 * `Ctrl-Shift-Backspace` deletes to start of line (as does `Ctrl-u`). `Ctrl-k` deletes to end of line.
 * `Alt-Backspace` undos the last delete.
 * `Ctrl-y` pastes the last deleted content.
 * `Home/End` and `Ctrl-a/Ctrl-e` go to the beginning and end of line.

### Enhanced Prompt
After installation, you should have a coloured prompt similar to:

````
--[joebloggs@JBs-Desktop /cygdrive/c/git/myrepo] (master u=)------------------------]--
--[
````

When in a git repo, the prompt displays how far ahead/behind the upstream you are. You can show more info by uncommenting the following lines in the .bashrc file:

````
#GIT_PS1_SHOWDIRTYSTATE=true
#GIT_PS1_SHOWUNTRACKEDFILES=true
````

However on extremely large repos, this can slow down the prompt display.
 
### Git Specific Enhancements
The following is a list of bash aliases to aid Git usage. These are bash aliases, not Git aliases, so you don't need to type `git` in front.

To see the commands in detail, find them in the .bashrc file.

Several of these pipe their output to `less`, which uses vi keybindings. You should know at least these keys to use it properly:

Keys|Action
----|------
`j` / `k`|Down / Up
`Ctrl-f` / `Ctrl-b`|PgDn / PgUp
`/` / `?`|Search forwards / backwards
`n` / `N`|Next / Previous search result
`gg` / `G`|Beginning / End of listing
`q`|Quit

#### Git Aliases
Command|Action
-------|------
glo|One line git log of last 25 commits
gl|Decorated one line git log of full history, with branch tree and colouring, piped to `less`.
glog|Same as `glo`, but not piped to `less`. Add your own scope restricting options as you would to the end of any `git log` command.
cdr|cd to root of git repo
showpush|Lists what commits need to be pushed in current branch
sta|`git status`
push| `git push`
pull|`git pull`
rpull|`pull` with rebase
rpush|Does an `rpull` then `push`
co|`git checkout`
fetch|`git fetch`
commit|`git commit`
chry|`git cherry-pick`
