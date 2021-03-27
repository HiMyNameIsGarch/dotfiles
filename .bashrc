#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Add aliases

AliasesPath="$HOME/.config/aliasrc"

if [[ -f $AliasesPath ]]; then
    source $AliasesPath
fi 

