# cygenv basic .bashrc

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# cd to a directory jusy by typing the path
shopt -s autocd

# If set, Bash attempts spelling correction on directory names during word completion
# if the directory name initially supplied does not exist.
shopt -s dirspell

# The pattern ‘**’ used in a filename expansion context will match all files and zero or
# more directories and subdirectories. If the pattern is followed by a ‘/’, only
# directories and subdirectories match.
# For example, 'cd **/*.App' will 
shopt -s globstar

# Bash will not attempt to search the PATH for possible completions when completion is
# attempted on an empty line.
shopt -s no_empty_cmd_completion

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
 [[ -f /etc/bash_completion ]] && . /etc/bash_completion

 [[ -f ~/cygenv-files/git-completion.sh ]] && . ~/cygenv-files/git-completion.sh

# History Options
#
# Don't put duplicate lines in the history.
 export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
export HISTIGNORE="&:[ \t]:l[sl]:[bf]g:exit"

# Aliases
#
# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
 alias df='df --si'
 alias du='du -si'
#
# alias whence='type -a'                        # where, of a sort
#
# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#

# Remember directory stack
alias cd="pushd .>/dev/null;cd"
alias pd="popd>/dev/null"

# Colors for a black terminal
export LS_COLORS="di=01;37"

# Search history for commands that start with what you have typed
bind '"[A":history-search-backward'
bind '"[B":history-search-forward'

# Ctrl+Left/Right to move by whole words
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'

# Ctrl+Backspace/Delete to delete whole words
bind '"\e[3;5~": kill-word'
bind '"\C-_": backward-kill-word'

# Ctrl+Shift+Backspace/Delete to delete to start/end of the line
bind '"\e[3;6~": kill-line'
bind '"\xC2\x9F": backward-kill-line'

# Alt-Backspace for undo delete
# Ctrl-w also does this
bind '"\e\d": undo'

# Update COLUMNS and LINES variables
shopt -s checkwinsize

# Fancy prompt
if [ -f ~/cygenv-files/git-prompt.sh ];
then
    . ~/cygenv-files/git-prompt.sh
    GIT_PS1_SHOWCOLORHINTS=true
    #GIT_PS1_SHOWDIRTYSTATE=true
    #GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="verbose"
    PROMPT_COMMAND='__git_ps1 "\n--[\u@\h \w"] "]--\n--[ "'
fi

# Start gvim with converted paths
g () {
    cygstart /cygdrive/c/Program\ Files\ \(x86\)/Vim/vim73/gvim `cygpath -w $@`
}

alias ld="ls --color=tty"
alias ls="ls --color=tty"
# alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'                            #

bind 'set completion-ignore-case on'

alias fgrep="fgrep --exclude-dir={\.svn,\.git} --color=always"
alias grep="grep --exclude-dir={\.svn,\.git} --color=always"

# git aliases
alias glog="git log --graph --decorate --pretty=oneline --abbrev-commit --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%n' --color"
alias gl="glog | less -R"
alias glo="git log --oneline -25 --color"
alias sta="git status"
alias rpull="git pull --rebase"
alias rpush="rpull && git push"
alias co="git checkout"
alias fetch="git fetch"
alias commit="git commit"

# Use git colours when paging
alias less="less -R"

export TERM=cygwin

cd /cygdrive/c

# Remember to:
# set CYGWIN=nodosfilewarning in the global environment
# git config --global push.default current

