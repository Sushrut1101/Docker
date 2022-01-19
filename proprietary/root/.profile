# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

if [ -f $HOME/.bin ]; then
  export PATH=$PATH:$HOME/.bin
fi

if [ -f $HOME/.local/bin ]; then
  export PATH=$PATH:$HOME/.local/bin
fi

mesg n 2> /dev/null || true

# twrpdtgen
alias twrpdtgen="python3 -m twrpdtgen"
