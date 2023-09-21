# PATH
PATH=/Applications/Sublime\ Text.app/Contents/SharedSupport/bin:$PATH
PATH=/usr/local/pgsql/bin:$PATH        # postres
PATH=$HOME/.local/bin:$PATH            # python site-packages
typeset -U path                        # remove dupes

MANPATH=:/usr/local/pgsql/share/man:$MANPATH

# ENV
export EDITOR='subl -w'                # sublime text
export LESS='-XF'                      # LESS prefs

# PROMPT
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '
# colorized git right-side prompt, color method from:
# https://gist.githubusercontent.com/chrisnolet/d3582cd63eb3d7b4fcb4d5975fd91d04/raw/22b7819fe437f6c46d58eaf48171229fc642bec6/.zshrc
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats " %F{cyan}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats " %F{cyan}%c%u(%b)%f %a"
zstyle ':vcs_info:*' stagedstr "%F{green}"
zstyle ':vcs_info:*' unstagedstr "%F{red}"
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if git --no-optional-locks status --porcelain 2> /dev/null | grep -q "^??"; then
    hook_com[staged]+="%F{red}"
  fi
}
setopt PROMPT_SUBST
RPROMPT=\$vcs_info_msg_0_

# HISTORY
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

# ZSH options
setopt INTERACTIVE_COMMENTS

# ZSH MODULES
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

# FUNCTIONS                              (${ZDOTDIR}/functions)
my_functions=${ZDOTDIR:-$HOME}/functions
if [[ -z ${fpath[(r)$my_functions]} ]] ; then
    fpath=($my_functions $fpath)
    autoload -Uz ${my_functions}/*(:t) # autoload functions
    note                               # init note function
    bindlist                           # init bindlist function
fi
typeset -U fpath                       # remove dupe paths

# load after FUNCTIONS to include custom prompt theme
autoload -U promptinit; promptinit     # prompt theme system

# ALIASES
alias l='ls -F'
alias ll='ls -ahl'
alias h=' fc -li'                      # history w/timestamp
alias rh=' fc -RI'                     # refresh history from other windows
alias cb=' fc -ln -1 | pbcopy'         # copy buffer (last command)
alias config='subl ${ZDOTDIR:-$HOME}/.zshrc'
alias e='subl'
alias cgrep='grep --color=auto'

# BINDINGS
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

# NEW
# try named directories
blog=${HOME}/repos/postgresqlstan.github.io/
z=${ZDOTDIR}
