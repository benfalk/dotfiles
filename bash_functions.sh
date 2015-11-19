# tmux rename-window
# does some magic using special fonts to spruce up the window name
# requires that the awesome terminal fonts are installed
# https://github.com/gabrielelana/awesome-terminal-fonts
trw(){
  case $1 in
    coding )
      tmux rename-window " ${@:2}";;
    console )
      tmux rename-window " ${@:2}";;
  esac
}
