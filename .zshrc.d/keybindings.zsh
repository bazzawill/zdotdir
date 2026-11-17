# Use emacs keybindings even when EDITOR is set to nvim/vim
bindkey -e

# Ensure Home and End keys work across terminals and tmux in all keymaps
[[ -v terminfo ]] || zmodload zsh/terminfo

typeset -a _home_keys=(
  "$terminfo[khome]"  # terminfo Home
  "$terminfo[kfnd]"   # terminfo Find (VT220 Home)
  '\e[H'              # xterm / ANSI normal mode
  '\eOH'              # xterm / application cursor mode (DECCKM)
  '\e[1~'             # VT220 / Linux console / tmux / screen
  '\eO1~'             # VT220 SS3 variant
  '\e[7~'             # rxvt / urxvt
  '\eO7~'             # rxvt SS3 variant
  '\eOw'              # rxvt application keypad Home
  '\e[214z'           # Sun keyboard Home
  '\e[57360u'         # CSI u / Kitty keypad Home
  '\e[1;1H'           # xterm explicit unmodified
  '\e[1;2H' '\e[1;3H' '\e[1;5H' '\e[1;6H' # xterm Shift/Alt/Ctrl/Ctrl+Shift + Home
  '\e[1;2~' '\e[1;3~' '\e[1;5~' '\e[1;6~' # VT/tmux Shift/Alt/Ctrl/Ctrl+Shift + Home
  '\e[7$'   '\e[7^'   '\e[7@'             # rxvt Shift/Ctrl/Ctrl+Shift + Home
)

typeset -a _end_keys=(
  "$terminfo[kend]"   # terminfo End
  "$terminfo[kslt]"   # terminfo Select (VT220 End)
  '\e[F'              # xterm / ANSI normal mode
  '\eOF'              # xterm / application cursor mode (DECCKM)
  '\e[4~'             # VT220 / Linux console / tmux / screen
  '\eO4~'             # VT220 SS3 variant
  '\e[8~'             # rxvt / urxvt
  '\eO8~'             # rxvt SS3 variant
  '\eOq'              # rxvt application keypad End
  '\e[220z'           # Sun keyboard End
  '\e[57367u'         # CSI u / Kitty keypad End
  '\e[1;1F'           # xterm explicit unmodified
  '\e[1;2F' '\e[1;3F' '\e[1;5F' '\e[1;6F' # xterm Shift/Alt/Ctrl/Ctrl+Shift + End
  '\e[4;2~' '\e[4;3~' '\e[4;5~' '\e[4;6~' # VT/tmux Shift/Alt/Ctrl/Ctrl+Shift + End
  '\e[8$'   '\e[8^'   '\e[8@'             # rxvt Shift/Ctrl/Ctrl+Shift + End
)

for _keymap in emacs viins vicmd; do
  for _key in "${_home_keys[@]}"; do
    [[ -n "$_key" ]] && bindkey -M "$_keymap" "$_key" beginning-of-line
  done
  for _key in "${_end_keys[@]}"; do
    [[ -n "$_key" ]] && bindkey -M "$_keymap" "$_key" end-of-line
  done
done
unset _keymap _key _home_keys _end_keys
