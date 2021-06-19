# Enable colors
autoload -U colors && colors

LEFTPROMPT="%B%{$fg[red]%}[%{$fg[magenta]%}%n%{$fg[yellow]%}"
RIGHTPROMPT="%{$fg[green]%}%M %{$fg[blue]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

PROMPTINSERT="$LEFTPROMPT-I-$RIGHTPROMPT" 
PROMPTNORMAL="$LEFTPROMPT-N-$RIGHTPROMPT"  

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

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

export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
