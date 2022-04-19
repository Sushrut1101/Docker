#
# ~/.bashrc
#

# Run .profile
if [ -f ~/.profile ]; then
. ~/.profile
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls="ls --color=auto"
alias l="ls -CF"
alias twrpdtgen="python3 -m twrpdtgen"

PS1='[\u@\h \W]\$ '
#PS1="[\u@\h \w]\\$ \[$(tput sgr0)\]"
