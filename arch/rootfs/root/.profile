#
# ~/.bashrc
#

# Path
[ -d ${HOME}/.bin ] && export PATH="$PATH:~/.bin"
[ -d ${HOME}/.local/bin ] && export PATH="$PATH:~/.local/bin"
[ -d ${HOME}/bin ] && export PATH="$PATH:~/bin"

# LD Library Path
[ -z "$LD_LIBRARY_PATH" ] && export LD_LIBRARY_PATH="/lib"
for libdir in "/lib64" "$HOME/.lib" "$HOME/.local/lib" "$HOME/lib"
do
    [ -d $libdir ] && export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${libdir}"
done
unset libdir
