if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  # exec start-hyprland 
  systemctl --user start hyprland
fi

