## PATH - APPEND
PATH=$PATH:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin

## PATH - PREPEND
PATH=/usr/local/pgsql/bin:$PATH        # postres
PATH=$HOME/.local/bin:$PATH            # python site-packages
PATH=$HOME/.rubies/ruby-master/bin:$PATH  # local ruby (3)

typeset -U path                        # remove dupes

MANPATH=:/usr/local/pgsql/share/man:$MANPATH

## ENV
export EDITOR='subl -w'                # sublime text
export LESS='-XF'                      # LESS prefs

## HISTORY
SAVEHIST=49000
HISTSIZE=50000                         # HISTSIZE should be ≥ SAVEHIST
setopt EXTENDED_HISTORY                # include ISO timestamp
setopt HIST_EXPIRE_DUPS_FIRST          # trim dupes 1st if history is full
setopt HIST_FIND_NO_DUPS               # do not display prev found command
setopt HIST_IGNORE_DUPS                # do not save dupe of prev command
setopt HIST_IGNORE_SPACE               # do not save if line starts with space
setopt HIST_NO_STORE                   # do not save history commands
setopt HIST_REDUCE_BLANKS              # strip superfluous blanks
setopt INC_APPEND_HISTORY              # don’t wait for exit to save

## PROMPT: https://starship.rs
export STARSHIP_CONFIG=${ZDOTDIR}/config/starship.toml
eval "$(starship init zsh)"

## ZSH options
setopt INTERACTIVE_COMMENTS
setopt NO_CLOBBER                      # previously too ignorant to need this
setopt nobanghist

## ZSH NAMED DIRETORIES
blog=${HOME}/repos/postgresqlstan.github.io/
z=${ZDOTDIR}

## ZSH MODULES
unalias run-help 2>/dev/null           # don't display err if already done
autoload -Uz run-help                  # run-help
alias help=run-help
HELPDIR="/usr/share/zsh/$(zsh --version | cut -d' ' -f2)/help"

autoload -Uz colors && colors          # colors

autoload -Uz edit-command-line         # edit command line
zle -N edit-command-line
bindkey "^[e" edit-command-line

autoload -Uz compinit                  # completions
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

## FUNCTIONS                            (${ZDOTDIR}/functions)
my_functions=${ZDOTDIR:-$HOME}/functions
if [[ -z ${fpath[(r)$my_functions]} ]] ; then
    fpath=($my_functions $fpath)       # add to $fpath
    autoload -Uz ${my_functions}/*(:t) # autoload functions

    note                               # init note function
    compdef '_path_files -W "${NOTE_HOME:-${HOME}/notes/}" -g "^.*"' note
    compdef _gnu_generic pbnote

    bindlist                           # init bindlist function

fi
typeset -U fpath                       # remove dupe paths

# load after FUNCTIONS to include custom prompt theme
autoload -U promptinit; promptinit     # prompt theme system

## ALIASES
alias l='ls -F'
alias la='ls -AF'
alias ll='ls -ahl'
alias h=' fc -l'                       # history
alias hr=' fc -RI'                     # history refresh from other windows
alias hc=' fc -ln -1 | pbcopy'         # history copy (last command)
alias hd=' fc -li'                     # show EXTENDED_HISTORY (w/timestamp)
alias cgrep='grep --color=always'
alias e='subl'
alias z='subl  ~z'                     # open ~z {ZSHDOTDIR} in editor
alias config='subl ${ZDOTDIR:-$HOME}/.zshrc'

## BINDINGS (still tweaking these...)
# additions
bindkey "^[^K" describe-key-briefly
bindkey "^[k" kill-region
# ⌥m replaces ^@ for set-mark-command:
bindkey "^[m" set-mark-command
bindkey -r "^@"
# ⌥M replaces "^X^X" for exchange-point-and-mark:
bindkey "^[M" exchange-point-and-mark
bindkey -r "^X^X"
# ^Z replaces a few key combos for undo:
bindkey "^Z" undo
bindkey -r "^X^U"
bindkey -r "^Xu"
bindkey -r "^_"
# remove redundant bindings i'll never use:
bindkey -r "^[\$"                      # spell-word
# remove bindings that don't actually work
bindkey -r "^S"
bindkey -r "^Q"


