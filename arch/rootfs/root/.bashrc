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

# AIK
cloneaik(){
    if [ -z "$1" ]; then
        local TMP=AIK
    else
        local TMP="$1"
    fi
    git clone --depth=1 --single-branch https://github.com/SebaUbuntu/AIK-Linux-Mirror.git $TMP
}

aik(){
    if [ -z "$2" ]; then
        local IMG="$1"
        local DIR="AIK"
    else
        local IMG="$1"
        local DIR="$2"
    fi
    local CYAN='\033[0;36m'
    local NC='\033[0m'
    echo -e $CYAN"Cloning AIK..."$NC
    cloneaik $DIR || exit
    echo -e $CYAN"Copying the Image..."$NC
    cp $IMG $DIR/ || exit
    echo -e $CYAN"Extracting the image..."$NC
    cd $DIR || exit
    ./unpackimg.sh --nosudo || exit
    cd - || exit
    echo -e $CYAN"Deleting the Copy..."$NC
    rm -rf $DIR/*.img
    echo -e $CYAN"Done!"$NC
}
