#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='(\u@\h \W)-> '

# Add aliases
ALIASESPATH="$HOME/.config/aliasrc"
[[ -f $ALIASESPATH ]] && source $ALIASESPATH

# Add functions
FUNCSPATH="$HOME/.config/functions"
[[ -f $FUNCSPATH ]] && source $FUNCSPATH

. "$HOME/.local/share/../bin/env"
