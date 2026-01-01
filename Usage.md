Explanation of built in and added functionality in the .bashrc provided by this repo

# Bash Enhancements
 * Minor spelling errors in a `cd` command are automatically corrected. This also works during tab expansion.
 * `cd` comamnds are NOT case sensitive.
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

# Enhanced Prompt
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

## Git Specific Enhancements
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

### Git Aliases
Command|Action
-------|------
glo|One line git log of last 25 commits
gl|Decorated one line git log of full history, with branch tree and colouring, piped to `less`.
glog|Same as `glo`, but not piped to `less`. Add your own scope restricting options as you would to the end of any `git log` command.
gld|Does a `git log` of the last 4 days work with full commit info, including diffs, piped to `less`. Useful for finding who touched a specific keyword recently. Use the search keys for `less` listed above.
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
gec|Open GitExtensions commit dialog
chry|`git cherry-pick`

