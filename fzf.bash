# Setup fzf
# ---------
if [[ ! "$PATH" == */home/bfalk/.fzf/bin* ]]; then
  export PATH="$PATH:/home/bfalk/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/bfalk/.fzf/man* && -d "/home/bfalk/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/bfalk/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/bfalk/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
#source "/home/bfalk/.fzf/shell/key-bindings.bash"

fh(){
  phrase=$(history | fzf-tmux -d 15 | sed 's/ *[0-9]* *//')
  if [ -z "$phrase" ]; then
    return
  fi
  echo $phrase
  eval $phrase
  return $?
}
