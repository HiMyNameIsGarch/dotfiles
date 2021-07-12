# Enable colors
autoload -U colors && colors

LEFTPROMPT="%B%{$fg[magenta]%}(%{$fg[yellow]%}"
RIGHTPROMPT="%{$fg[blue]%}%1d%{$fg[magenta]%})%{$fg[green]%}->%b "

PROMPTINSERT="$LEFTPROMPT-I-$RIGHTPROMPT" 
PROMPTNORMAL="$LEFTPROMPT-N-$RIGHTPROMPT"  

# History in cache directory:
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000

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

# Load aliases
ALIASES="$HOME/.config/aliasrc"
[ -f $ALIASES ] && source $ALIASES
# Load functions
FUNCS="$HOME/.config/functions"
[ -f $FUNCS ] && source $FUNCS

export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
