# Enable colors
autoload -U colors && colors

LEFTPROMPT="%B%{$fg[magenta]%}(%{$fg[yellow]%}"
RIGHTPROMPT="%{$fg[blue]%}%1d%{$fg[magenta]%})%{$fg[green]%}->%b "

PROMPTINSERT="$LEFTPROMPT-I-$RIGHTPROMPT"
PROMPTNORMAL="$LEFTPROMPT-N-$RIGHTPROMPT"

# History in cache directory:
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export PATH=${PATH}:"${XDG_DATA_HOME}/npm/bin"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Do not keep duplicate commands in history
setopt HIST_IGNORE_ALL_DUPS
setopt autocd nomatch
setopt append_history # append rather then overwrite
setopt inc_append_history # add history immediately after typing a command


function zle-line-init zle-keymap-select {
    PS1="${${KEYMAP/vicmd/$PROMPTNORMAL}/(main|viins)/$PROMPTINSERT}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
# Move better in history
bindkey -v '^P' down-line-or-search
bindkey -v '^N' up-line-or-search
zle_highlight="(paste:none)"

# Load aliases
ALIASES="$HOME/.config/aliasrc"
[ -f $ALIASES ] && source $ALIASES

# Load functions
FUNCS="$HOME/.config/functions"
[ -f $FUNCS ] && source $FUNCS

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
export PATH=$PATH:/home/garch/.spicetify
